//
//  Connected+CoreDataProperties.swift
//  CheckInternet
//
//  Created by Rabeeh KP on 29/01/18.
//  Copyright © 2018 Rabeeh KP. All rights reserved.
//
//

import Foundation
import CoreData


extension Connected {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Connected> {
        return NSFetchRequest<Connected>(entityName: "Connected")
    }

    @NSManaged public var connectedTime: String?

}
