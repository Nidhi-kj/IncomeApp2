//
//  ContentView.swift
//  IncomeApp2
//
//  Created by Nidhi Jha on 09/04/25.
//

import SwiftUI

struct HomeView: View {
    @State private var transactions: [Transaction] = [
        Transaction(title: "Apple", type: .expense, amount: 500, date:Date()),
        Transaction(title: "Apple", type: .expense, amount: 500, date:Date())
        
        ]
    
    var body: some View {
        VStack {
            List{
                ForEach(transactions) { transaction  in
                    TransactionView(transaction: transaction)
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
  HomeView()
}

struct TransactionView: View {
    let transaction:  Transaction
    var body: some View {
        VStack {
            HStack{
                Spacer()
                //Text("\(transaction.date)")
                Text(transaction.displayDate)
                    .font(.system(size: 16))
                Spacer()
            }
            .padding(.vertical, 5)
            .background(Color.lightGrayShade.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            
            HStack{
                Image(systemName: transaction.type == .income ? "arrow.up.forward" :  "arrow.down.forward")
                    .font(.system(size: 20, weight : .bold))
                    .foregroundStyle(transaction.type == .income ? Color.green : Color.red)
                
                
                VStack(alignment: .leading,spacing: 10) {
                    HStack{
                        
                        Text(transaction.title)
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                        
                        Text(String(transaction.displayAmount))
                            .font(.system(size: 20,weight: .bold))
                    }
                    Text("completed")
                        .font(.system(size: 15,weight: .bold))
                    
                }
            }
        }
        // Text(transaction.title)
        .listRowSeparator(.hidden)
    }
}
