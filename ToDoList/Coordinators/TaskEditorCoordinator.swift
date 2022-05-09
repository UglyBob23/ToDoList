//
//  TaskEditorCoordinator.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 12.03.2022.
//

import UIKit

final class TaskEditorCoordinator: Coordinator {
    
    deinit {
        print("Task Editor Coordinator was deallocated")
    }
    
    // MARK: - Private properties
    
    private let moduleFactory: ModuleFactory
    private let navigationController: UINavigationController
    
    // MARK: - Properties
    var finishFlow: FinishFlowClosure?
    var task: Task?
    
    // MARK: - initializers
    
    init(navigationController: UINavigationController, moduleFactory: ModuleFactory, task: Task? = nil) {
        self.navigationController = navigationController
        self.moduleFactory = moduleFactory
        self.task = task
    }
    
    // MARK: - Private methods
    
    private func showTaskEditorViewController() {
        let taskEditorVC = moduleFactory.makeTaskEditorViewModule(task: task)
        taskEditorVC.presenter?.didFinishEditing = { [weak self] task in
            print("Did finish editing")
            self?.updateTasks(with: task)
        }
        navigationController.pushViewController(taskEditorVC, animated: true)
    }
    
    private func updateTasks(with task: Task?) {
        if let task = task {
            navigationController.viewControllers.forEach {
                ($0 as? TasksViewController)?.presenter?.save(task)
            }
        }
        navigationController.popViewController(animated: true)
        finishFlow?()
    }

    // MARK: - Methods
    
    func start() {
        showTaskEditorViewController()
    }
}
