//
//  StoreTask+CoreDataProperties.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 07.02.2022.
//
//

import Foundation
import CoreData


extension StoreTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoreTask> {
        return NSFetchRequest<StoreTask>(entityName: "StoreTask")
    }

    @NSManaged public var date: Date?
    @NSManaged public var isComplete: Bool
    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var id: UUID?
    @NSManaged public var tasksList: StoreTasksList?

}

extension StoreTask : Identifiable {

}
