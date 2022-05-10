//
//  DI.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 06.04.2022.
//

import UIKit

// MARK: - DI

final class DI {
    // MARK: - Private properties
    
    fileprivate let dataStore: TasksListDataStore
    fileprivate let tasksListsProvider: TasksListProvider
    fileprivate let moduleFactory: ModuleFactory
    fileprivate let coordinatorFactory: CoordinatorFactory
    
    // MARK: - Initializers
    
    init() {
        dataStore = CoreDataStack(modelName: "StoreTasksList")
        tasksListsProvider = TasksListProvider(dataStore: dataStore)
        moduleFactory = ModuleFactory()
        coordinatorFactory = CoordinatorFactory(moduleFactory: moduleFactory)
    }
}

// MARK: - Protocols

protocol AppFactory {
    func makeAppCoordinator(navigationController: UINavigationController) -> AppCoordinator
}

// MARK: - Extensions

extension DI: AppFactory {
    func makeAppCoordinator(navigationController: UINavigationController) -> AppCoordinator {
        coordinatorFactory.makeAppCoordinator(navigationController: navigationController)
    }
}

// MARK: - Module factory

// MARK: - Protocols

protocol ModuleFactoryProtocol {
    func makeTasksListViewModule(tasksListsProvider: TasksListProvider) -> TasksListViewController
    func makeTasksViewModule(tasksListsProvider: TasksListProvider, tasksList: TasksList) -> TasksViewController
    func makeTasksListEditorViewModule(_ tasksList: TasksList?) -> TasksListEditorViewController
    func makeTaskEditorViewModule(task: Task?) -> TaskEditorViewController
}

final class ModuleFactory: ModuleFactoryProtocol {
    
    // MARK: - Private properties
    
    fileprivate weak var di: DI?
    
    // MARK: - Initializers
    
    fileprivate init() {}
    
    // MARK: - Methods
    
    func makeTasksListViewModule(tasksListsProvider: TasksListProvider) -> TasksListViewController {
        let tasksListsVC = TasksListViewController()
        let tasksListsPresenter = TasksListsPresenter(tasksListViewController: tasksListsVC, with: tasksListsProvider)
        tasksListsVC.presenter = tasksListsPresenter
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: tasksListsVC,
            action: #selector(tasksListsVC.addButtonTapped)
        )
        tasksListsVC.navigationItem.rightBarButtonItem = addButton
        tasksListsVC.title = Localized.Titles.tasksListsVC
        return tasksListsVC
    }
    
    func makeTasksViewModule(tasksListsProvider: TasksListProvider, tasksList: TasksList) -> TasksViewController {
        let tasksVC = TasksViewController()
        let tasksProvider = tasksListsProvider
        let tasksPresenter = TasksPresenter(tasksViewController: tasksVC, tasksProvider: tasksProvider, tasksList: tasksList)
        tasksVC.presenter = tasksPresenter
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: tasksVC,
            action: #selector(tasksVC.addTaskButtonTapped)
        )
        let editButton = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: tasksVC,
            action: #selector(tasksVC.editTaskButtonTapped)
        )
        tasksVC.navigationItem.rightBarButtonItems = [addButton, editButton]
        tasksVC.title = tasksList.name
        return tasksVC
    }
    
    func makeTasksListEditorViewModule(_ tasksList: TasksList? = nil) -> TasksListEditorViewController {
        let editorViewController = TasksListEditorViewController()
        let presenter = TasksListEditorPresenter(editorViewController: editorViewController)
        presenter.tasksList = tasksList
        editorViewController.presenter = presenter
        editorViewController.navigationItem.hidesBackButton = true
        editorViewController.title = tasksList == nil ? Localized.Titles.tasksListEditorVC : "Edit Tasks List"
        return editorViewController
    }
    
    func makeTaskEditorViewModule(task: Task? = nil) -> TaskEditorViewController {
        let taskEditorViewController = TaskEditorViewController()
        let presenter = TaskEditorPresenter(editorViewController: taskEditorViewController)
        presenter.task = task
        taskEditorViewController.presenter = presenter
        taskEditorViewController.navigationItem.hidesBackButton = true
        taskEditorViewController.title = task == nil ? Localized.Titles.taskEditorVC : "Edit Task"
        return taskEditorViewController
    }
}

// MARK: - CoordinatorFactory

// MARK: - Protocols

protocol CoordinatorFactoryProtocol {
    func makeAppCoordinator(navigationController: UINavigationController) -> AppCoordinator
    func makeTasksListCoordinator(navigationController: UINavigationController, tasksListProvider: TasksListProvider) -> TasksListCoordinator
    func makeTaskEditorCoordinator(navigationController: UINavigationController, task: Task?) -> TaskEditorCoordinator
    func makeTasksListEditorCoordinator(navigationController: UINavigationController, tasksList: TasksList?) -> TasksListEditorCoordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    
    // MARK: - Private properties
    
    private let moduleFactory: ModuleFactory
    
    // MARK: - Initializers
    
    fileprivate init(moduleFactory: ModuleFactory) {
        self.moduleFactory = moduleFactory
    }
    // MARK: - Methods
    
    func makeAppCoordinator(navigationController: UINavigationController) -> AppCoordinator {
        AppCoordinator(navigationController: navigationController, coordinatorFactory: self)
    }
    
    func makeTasksListCoordinator(navigationController: UINavigationController, tasksListProvider: TasksListProvider) -> TasksListCoordinator {
        TasksListCoordinator(navigationController: navigationController, tasksListProvider: tasksListProvider, coordinatorFactory: self, moduleFactory: moduleFactory)
    }
    
    func makeTaskEditorCoordinator(navigationController: UINavigationController, task: Task?) -> TaskEditorCoordinator {
        TaskEditorCoordinator(navigationController: navigationController, moduleFactory: moduleFactory, task: task)
    }
    
    func makeTasksListEditorCoordinator(navigationController: UINavigationController, tasksList: TasksList?) -> TasksListEditorCoordinator {
        TasksListEditorCoordinator(navigationController: navigationController, moduleFactory: moduleFactory, tasksList: tasksList)
    }
}
