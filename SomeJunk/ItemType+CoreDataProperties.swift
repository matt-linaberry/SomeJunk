//
//  ItemType+CoreDataProperties.swift
//  SomeJunk
//
//  Created by Matthew Linaberry on 3/21/16.
//  Copyright © 2016 MRS Electronic, Inc. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ItemType {

    @NSManaged var type: String?
    @NSManaged var item: NSSet?

}
