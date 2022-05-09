//
//  ErrorManager.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 03.02.2022.
//

import Foundation

enum DataError: Error {
    case getData
    
    var description: String {
        switch self {
        case .getData:
            return "Can't get data"
        }
    }
}

enum TaskError {
    case taskNameIsEmpty
    
    var description: String {
        switch self {
        case .taskNameIsEmpty:
            return "Task name can't be empty"
        }
    }
}

enum TasksListError {
    case tasksListNameIsEmpty
    
    var description: String {
        switch self {
        case .tasksListNameIsEmpty:
            return "Tasks list name can't be empty"
        }
    }
}
