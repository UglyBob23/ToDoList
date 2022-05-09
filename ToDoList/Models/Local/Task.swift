//
//  Task.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 03.02.2022.
//

import Foundation

final class Task {
    var name: String
    var note: String?
    var isComplete: Bool
    let date: Date
    let id: UUID
    
    init(name: String, note: String?, isComplete: Bool, date: Date, id: UUID) {
        self.name = name
        self.note = note
        self.isComplete = isComplete
        self.date = date
        self.id = id
    }
}
