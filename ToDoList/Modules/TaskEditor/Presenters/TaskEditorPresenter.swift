//
//  TaskEditorPresenter.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 12.02.2022.
//

import Foundation

// MARK: - Protocols

protocol TaskEditorPresenterProtocol {
    init(editorViewController: TaskEditorViewControllerProtocol)
    
    var task: Task? { get set }
    var didFinishEditing: ((Task?) -> Void)? { get set }
    
    func saveTask(name: String?, note: String?)
}

final class TaskEditorPresenter: TaskEditorPresenterProtocol {
    
    // MARK: - Properties
    
    weak var editorViewController: TaskEditorViewControllerProtocol?
    
    var didFinishEditing: ((Task?) -> Void)?
    var task: Task? {
        didSet {
            editorViewController?.setTaskToEdit(taskName: task?.name,
                                                  taskNote: task?.note)
        }
    }
    
    // MARK: - Initializers
    
    required init(editorViewController: TaskEditorViewControllerProtocol) {
        self.editorViewController = editorViewController
    }
    
    // MARK: - Methods
    
    func saveTask(name: String?, note: String?) {
        guard
            let name = name,
            !name.isEmpty
        else {
            editorViewController?.showAlert(
                title: Localized.AlertsTitles.error,
                message: TaskError.taskNameIsEmpty.description)
            return
        }
        
        if let task = task {
            task.name = name
            task.note = note ?? ""
            didFinishEditing?(task)
        } else {
            let task = Task(
                name: name,
                note: note ?? "",
                isComplete: false,
                date: Date(),
                id: UUID()
            )
            didFinishEditing?(task)
        }
    }
}
