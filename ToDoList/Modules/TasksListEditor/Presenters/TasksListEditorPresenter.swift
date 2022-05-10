//
//  TasksListEditorPresenter.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 09.02.2022.
//

import Foundation

// MARK: - Protocols

protocol TasksListEditorPresenerProtocol {
    init(editorViewController: TasksListEditorViewControllerProtocol)
    
    var tasksList: TasksList? { get set }
    var didEndEditing: ((TasksList?) -> Void)? { get set }
    
    func saveTasksList(with name: String?)
}

final class TasksListEditorPresenter: TasksListEditorPresenerProtocol {
    
    // MARK: - Properties
    
    weak var editorViewController: TasksListEditorViewControllerProtocol?
    
    var tasksList: TasksList? {
        didSet {
            editorViewController?.setTasksListToEdit(taskListName: tasksList?.name)
        }
    }
    
    var didEndEditing: ((TasksList?) -> Void)?
    
    // MARK: - Initializers
    
    required init(editorViewController: TasksListEditorViewControllerProtocol) {
        self.editorViewController = editorViewController
    }
    
    // MARK: - Methods
    
    func saveTasksList(with name: String?) {
        guard
            let name = name,
            !name.isEmpty
        else {
            editorViewController?.showAlert(
                title: Localized.AlertsTitles.error,
                message: TasksListError.tasksListNameIsEmpty.description)
            return
        }
        
        if let tasksList = tasksList {
            tasksList.name = name
        } else {
            tasksList = TasksList(
                name: name,
                date: tasksList?.date ?? Date(),
                tasks: tasksList?.tasks ?? [],
                id: tasksList?.id ?? UUID()
            )
        }
        didEndEditing?(tasksList)
    }
}
