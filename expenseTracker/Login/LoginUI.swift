//
//  LoginUI.swift
//  ExpenseTracker
//
//  Created by Admin on 16/11/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginUI: View {
    
    @StateObject var loginVM = LoginViewModel()
    @State private var isCountryListPresented = false
    @State private var isCodeSent = false
    @State private var animate = false
    @State private var selectedCountryCode: String? = nil
    @State private var otp: String = ""
    @State private var selectedCountry: String? = nil
    @State private var verificationId = ""
    @AppStorage("isLoginScreenVisible")
    var isLoginScreenVisible: Bool?
    
    var body: some View {
        
            VStack {
                Text("Login")
                    .font(.title)
                    .bold()
                    .foregroundColor(.textColor)
                Spacer()
                
                if !isCodeSent {
                    
                    Text("Enter your Phone Number to Proceed")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.textColor)
                        .multilineTextAlignment(.leading)
                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                        .opacity(isCodeSent ? 0 : 1)
                        .offset(x: isCodeSent ? -UIScreen.main.bounds.width : 0)
                        .animation(.easeInOut)
                } else {
                    Text("+\(countryCodeList[selectedCountryCode ?? "India"] ?? "") \(loginVM.phoneNumber)")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.textColor)
                        .multilineTextAlignment(.leading)
                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                        .opacity(isCodeSent ? 0 : 1)
                        .offset(x: isCodeSent ? -UIScreen.main.bounds.width : 0)
                        .animation(.easeInOut)
                }
                
                
                SwiftLottieAnimation(url: Bundle.main.url(forResource: "login", withExtension: "lottie")!, loopMode: .loop)
                    .scaleEffect(2)
                
                
                
                Text("You will receive a code !")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.textColor)
                
                Spacer()
                
                
                if !isCodeSent {
                    HStack(alignment: .center) {
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Enter here")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.textColor)
                            
                            HStack {
                                
                                HStack {
                                    
                                    Text(selectedCountryCode ?? "Country")
                                        .foregroundColor(.textColor)
                                        .padding()
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                        .sheet(isPresented: $isCountryListPresented, content: {
                                            CountryListTest(selectedCountryCode: $selectedCountryCode, selectedCountry: $selectedCountry, isCountryListPresented: $isCountryListPresented)
                                            
                                        })
                                        .onTapGesture {
                                            isCountryListPresented.toggle()
                                        }
                                    
                                    TextField("Enter number here", text: $loginVM.phoneNumber)
                                        .padding()
                                        .keyboardType(.phonePad)
                                        .foregroundColor(.textColor)
                                    
                                    
                                }
                                
                                
                            }
                        }
                        
                        Spacer(minLength: 5)
                        
                    }
                    .shadow(color: .background.opacity(0.5), radius: 5, x: 0, y: -5)
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                    .opacity(isCodeSent ? 0 : 1)
                    .offset(x: isCodeSent ? -UIScreen.main.bounds.width : 0)
                    .animation(.easeInOut)
                } else {
                    HStack(alignment: .center) {
                        
                        TextField("Enter code now", text: $otp)
                            .padding()
                            .keyboardType(.phonePad)
                            .foregroundColor(.textColor)
                        
                        Spacer(minLength: 5)
                        
                    }
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                    .opacity(isCodeSent ? 1 : 0)
                    .offset(x: !isCodeSent ? -UIScreen.main.bounds.width : 0)
                    .animation(.easeInOut)
                    
                }
                
                Spacer()
                
                
                Button {
                    if !isCodeSent {
                        PhoneAuthProvider.provider()
                            .verifyPhoneNumber("+91\(loginVM.phoneNumber)", uiDelegate: nil) { verificationID, error in
                                if error != nil {
                                    dump("+91\(loginVM.phoneNumber)")
                                    dump(error)
                                    self.verificationId = verificationID ?? ""
                                    return
                                }
                                self.verificationId = verificationID ?? ""
                            }
                        isCodeSent.toggle()
                        animate.toggle()
                    } else {
                        let credentials = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: otp)
                        
                        Auth.auth().signIn(with: credentials) { (authResult, error) in
                            
                            if error != nil {
                                dump("Signing error \(String(describing: error?.localizedDescription))")
                                return
                            }
                            
                            print(authResult ?? "")
                            isLoginScreenVisible = false
                        }
                    }
                } label: {
                    Text(isCodeSent ? "Login" : "Get Code")
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.blue, lineWidth: 2)
                        )
                    
                        .font(.system(size: 13))
                        .foregroundColor(.textColor)
                  
                    
                    
                }
                
                Spacer()
                
                
                
            }
            .accentColor(.textColor)
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .cornerRadius(25)
            .navigationBarHidden(true)
            .background(.background)
        
       
        
        
    }
    
}

struct LoginUI_Previews: PreviewProvider {
    @StateObject var loginVM = LoginViewModel()
    static var previews: some View {
        NavigationView {
            LoginUI()
        }
    }
}

