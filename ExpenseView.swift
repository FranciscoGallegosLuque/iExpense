//
//  ExpenseView.swift
//  iExpense
//
//  Created by Francisco Manuel Gallegos Luque on 19/02/2025.
//

import SwiftUI
import SwiftData

struct ExpenseView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    
    var body: some View {
        List {
            ForEach(expenses) { expense in
                HStack {
                    VStack(alignment: .leading) {
                        Text(expense.name)
                            .font(.headline)
                        Text(expense.type)
                    }
                    Spacer()
                    Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .fontWeight(expense.amount < 10 ? .light : (expense.amount < 100) ? Font.Weight.regular : .bold)
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("\(expense.name), costs \(expense.amount)")
                .accessibilityHint(expense.type)
            }
            .onDelete(perform: removeItems)
    
            
//                if (expenses.count { $0.type == "Business" } != 0) {
//                    Section ("Business expenses"){
//                        ForEach(expenses.filter { $0.type == "Business" }) { expense in
//                            HStack {
//                                VStack(alignment: .leading) {
//                                    Text(expense.name)
//                                        .font(.headline)
//
//
//                                    Text(expense.type)
//                                }
//
//                                Spacer()
//
//                                Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//                                    .fontWeight(expense.amount < 10 ? .light : (expense.amount < 100) ? Font.Weight.regular : .bold)
//                            }
//                        }
//                        .onDelete(perform: removeBusinessItems)
//                    }
//                }
            
//                if (expenses.count { $0.type == "Personal" } != 0) {
//                    Section ("Personal expenses"){
//                        ForEach(expenses.filter { $0.type == "Personal" }) { expense in
//                            HStack {
//                                VStack(alignment: .leading) {
//                                    Text(expense.name)
//                                        .font(.headline)
//
//
//                                    Text(expense.type)
//                                }
//
//                                Spacer()
//
//                                Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//                                    .fontWeight(expense.amount < 10 ? .light : (expense.amount < 100) ? Font.Weight.regular : .bold)
//                            }
//                        }
//                        .onDelete(perform: removePersonalItems)
//                    }
//
//                }
        }
    }
    
    init(expenseType: String, sortOrder: [SortDescriptor<ExpenseItem>]) {
        _expenses = Query(filter: #Predicate<ExpenseItem> { expense in
            if (expenseType == "") {
                return true
            } else {
                return (expense.type == expenseType)
            }
        }, sort: sortOrder)
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }
}

#Preview {
    ExpenseView(expenseType: "Personal", sortOrder: [SortDescriptor(\ExpenseItem.name)])
        .modelContainer(for: ExpenseItem.self)
}
