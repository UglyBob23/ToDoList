//
//  TasksListEditorCoordinator.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 18.03.2022.
//

import UIKit

final class TasksListEditorCoordinator: Coordinator {
    
    deinit {
        print("Tasks List Editor Coordinator was deallocated")
    }
    
    // MARK: - Private properties
    
    private let moduleFactory: ModuleFactory
    private let navigationController: UINavigationController
    
    // MARK: - Properties
    
    var finishFlow: FinishFlowClosure?
    var tasksList: TasksList?
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController, moduleFactory: ModuleFactory, tasksList: TasksList? = nil) {
        self.navigationController = navigationController
        self.moduleFactory = moduleFactory
        self.tasksList = tasksList
    }
    
    // MARK: - Private methods
    
    private func showTasksListEditorViewController(with tasksList: TasksList?) {
        let editorVC = moduleFactory.makeTasksListEditorViewModule(tasksList)
        editorVC.presenter?.didEndEditing = { [weak self] tasksList in
            self?.update(tasksList)
        }
        navigationController.pushViewController(editorVC, animated: true)
    }

    private func update(_ tasksList: TasksList?) {
        if let tasksList = tasksList {
            navigationController.viewControllers.forEach {
                ($0 as? TasksListViewController)?.presenter?.update(tasksList)
            }
        }
        navigationController.popViewController(animated: true)
        finishFlow?()
    }

    // MARK: - Methods
    
    func start() {
        showTasksListEditorViewController(with: tasksList)
    }
}
