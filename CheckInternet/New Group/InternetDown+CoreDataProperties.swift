//
//  InternetDown+CoreDataProperties.swift
//  CheckInternet
//
//  Created by Rabeeh KP on 28/01/18.
//  Copyright © 2018 Rabeeh KP. All rights reserved.
//
//

import Foundation
import CoreData


extension InternetDown {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InternetDown> {
        return NSFetchRequest<InternetDown>(entityName: "InternetDown")
    }

    @NSManaged public var downTime: String?
}
