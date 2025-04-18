//
//  AddTransactionView.swift
//  IncomeApp2
//
//  Created by Nidhi Jha on 15/04/25.
//

import SwiftUI

struct AddTransactionView: View{
   
    
    @State private var amount = 0.00
    @State private var selectedTransactionType: TransactionType = .expense
    @State private var transactionTitle = ""
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @Binding var transactions : [Transaction]
    var transactionToEdit : Transaction?
    
    @Environment(\.dismiss)var dismiss
    
    //let arrayOfCases: [TransactionType] = [TransactionType.expense, TransactionType.income]
    var numberFormatter: NumberFormatter {
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = .currency
        return numberFormater
    }
    
    var body: some View {
        VStack{
           // TextField("0.00", text: $amount)
            TextField("0.00", value: $amount, formatter: numberFormatter)
                .font(.system(size: 50,weight: .semibold))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            Rectangle()
                .fill(Color(uiColor: UIColor.lightGray))
                .frame(height: 0.5)
                .padding(.horizontal, 30)
            Picker("chosse type", selection: $selectedTransactionType) {
//                Text("Income")
//                Text("Expense")
                ForEach(TransactionType.allCases) {transactionType in
                    Text(transactionType.title)
                        .tag(transactionType)
                    
                }
            }
            TextField("Title", text: $transactionTitle)
                .font(.system(size: 20))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal,30)
                .padding(.top)
            Button(action: {
                guard transactionTitle.count >= 2 else {
                    alertTitle = "Invalid Title"
                    alertMessage = "Title must be at least 2 characters long"
                    showAlert = true
                    return
                }
                let transaction = Transaction(title: transactionTitle, type: selectedTransactionType, amount: amount, date: Date())
                
              //  let index = transactions.firstIndex {transaction in
               //     self.transactionToEdit?.id == transaction.id
                    
              //  }
                if let transactionToEdit = transactionToEdit
                   //let index  = transactions.firstIndex(of: transactionToEdit)
                {
                    guard  let indexOfTransaction  = transactions.firstIndex(of: transactionToEdit) else
                    {
                        alertTitle = "something went wrong "
                        alertMessage = "cannot update this transaction right now "
                        showAlert = true
                        return
                    }
                    transactions[indexOfTransaction] = transaction
                    
                } else {
                    transactions.append(transaction)
                }
                dismiss()
                
            }, label: {
                Text( transactionToEdit == nil ? "Create" : "update" )
                    .font(.system(size: 15,weight: .semibold))
                    .foregroundStyle(Color.white)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryLightGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            })
                    .padding(.top)
                    .padding(.horizontal,30)
                    Spacer()
        }
        .onAppear(perform: {
            if let transactionToEdit = transactionToEdit {
                amount = transactionToEdit.amount
                transactionTitle = transactionToEdit.title
                selectedTransactionType = transactionToEdit.type
            }
        })
        .padding(.top)
        .alert(alertTitle, isPresented: $showAlert)
        {
            Button(action: {
                
            }, label: {
                Text("OK")
            })
        } message: {
            Text(alertMessage)
        }
        
    }
}

#Preview {
    AddTransactionView(transactions: .constant([]))
}
