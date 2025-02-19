//
//  Expenses.swift
//  iExpense
//
//  Created by Francisco Manuel Gallegos Luque on 19/02/2025.
//

//import Foundation
//import SwiftData
//
//@Model
//class Expenses {
//    var personalItems: [ExpenseItem] {
//        items.filter { $0.type == "Personal" }
//    }
//
//    var businessItems: [ExpenseItem] {
//        items.filter { $0.type == "Business" }
//    }
//    
//    var items = [ExpenseItem]() {
//        didSet {
//            if let encoded = try? JSONEncoder().encode(items) {
//                UserDefaults.standard.set(encoded, forKey: "Items")
//            }
//        }
//        
//    }
//    init() {
//        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
//            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
//                items = decodedItems
//                return
//            }
//        }
//        
//        items = []
//    }
//}
