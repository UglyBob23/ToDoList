//
//  AppCoordinator.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 02.02.2022.
//

import UIKit

final class AppCoordinator: BaseCoordinator, Coordinator {
    
    // MARK: - Private Properties
    
    private let coordinatorFactory: CoordinatorFactory
    private let navigationController: UINavigationController
    private let dataStore = CoreDataStack(modelName: "StoreTasksList")
    private var tasksListProvider: TasksListProvider
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController, coordinatorFactory: CoordinatorFactory) {
        self.navigationController = navigationController
        self.coordinatorFactory = coordinatorFactory
        self.tasksListProvider = TasksListProvider(dataStore: dataStore)
    }
    
    // MARK: - Private methods
    
    private func showTasksListsViewController() {
        let child = coordinatorFactory.makeTasksListCoordinator(
            navigationController: navigationController,
            tasksListProvider: tasksListProvider
        )
        addChild(child)
        child.start()
    }
    
    // MARK: - Methods
    
    func start() {
        showTasksListsViewController()
    }
}
