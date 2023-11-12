//
//  ContentView.swift
//  fold
//
//  Created by Admin on 11/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .renderingMode(.original)
                        .foregroundStyle(Color.iconColor, .primary)
                    
                }
            }
        }
        .navigationViewStyle(.stack)
        
    }
}

struct ContentView_Previews_Light: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentView_Previews_Dark: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
