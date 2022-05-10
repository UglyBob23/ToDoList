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
            return Localized.Errors.Data.getData
        }
    }
}

enum TaskError {
    case taskNameIsEmpty
    
    var description: String {
        switch self {
        case .taskNameIsEmpty:
            return Localized.Errors.Task.taskNameIsEmpty
        }
    }
}

enum TasksListError {
    case tasksListNameIsEmpty
    
    var description: String {
        switch self {
        case .tasksListNameIsEmpty:
            return Localized.Errors.TasksList.tasksListNameIsEmpty
        }
    }
}
