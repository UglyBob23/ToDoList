//
//  TasksListCoordinator.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 17.03.2022.
//

import UIKit

final class TasksListCoordinator: BaseCoordinator, Coordinator {
    
    // MARK: - Private properties
    
    private let tasksListProvider: TasksListProvider
    private let coordinatorFactory: CoordinatorFactory
    private let moduleFactory: ModuleFactory
    private let navigationController: UINavigationController
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController, tasksListProvider: TasksListProvider, coordinatorFactory: CoordinatorFactory, moduleFactory: ModuleFactory) {
        self.navigationController = navigationController
        self.tasksListProvider = tasksListProvider
        self.coordinatorFactory = coordinatorFactory
        self.moduleFactory = moduleFactory
    }
    
    // MARK: - Private methods
    
    private func showTasksListsViewController() {
        let tasksListsVC = moduleFactory.makeTasksListViewModule(tasksListsProvider: tasksListProvider)
        tasksListsVC.presenter?.addTaskList = { [weak self] in
            self?.showTasksListEditorViewController()
        }
        tasksListsVC.presenter?.tasksListSelected = { [weak self] tasksList in
            self?.showTasksViewController(for: tasksList)
        }
        tasksListsVC.presenter?.editTasksList = { [weak self] tasksList in
            self?.showTasksListEditorViewController(with: tasksList)
        }
        navigationController.pushViewController(tasksListsVC, animated: false)
    }
    
    private func showTasksViewController(for tasksList: TasksList) {
        let tasksVC = moduleFactory.makeTasksViewModule(tasksListsProvider: tasksListProvider, tasksList: tasksList)
        tasksVC.presenter?.taskDidChange = { [weak self] in
            self?.updateUI()
        }
        tasksVC.presenter?.showTaskEditor = { [weak self] task in
            self?.showTaskEditorViewController(with: task)
        }
        navigationController.pushViewController(tasksVC, animated: true)
    }
    
    private func showTasksListEditorViewController(with tasksList: TasksList? = nil) {
        let child = coordinatorFactory.makeTasksListEditorCoordinator(navigationController: navigationController, tasksList: tasksList)
        child.finishFlow = { [weak self, weak child] in
            self?.removeChild(child)
        }
        addChild(child)
        child.start()
    }
    
    private func showTaskEditorViewController(with task: Task? = nil) {
        let child = coordinatorFactory.makeTaskEditorCoordinator(navigationController: navigationController, task: task)
        child.finishFlow = { [weak self, weak child] in
            self?.removeChild(child)
        }
        addChild(child)
        child.start()
    }
       
    private func updateUI() {
        navigationController.viewControllers.forEach {
            ($0 as? TasksListViewController)?.updateUI()
        }
    }
    
    // MARK: - Methods
    
    func start() {
        showTasksListsViewController()
    }
}
