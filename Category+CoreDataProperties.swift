//
//  Category+CoreDataProperties.swift
//  NotesApp
//
//  Created by Yaz Burrell on 7/6/20.
//  Copyright © 2020 Yaz Burrell. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var notes: NSSet?

}
