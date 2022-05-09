//
//  StoreTasksList+CoreDataClass.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 07.02.2022.
//
//

import Foundation
import CoreData

@objc(StoreTasksList)
public class StoreTasksList: NSManagedObject {
    
    private func getTasks(from storeTasks: [Any]?) -> [Task] {
        guard let storeTasks = storeTasks as? [StoreTask] else { return [] }
        return storeTasks.compactMap { $0.toTask() }
    }

    func toTasksList() -> TasksList? {
        guard
            let name = name,
            let date = date,
            let id = id
        else {
            return nil
        }
        return TasksList(
            name: name,
            date: date,
            tasks: getTasks(from: tasks?.array),
            id: id
        )
    }
    
    func from(_ tasksList: TasksList) {
        name = tasksList.name
        date = tasksList.date
        id = tasksList.id
    }
}
