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


struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]()
}

struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
