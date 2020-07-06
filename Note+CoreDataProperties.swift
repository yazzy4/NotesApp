//
//  Note+CoreDataProperties.swift
//  NotesApp
//
//  Created by Yaz Burrell on 7/6/20.
//  Copyright © 2020 Yaz Burrell. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var body: String?
    @NSManaged public var category: Category?

}
