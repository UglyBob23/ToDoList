//
//  CoreDataStack.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 05.02.2022.
//

//import Foundation
import CoreData

final class CoreDataStack {
    
    // MARK: - Private properties
    
    private let modelName: String
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: - Lazy properties
    
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    // MARK: - Initializers
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    // MARK: - Methods
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}

// MARK: - TaskListDataStore

extension CoreDataStack: TasksListDataStore {
    
    // MARK: - Private methods
    
    private func createStoreTasksList(from tasksList: TasksList) {
        let storeTasksList = StoreTasksList(context: managedContext)
        storeTasksList.from(tasksList)
    }
    
    private func updateStoreTasksList(from storeTasksList: StoreTasksList, with tasksList: TasksList) {
        storeTasksList.from(tasksList)
    }
    
    private func deleteStoreTasks(for storeTasksList: StoreTasksList) {
        storeTasksList.tasks?.forEach{
            if let storeTask = $0 as? NSManagedObject {
                managedContext.delete(storeTask)
            }
        }
    }
    
    private func searchStoreTask(with id: UUID) -> StoreTask? {
        let taskFetch: NSFetchRequest<StoreTask> = StoreTask.fetchRequest()
        taskFetch.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
        let results = try managedContext.fetch(taskFetch)
            if let task = results.first {
                return task
            } else {
                return nil
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
            return nil
        }
    }
    
    // MARK: - Methods
    
    func getTasksLists() -> [TasksList] {
        let tasksListFetch: NSFetchRequest<StoreTasksList> = StoreTasksList.fetchRequest()
        do {
            let result = try managedContext.fetch(tasksListFetch)
            return result.compactMap { $0.toTasksList() }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
            return []
        }
    }
    
    func save(_ tasksList: TasksList) {
        let tasksListFetch: NSFetchRequest<StoreTasksList> = StoreTasksList.fetchRequest()
        tasksListFetch.predicate = NSPredicate(format: "id == %@", tasksList.id as CVarArg)
        
        do {
            let results = try managedContext.fetch(tasksListFetch)
            if let storeTasksList = results.first {
                updateStoreTasksList(from: storeTasksList, with: tasksList)
            } else {
                createStoreTasksList(from: tasksList)
            }
            saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func delete(_ tasksList: TasksList) {
        let tasksListFetch: NSFetchRequest<StoreTasksList> = StoreTasksList.fetchRequest()
        tasksListFetch.predicate = NSPredicate(format: "id == %@", tasksList.id as CVarArg)
        
        do {
            let results = try managedContext.fetch(tasksListFetch)
            if let storeTasksList = results.first {
                deleteStoreTasks(for: storeTasksList)
                managedContext.delete(storeTasksList)
                saveContext()
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func setAllTasksDone(for tasksListID: UUID) {
        let tasksFetch: NSFetchRequest<StoreTask> = StoreTask.fetchRequest()
        tasksFetch.predicate = NSPredicate(format: "tasksList.id == %@", tasksListID as CVarArg)
        
        do {
            let results = try managedContext.fetch(tasksFetch)
            results.forEach { $0.isComplete = true }
            saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func getTasks(for tasksListID: UUID) -> [Task] {
        let tasksFetch: NSFetchRequest<StoreTask> = StoreTask.fetchRequest()
        tasksFetch.predicate = NSPredicate(format: "tasksList.id == %@", tasksListID as CVarArg)
        
        do {
            let results = try managedContext.fetch(tasksFetch)
            print("There is\(results.count)")
            return results.compactMap { $0.toTask() }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
            return []
        }
    }
    
    func save(_ task: Task, for tasksListID: UUID) {
        let tasksListFetch: NSFetchRequest<StoreTasksList> = StoreTasksList.fetchRequest()
        tasksListFetch.predicate = NSPredicate(format: "id == %@", tasksListID as CVarArg)
        
        do {
            let results = try managedContext.fetch(tasksListFetch)
            if let storeTasksList = results.first {
                if let taskToUpdate = searchStoreTask(with: task.id) {
                    taskToUpdate.from(task)
                } else {
                    let storeTask = StoreTask(context: managedContext)
                    storeTask.from(task)
                    storeTask.tasksList = storeTasksList
                }
                saveContext()
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func delete(_ task: Task) {
        let taskFetch: NSFetchRequest<StoreTask> = StoreTask.fetchRequest()
        taskFetch.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        
        do {
            let results = try managedContext.fetch(taskFetch)
            if let taskToDelete = results.first {
                managedContext.delete(taskToDelete)
                saveContext()
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
