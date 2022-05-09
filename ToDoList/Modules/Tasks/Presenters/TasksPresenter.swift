//
//  TasksPresenter.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 02.02.2022.
//

import Foundation

// MARK: - Protocols

protocol TasksPresenterProtocol: AnyObject {
    init(tasksViewController: TasksViewControllerProtocol,
         tasksProvider: TasksListProvider,
         tasksList: TasksList)
    
    var tasksProvider: TasksListProvider? { get }
    var tasksList: TasksList { get }
    var taskDidChange: (() -> Void)? { get set }
    var showTaskEditor: ((Task?) -> Void)? { get set }
    
    func editTask(at: IndexPath)
    func deleteTask(at indexPath: IndexPath)
    func save(_ task: Task)
    func setTaskDone(at indexPath: IndexPath)
    func setTableViewAppearance()
}

final class TasksPresenter: TasksPresenterProtocol {
    
    // MARK: - Properties
    
    weak var tasksViewController: TasksViewControllerProtocol?
    var tasksProvider: TasksListProvider?
    var tasksList: TasksList
    
    var taskDidChange: (() -> Void)?
    var showTaskEditor: ((Task?) -> Void)?
    
    // MARK: - Initializers
    
    required init(tasksViewController: TasksViewControllerProtocol, tasksProvider: TasksListProvider,
                  tasksList: TasksList) {
        self.tasksViewController = tasksViewController
        self.tasksProvider = tasksProvider
        self.tasksList = tasksList
    }
    
    // MARK: - Private methods
    
    private func  getIdForTask(at indexPath: IndexPath) -> UUID {
        if indexPath.section == 0 {
            return tasksList.currentTasks[indexPath.row].id
        } else {
            return tasksList.completedTasks[indexPath.row].id
        }
    }
    
    // MARK: - Methods
    
    func editTask(at indexPath: IndexPath) {
        if indexPath.section == 0 {
            let task = tasksList.currentTasks[indexPath.row]
            showTaskEditor?(task)
        } else {
            let task = tasksList.completedTasks[indexPath.row]
            showTaskEditor?(task)
        }
    }
    
    func deleteTask(at indexPath: IndexPath) {
        let id = getIdForTask(at: indexPath)
        guard let index = tasksList.tasks.firstIndex(where: { $0.id == id }) else { return }
        tasksProvider?.delete(tasksList.tasks[index])
        tasksList.tasks.remove(at: index)
        taskDidChange?()
        
    }
    
    func save(_ task: Task) {
        if !tasksList.tasks.contains(where: { $0.id == task.id }) {
            tasksList.tasks.append(task)
        }
        tasksProvider?.save(task, for: tasksList.id)
        tasksViewController?.updateUI()
        taskDidChange?()
    }
    
    func setTaskDone(at indexPath: IndexPath) {
        let id = getIdForTask(at: indexPath)
        guard let index = tasksList.tasks.firstIndex(where: { $0.id == id }) else { return }
        tasksList.tasks[index].isComplete.toggle()
        tasksProvider?.save(tasksList.tasks[index], for: tasksList.id)
        taskDidChange?()
        tasksViewController?.updateUI()
    }
    
    func setTableViewAppearance() {
        tasksViewController?.setTableViewAppearance(tasksIsEmpty: tasksList.tasks.isEmpty)
    }
}
