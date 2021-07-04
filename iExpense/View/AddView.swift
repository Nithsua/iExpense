//
//  AddView.swift
//  iExpense
//
//  Created by Nivas Muthu M G on 04/07/21.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = types[1]
    @State private var amount = ""
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter Name", text: $name)
                
                Picker(selection: $type, label: Text("Type")) {
                    ForEach(AddView.types, id:\.self) {
                        Text($0)
                    }
                }
//                .pickerStyle(WheelPickerStyle())
                
                TextField("Enter Amount", text:$amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add New Expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(amount) {
                    expenses.items.append(ExpenseItem(id: UUID(), name: name, type: type, amount: actualAmount))
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
