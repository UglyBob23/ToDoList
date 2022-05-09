//
//  StoreTask+CoreDataClass.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 07.02.2022.
//
//

import Foundation
import CoreData

@objc(StoreTask)
public class StoreTask: NSManagedObject {

    func toTask() -> Task? {
        guard
            let name = name,
            let date = date,
            let id = id
        else {
            return nil
        }
        return Task(
            name: name,
            note: note,
            isComplete: isComplete,
            date: date,
            id: id
        )
    }
    
    func from(_ task: Task) {
        name = task.name
        note = task.note
        isComplete = task.isComplete
        date = task.date
        id = task.id
    }
}
