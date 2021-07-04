//
//  ContentView.swift
//  iExpense
//
//  Created by Nivas Muthu M G on 04/07/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.title3)
                            Text(item.type)
                                .font(.caption)
                        }
                        Spacer()
                        Text("$\(item.amount)")
                    }
                }
                .onDelete(perform: removeItem)
            }
            .navigationTitle("iExpense")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                showAddExpense = true
                }){
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showAddExpense, content: {
                AddView(expenses: expenses)
            })
        }
    }
    
    func removeItem(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
