//
//  CreateTransaction.swift
//  ExpenseTracker
//
//  Created by Admin on 17/11/23.
//

import SwiftUI
import SwiftUIFontIcon

struct CreateTransaction: View {
    
    @State private var merchant = ""
    @State private var account = ""
    @State private var amount = 0
    @State private var institution = ""
    @State private var isCategorySelected = false
    @State private var selectedCategory: Category? = nil
    
    @State private var isPending = false
    @State private var isTransfer = false
    @State private var isExpense = false
    @State private var isEdited = false
    
    @State private var date = Date()
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            VStack {
                Form {
                    Section {
                        TextField("Enter Merchant name", text: $merchant)
                            .foregroundColor(.iconColor)
                        TextField("Enter Account name", text: $account)
                            .foregroundColor(.iconColor)
                        TextField("Enter Institution name", text: $institution)
                            .foregroundColor(.iconColor)
                    } header: {
                        Text("Transactions Info")
                    }
                    
                    Section {
                        HStack {
                            if (selectedCategory == nil) {
                                HStack {
                                    
                                    FontIcon.text(FontCode.materialIcon(code: .add), fontsize: 25
                                                  ,color: .iconColor)
                                    
                                    Text("Choose Category")
                                        .foregroundColor(.textColor)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .onTapGesture {
                                            isCategorySelected.toggle()
                                        }
                                        .padding()
                                }
                            }
                            if !(selectedCategory == nil) {
                                HStack {
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .fill(Color.iconColor.opacity(0.3))
                                        .frame(width: 44, height: 44)
                                        .overlay {
                                            FontIcon.text(FontCode.awesome5Solid(code: selectedCategory?.icon ?? .tags), fontsize: 20
                                                          ,color: .iconColor)
                                        }
                                    
                                    
                                    Text(selectedCategory?.name.uppercased() ?? "Taxi")
                                        .foregroundColor(.textColor)
                                        .font(.subheadline)
                                        .bold()
                                        .padding()
                                }
                                .onTapGesture {
                                    isCategorySelected.toggle()
                                }
                            }
                            
                            
                            
                            
                        }
                        .sheet(isPresented: $isCategorySelected) {
                            ChooseCategoryBottomSheet(isSelected: $isCategorySelected, selectedCategoryId: $selectedCategory)
                        }
                        
                    } header: {
                        Text("Category")
                    }
                    
                    Section {
                        Toggle(isOn: $isPending) {
                            Text("Is Pending")
                                .foregroundColor(.textColor)
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding(.all, 5)
                        .tint(.iconColor)
                        
                        Toggle(isOn: $isTransfer) {
                            Text("Is Transfer")
                                .foregroundColor(.textColor)
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding(.all, 5)
                        .tint(.iconColor)
                        
                        Toggle(isOn: $isExpense) {
                            Text("Is Expense")
                                .foregroundColor(.textColor)
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding(.all, 5)
                        .tint(.iconColor)
                        
                        Toggle(isOn: $isEdited) {
                            Text("Is Edited")
                                .foregroundColor(.textColor)
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding(.all, 5)
                        .tint(.iconColor)
                        
                    } header: {
                        Text("Choose Type")
                    }
                    
                    Section {
                        DatePicker("Choose Date", selection: $date, displayedComponents: .date)
                            .foregroundColor(.iconColor)
                        
                        TextField("Enter your score", value: $amount, format: .number)
                            .foregroundColor(.iconColor)
                        
                    } header: {
                        Text("Amount & Date")
                    }
                    .padding(.all, 5)
                    
                    
                    
                    
                }
                
                
            }
            
            Spacer()
            
            HStack(alignment: .center) {
                
                Button {
                    
                } label: {
                    Text("Save")
                        .foregroundColor(.textColor)
                        .font(.title3)
                }
                .buttonStyle(.bordered)
                .background(.background)

                
            }
        }
    }
}

struct CreateTransaction_Previews: PreviewProvider {
    static var previews: some View {
        CreateTransaction()
    }
}