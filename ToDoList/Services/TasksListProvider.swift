//
//  TasksListProvider.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 03.02.2022.
//

import Foundation

// MARK: - Protocols

protocol TasksListDataStore: AnyObject {
    func getTasksLists() -> [TasksList]
    func save(_ tasksList: TasksList)
    func delete(_ tasksList: TasksList)
    func setAllTasksDone(for tasksListID: UUID)
    func getTasks(for tasksListID: UUID) -> [Task]
    func save(_ task: Task, for tasksListID: UUID)
    func delete(_ task: Task)
}

final class TasksListProvider {
    
    // MARK: - Private properties
    
    private let dataStore: TasksListDataStore?
    
    // MARK: - Initializers
    
    init(dataStore: TasksListDataStore) {
        self.dataStore = dataStore
    }
    
    // MARK: - Methods
    
    func getTasksList(completion: @escaping (Result<[TasksList], DataError>) -> Void) {
        guard let tasksList = dataStore?.getTasksLists() else {
            completion(.failure(.getData))
            return
        }
        completion(.success(tasksList))
    }
    
    func save(_ tasksList: TasksList) {
        dataStore?.save(tasksList)
    }
    
    func delete(_ tasksList: TasksList) {
        dataStore?.delete(tasksList)
    }
    
    func setAllTasksDone(for tasksListID: UUID) {
        dataStore?.setAllTasksDone(for: tasksListID)
    }
    
    func getTasks(for tasksListID: UUID, completion: @escaping (Result<[Task], DataError>) -> Void) {
        guard let tasks = dataStore?.getTasks(for: tasksListID) else {
            completion(.failure(.getData))
            return
        }
        completion(.success(tasks))
    }
    
    func save(_ task: Task, for tasksListID: UUID) {
        dataStore?.save(task, for: tasksListID)
    }
    
    func delete(_ task: Task) {
        dataStore?.delete(task)
    }
}
