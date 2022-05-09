//
//  StoreTasksList+CoreDataProperties.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 07.02.2022.
//
//

import Foundation
import CoreData


extension StoreTasksList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoreTasksList> {
        return NSFetchRequest<StoreTasksList>(entityName: "StoreTasksList")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var tasks: NSOrderedSet?

}

// MARK: Generated accessors for tasks
extension StoreTasksList {

    @objc(insertObject:inTasksAtIndex:)
    @NSManaged public func insertIntoTasks(_ value: StoreTask, at idx: Int)

    @objc(removeObjectFromTasksAtIndex:)
    @NSManaged public func removeFromTasks(at idx: Int)

    @objc(insertTasks:atIndexes:)
    @NSManaged public func insertIntoTasks(_ values: [StoreTask], at indexes: NSIndexSet)

    @objc(removeTasksAtIndexes:)
    @NSManaged public func removeFromTasks(at indexes: NSIndexSet)

    @objc(replaceObjectInTasksAtIndex:withObject:)
    @NSManaged public func replaceTasks(at idx: Int, with value: StoreTask)

    @objc(replaceTasksAtIndexes:withTasks:)
    @NSManaged public func replaceTasks(at indexes: NSIndexSet, with values: [StoreTask])

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: StoreTask)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: StoreTask)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSOrderedSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSOrderedSet)

}

extension StoreTasksList : Identifiable {

}
