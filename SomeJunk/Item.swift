//
//  Item.swift
//  SomeJunk
//
//  Created by Matthew Linaberry on 3/21/16.
//  Copyright © 2016 MRS Electronic, Inc. All rights reserved.
//

import Foundation
import CoreData


class Item: NSManagedObject {

    override func awakeFromInsert() {
        // this is called when the object is inserted into core data!
        super.awakeFromInsert()
        self.created = NSDate()  // sets to the system time
        
    }
}
