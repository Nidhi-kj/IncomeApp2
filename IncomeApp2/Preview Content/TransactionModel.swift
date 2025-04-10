//
//  TransactionModel.swift
//  IncomeApp2
//=
//  Created by Nidhi Jha on 09/04/25.
//

import Foundation
struct Transaction: Identifiable{
    
    let id = UUID()
    let title: String
    let type: TranactionType
    let amount: Double
    let date: Date
    var displayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
        
    }
    var displayAmount: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: amount as NSNumber) ?? "Rs. 0.00"
    }
    
}
