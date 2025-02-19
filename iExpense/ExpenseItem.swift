//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Francisco Manuel Gallegos Luque on 19/02/2025.
//

import Foundation
import SwiftData

@Model
class ExpenseItem: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
    
    init(id: UUID = UUID(), name: String, type: String, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}
