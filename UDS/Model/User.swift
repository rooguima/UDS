//
//  Users.swift
//  UDS
//
//  Created by Rodrigo Guimarães on 07/04/20.
//  Copyright © 2020 Rodrigo Guimarães. All rights reserved.
//

import Foundation
import CoreData

public class User:NSManagedObject, Identifiable {
    @NSManaged public var id:UUID
    @NSManaged public var name:String
    @NSManaged public var email:String
    @NSManaged public var password:String
}
