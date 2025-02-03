//
//  ContentView.swift
//  iExpense
//
//  Created by Francisco Manuel Gallegos Luque on 25/01/2025.
//
import Observation
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


struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var personalItems: [ExpenseItem] {
        items.filter { $0.type == "Personal" }
    }

    var businessItems: [ExpenseItem] {
        items.filter { $0.type == "Business" }
    }
    
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
        
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    
//    @State private var showingAddExpense = false
    
    
    var body: some View {
        NavigationStack {
            List {
                if (expenses.items.count { $0.type == "Business" } != 0) {
                    Section ("Business expenses"){
                        ForEach(expenses.items.filter { $0.type == "Business" }) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    
                                    Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .fontWeight(item.amount < 10 ? .light : (item.amount < 100) ? Font.Weight.regular : .bold)
                            }
                        }
                        .onDelete(perform: removeBusinessItems)
                    }
                    
                }
                
                if (expenses.items.count { $0.type == "Personal" } != 0) {
                    Section ("Personal expenses"){
                        ForEach(expenses.items.filter { $0.type == "Personal" }) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    
                                    Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .fontWeight(item.amount < 10 ? .light : (item.amount < 100) ? Font.Weight.regular : .bold)
                            }
                        }
                        .onDelete(perform: removePersonalItems)
                    }
                    
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink ("Add expense") {
                        AddView(expenses: expenses)
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
    
    func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
        var objectsToDelete = IndexSet()

        for offset in offsets {
            let item = inputArray[offset]

            if let index = expenses.items.firstIndex(of: item) {
                objectsToDelete.insert(index)
            }
        }

        expenses.items.remove(atOffsets: objectsToDelete)
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.personalItems)
    }

    func removeBusinessItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.businessItems)
    }
    
    
}

#Preview {
    ContentView()
}
