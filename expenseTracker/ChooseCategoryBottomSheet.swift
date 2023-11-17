//
//  ChooseCategoryBottomSheet.swift
//  ExpenseTracker
//
//  Created by Admin on 17/11/23.
//

import SwiftUI
import SwiftUIFontIcon

struct ChooseCategoryBottomSheet: View {
    
    @Binding var isSelected: Bool
    @Binding var selectedCategoryId: Category?
    
    var body: some View {
        List(Category.all, id: \.id) {category in
          
                Button {
                    isSelected.toggle()
                    selectedCategoryId = category
                } label: {
                    HStack {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.iconColor.opacity(0.3))
                            .frame(width: 44, height: 44)
                            .overlay {
                                FontIcon.text(FontCode.awesome5Solid(code: category.icon), fontsize: 20
                                              ,color: .iconColor)
                            }
                        
                        
                        Text(category.name.uppercased())
                            .foregroundColor(.textColor)
                            .font(.subheadline)
                            .bold()
                            .padding()
                    }

            }
            
        }
    }
}

//struct ChooseCategoryBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        ChooseCategoryBottomSheet(isSelected: .constant(false), selectedCategoryId: .constant())
//    }
//}
