//
//  TasksListPresenter.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 02.02.2022.
//

import Foundation
import CloudKit

// MARK: - Protocols

protocol TasksListsPresenterProtocol: AnyObject {
    init(tasksListViewController: TasksListsViewControllerProtocol, with tasksListsProvider: TasksListProvider)
    
    var tasksLists: [TasksList] { get set }
    var selectedTasksListIndex: Int? { get set }
    var addTaskList: (() -> Void)? { get set }
    var tasksListSelected: ((TasksList) -> Void)? { get set }
    var editTasksList: ((TasksList) -> Void)? { get set }
    
    func didSelectRow(at index: Int)
    func fetchTasksLists()
    func createTasksList(with name: String)
    func deleteTasksList(at index: Int)
    func update(_ tasksList: TasksList)
    func setTasksListDone(at index: Int)
    func setTableViewAppearance()
}

final class TasksListsPresenter: TasksListsPresenterProtocol {
    
    // MARK: - Properties
    
    weak var tasksListViewController: TasksListsViewControllerProtocol?
    
    var tasksListsProvider: TasksListProvider?
    var tasksLists = [TasksList]()
    var selectedTasksListIndex: Int?
    
    var tasksListSelected: ((TasksList) -> Void)?
    var editTasksList: ((TasksList) -> Void)?
    var addTaskList: (() -> Void)?
    
    // MARK: - Initializers
    
    required init(tasksListViewController: TasksListsViewControllerProtocol, with tasksListsProvider: TasksListProvider) {
        self.tasksListViewController = tasksListViewController
        self.tasksListsProvider = tasksListsProvider
    }
    
    // MARK: - Methods
    
    func fetchTasksLists() {
        tasksListsProvider?.getTasksList { [weak self] result in
            switch result {
            case .success(let tasksLists):
                self?.tasksLists = tasksLists
                self?.tasksListViewController?.updateUI()
            case .failure(let error):
                self?.tasksListViewController?.showAlert(title: "Error!",
                                                         message: error.description)
            }
        }
    }
    
    func createTasksList(with name: String) {
        let tasksList = TasksList(name: name,
                                  date: Date(),
                                  tasks: [],
                                  id: UUID())
        
        tasksListsProvider?.save(tasksList)
        tasksLists.append(tasksList)
        tasksListViewController?.updateUI()
    }
    
    func deleteTasksList(at index: Int) {
        tasksListsProvider?.delete(tasksLists[index])
        tasksLists.remove(at: index)
    }
    
    func update(_ tasksList: TasksList) {
        if !tasksLists.contains(where: { $0.id == tasksList.id }) {
            tasksLists.append(tasksList)
        }
        tasksListsProvider?.save(tasksList)
        tasksListViewController?.updateUI()
    }
    
    func didSelectRow(at index: Int) {
        selectedTasksListIndex = index
        tasksListSelected?(tasksLists[index])
    }
    
    func setTasksListDone(at index: Int) {
        tasksLists[index].tasks.forEach { $0.isComplete = true }
        tasksListsProvider?.setAllTasksDone(for: tasksLists[index].id)
        tasksListViewController?.updateUI()
    }
    
    func setTableViewAppearance() {
        tasksListViewController?.setTableViewAppearance(tasksListsIsEmpty: tasksLists.isEmpty)
    }
}
