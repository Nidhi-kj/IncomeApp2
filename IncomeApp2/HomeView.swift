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
    @State private var showAddTransactionView = false
    @State private var transactionToEdit: Transaction?
	
    fileprivate func FloatingButton() -> some View {
        VStack{
            Spacer()
            NavigationLink {
                AddTransactionView(transactions: $transactions)
            } label:{
                Text("+")
                    .font(.largeTitle)
                    .frame(width: 80, height: 80)
                    .foregroundStyle(Color.white)
            }
            .background(Color.purple)
            .clipShape(Rectangle())
        }
        
    }
    fileprivate func BalanceView() -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.primaryLightGreen)
            
            
            VStack(alignment: .leading,spacing: 8){
                HStack{
                    VStack{
                        
                        Text("Balance")
                        // .font(.caption)
                            .font(.system(size: 20,weight: .bold))
                            .foregroundStyle(Color.white)
                        Text(" ₹600")
                            .font(.system(size: 45,weight: .light))
                            .foregroundStyle(Color.white)
                    }
                    Spacer()
                }
                .padding(.top)
                
                HStack(spacing:30){
                    VStack(alignment: .leading){
                        Text("Expenses")
                            .font(.system(size: 15,weight: .semibold))
                            .foregroundStyle(Color.white)
                        Text("₹200")
                            .font(.system(size: 15,weight: .regular))
                            .foregroundStyle(Color.white)
                    }
                    VStack(alignment: .leading){
                        Text("Income")
                            .font(.system(size: 15,weight: .semibold))
                            .foregroundStyle(Color.white)
                        Text("₹200")
                            .font(.system(size: 15,weight: .regular))
                            .foregroundStyle(Color.white)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        .frame(height: 150)
        .padding(.horizontal)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    BalanceView()
                    List{
                        ForEach(transactions) { transaction  in
                            Button(action: {
                                //showAddTransactionView = true
                                transactionToEdit = transaction
                            },label: {
                                
                                TransactionView(transaction: transaction)
                                    .foregroundStyle(.black)
                            })
                            
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
				.padding(.bottom, 100)
                
                FloatingButton()
            }
            .navigationTitle("Income")
			// edit
            .navigationDestination(item: $transactionToEdit,
                                   destination: {  transactionToEdit in
                AddTransactionView(transactions: $transactions,   transactionToEdit: transactionToEdit)
            })
			// create
            .navigationDestination(isPresented: $showAddTransactionView, destination: {
                AddTransactionView(transactions: $transactions)
            })
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(Color.purple)
                    })
                }
            }
        }
    }
}
#Preview {
  HomeView()
}

