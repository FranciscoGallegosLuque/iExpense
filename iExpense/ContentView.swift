//
//  ContentView.swift
//  iExpense
//
//  Created by Francisco Manuel Gallegos Luque on 25/01/2025.
//
import Observation
import SwiftData
import SwiftUI

//@Observable
//class User {
//    var firstName = "Bilbo"
//    var lastName = "Baggins"
//}
//
//struct ContentView: View {
//    @State private var user = User()
//
//    var body: some View {
//            VStack {
//                Text("Your name is \(user.firstName) \(user.lastName).")
//
//                TextField("First name", text: $user.firstName)
//                TextField("Last name", text: $user.lastName)
//            }
//        }
//}

//struct SecondView: View {
//    @Environment(\.dismiss) var dismiss
//    let name: String
//    
//    var body: some View {
//        Text("Hello \(name)")
//        Button("Dismiss") {
//            dismiss()
//        }
//    }
//}

//struct ContentView: View {
//    @State private var showingSheet = false
//    
//    var body: some View {
//        Button("Show sheet") {
//            showingSheet.toggle()
//        }
//        .sheet(isPresented: $showingSheet) {
//            SecondView(name: "Francisco")
//        }
//    }
//}

//struct ContentView: View {
//    @State private var numbers = [Int]()
//    @State private var currentNumber = 1
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                List {
//                    ForEach(numbers, id: \.self) {
//                        Text("Row \($0)")
//                    }
//                    .onDelete(perform: removeRows)
//                }
//                
//                Button("Add Number") {
//                    numbers.append(currentNumber)
//                    currentNumber += 1
//                }
//            }
//            .toolbar {
//                EditButton()
//            }
//        }
//    }
//    
//    func removeRows(at offsets: IndexSet) {
//        numbers.remove(atOffsets: offsets)
//    }
//}
//struct User: Codable {
//    let firstName: String
//    let lastName: String
//}

//struct ContentView: View {
//
//
//    
//    @AppStorage("tapCount") private var tapCount = 0
//
//
//       var body: some View {
//           Button("Tap count: \(tapCount)") {
//               tapCount += 1
//
//           }
//       }
//}

//struct ContentView: View {
//    @State private var user = User(firstName: "Taylor", lastName: "Swift")
//    
//    var body: some View {
//        Button ("Save User"){
//            let encoder = JSONEncoder()
//            
//            if let data = try? encoder.encode(user) {
//                UserDefaults.standard.set(data, forKey: "UserData")
//            }
//        }
//    }
//    
//}






struct ContentView: View {
//    @Bindable private var expenses = Expenses()
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
//    @State private var showingAddExpense = false
    @State private var expenseTypeShowed = ""
    
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount)
    ]
    
    
    var body: some View {
        NavigationStack {
            ExpenseView(expenseType: expenseTypeShowed, sortOrder: sortOrder)
            //            List {
            //
            //                ForEach(expenses) { expense in
            //                    HStack {
            //                        VStack(alignment: .leading) {
            //                            Text(expense.name)
            //                                .font(.headline)
            //
            //
            //                            Text(expense.type)
            //                        }
            //
            //                        Spacer()
            //
            //                        Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            //                            .fontWeight(expense.amount < 10 ? .light : (expense.amount < 100) ? Font.Weight.regular : .bold)
            //                    }
            //                }
            //                .onDelete(perform: removeItems)
            
            
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
            
                .navigationTitle("iExpense")
                .toolbar {
                    NavigationLink ("Add expense") {
                        AddView()
                    }
                    

                    
                    Menu("Sort", systemImage: "line.3.horizontal.decrease.circle.fill") {
                        Picker("Filter", selection: $expenseTypeShowed) {
                            Text("Show only Personal expenses")
                                .tag("Personal")
                            
                            Text("Show only Business expenses")
                                .tag("Business")
                            
                            Text("Remove filters")
                                .tag("")
                        }
                    }
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\ExpenseItem.name),
                                    SortDescriptor(\ExpenseItem.amount)
                                ])
                            
                            Text("Sort by Amount")
                                .tag([
                                    SortDescriptor(\ExpenseItem.amount),
                                    SortDescriptor(\ExpenseItem.name)
                                ])
                        }
                    }
                    .navigationBarBackButtonHidden()
                    //                Button("Add expense", systemImage: "plus") {
                    //                    showingAddExpense = true
                    //                }
                }
            //            .sheet(isPresented: $showingAddExpense) {
            //                AddView(expenses: expenses)
            //            }
        }
    }
    
    
    
//    func removePersonalItems(at offsets: IndexSet) {
//        removeItems(at: offsets, in: expenses.filter({ $0.type == "Personal" }))
//    }
//
//    func removeBusinessItems(at offsets: IndexSet) {
//        removeItems(at: offsets, in: expenses.filter( {$0.type == "Business"} ))
//    }
    
    
}

#Preview {
    ContentView()
}
