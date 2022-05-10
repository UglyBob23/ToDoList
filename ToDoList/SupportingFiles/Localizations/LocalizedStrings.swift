//
//  LocalizedStrings.swift
//  ToDoList
//
//  Created by Владимир Паутов on 09.05.2022.
//

import Foundation

enum Localized {
    
    // MARK: - Titles
    
    enum Titles {
        static var tasksListsVC: String {
            NSLocalizedString("Tasks lists", comment: "lists of tasks")
        }
        
        static var tasksListEditorVC: String {
            NSLocalizedString("New tasks list", comment: "new list of tasks")
        }
        
        static var taskEditorVC: String {
            NSLocalizedString("New task", comment: "new task")
        }
    }
    
    // MARK: - Table view
    
    enum TableView {
        enum Sections {
            static var currentTasks: String {
                NSLocalizedString("Current tasks", comment: "Current tasks")
            }
            
            static var completedTasks: String {
                NSLocalizedString("Completed tasks", comment: "Completed tasks")
            }
        }
    }
    
    // MARK: - Buttons
    
    enum Buttons {
        static var saveButton: String {
            NSLocalizedString("Save", comment: "Save to db")
        }
        
        static var cancelButton: String {
            NSLocalizedString("Cancel", comment: "Cancel")
        }
    }
    
    // MARK: - Placeholders
    
    enum Placeholders {
        static var tasksListName: String {
            NSLocalizedString("Tasks list name", comment: "Name of tasks list")
        }
        
        static var taskName: String {
            NSLocalizedString("Task name", comment: "Name of task")
        }
        
        static var taskNote: String {
            NSLocalizedString("Task note", comment: "Task's note")
        }
    }
    
    // MARK: - Labels text
    
    enum Labels {
        static var noTasksListsLabel: String {
            NSLocalizedString("Press <<+>> to add list of tasks", comment: "Press <<+>> to add list of tasks")
        }
        
        static var noTasksLabel: String {
            NSLocalizedString("Tasks list is empty.", comment: "Tasks list is empty.")
        }
    }
    
    // MARK: - Segmented contorl
    
    enum SegmentedControl {
        static var alphabetItem: String {
            NSLocalizedString("A-Z", comment: "A-Z order")
        }
        
        static var dateItem: String {
            NSLocalizedString("Date", comment: "Ordered by date")
        }
    }
    
    // MARK: - Swipe actions titles
    
    enum SwipeActions {
        static var done: String {
            NSLocalizedString("Done", comment: "Done")
        }
        
        static var edit: String {
            NSLocalizedString("Edit", comment: "Edit")
        }
        
        static var delete: String {
            NSLocalizedString("Delete", comment: "Delete")
        }
    }
    
    // MARK: - Errors
    
    enum Errors {
        
        // MARK: - Data errors descriptions
        
        enum Data {
            static var getData: String {
                NSLocalizedString("Can't get data", comment: "Can't get data")
            }
        }
        
        // MARK: - Task errors descriptions
        
        enum Task {
            static var taskNameIsEmpty: String {
                NSLocalizedString("Task name can't be empty", comment: "Task name can't be empty")
            }
        }
        
        // MARK: - Tasks list errors descriptions
        
        enum TasksList {
            static var tasksListNameIsEmpty: String {
                NSLocalizedString("Tasks list name can't be empty", comment: "Tasks list name can't be empty")
            }
        }
    }
    
    // MARK: - Alerts titles
    
    enum AlertsTitles {
        static var error: String {
            NSLocalizedString("Error!", comment: "Error!")
        }
    }
}
