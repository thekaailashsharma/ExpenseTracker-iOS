//
//  TransactionRow.swift
//  fold
//
//  Created by Admin on 12/11/23.
//

import Foundation
import SwiftUI
import SwiftUIFontIcon
import CoreData

struct TransactionRow: View {
    
    var transaction: Transaction = TransactionPreviewData
    @State var fontIcon: FontAwesomeCode
    @State var merchant: String
    @State var category: String
    @State var dateParsed: Date
    @State var signedAmount: Int
    
    
    var body: some View {
        HStack(spacing: 20) {

            
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.iconColor.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay {
                    FontIcon.text(FontCode.awesome5Solid(code: fontIcon), fontsize: 20
                                  ,color: .iconColor)
                }

            
            
            VStack(alignment: .leading, spacing: 6) {
                Text(merchant)
                    .foregroundColor(.textColor)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                Text(category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                    
                Text(dateParsed, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(signedAmount, format: .currency(code: "USD"))
                .foregroundColor(transaction.type == TransactionType.credit.rawValue ? Color.textColor : .primary)
                .bold()
        }
        .padding([.top, .bottom], 8)
        .padding([.horizontal], 8)
    }
}

//struct TransactionRow_Preview: PreviewProvider {
//    static var previews: some View {
//        TransactionRow(transaction: TransactionPreviewData)
//    }
//}
//
//struct TransactionRow_Preview_dark: PreviewProvider {
//    static var previews: some View {
//        TransactionRow(transaction: TransactionPreviewData)
//    }
//}
