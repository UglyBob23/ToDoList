//
//  TasksList.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 03.02.2022.
//

import Foundation

final class TasksList {
    var name: String
    let date: Date
    var tasks: [Task]
    let id: UUID
    
    init(name: String, date: Date, tasks: [Task], id: UUID) {
        self.name = name
        self.date = date
        self.tasks = tasks
        self.id = id
    }
}

extension TasksList {
    var currentTasks: [Task] {
        self.tasks.filter { !$0.isComplete }
    }
    
    var completedTasks: [Task] {
        self.tasks.filter { $0.isComplete }
    }
    
    var isCompleted: Bool {
        !completedTasks.isEmpty && currentTasks.isEmpty
    }
}
