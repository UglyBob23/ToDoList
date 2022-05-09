//
//  Coordinator.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 12.03.2022.
//

import UIKit

// MARK: - Protocols

protocol Coordinator: AnyObject {
    
    func start()
}

class BaseCoordinator {
    
    // MARK: - Private properties
    
   private var childCoordinators: [Coordinator] = []
    
    // MARK: - Methods
    
    func addChild(_ child: Coordinator) {
        if !childCoordinators.contains(where: { $0 === child }) {
            childCoordinators.append(child)
        }
    }
    
    func removeChild(_ child: Coordinator?) {
        if let index = childCoordinators.firstIndex(where: { $0 === child }) {
            childCoordinators.remove(at: index)
        }
    }
}
