//
//  Guidelines.swift
//  UDS
//
//  Created by Rodrigo Guimarães on 07/04/20.
//  Copyright © 2020 Rodrigo Guimarães. All rights reserved.
//

import Foundation
import CoreData

public class Guideline:NSManagedObject, Identifiable {
    @NSManaged public var id:UUID
    @NSManaged public var title:String
    @NSManaged public var briefDescription:String
    @NSManaged public var fullDescription:String
    @NSManaged public var closed:Bool
    @NSManaged public var createdAt:Date
    @NSManaged public var author:User
}

