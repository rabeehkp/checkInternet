//
//  Connected+CoreDataClass.swift
//  CheckInternet
//
//  Created by Rabeeh KP on 29/01/18.
//  Copyright © 2018 Rabeeh KP. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Connected)
public class Connected: NSManagedObject {

    func getcontext () -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func Store_InternetDown_Time(Time: String) {
        let context = getcontext()
        let entity = NSEntityDescription.entity(forEntityName: "Connected", in: context)
        let connected = NSManagedObject(entity: entity!, insertInto: context)
            connected.setValue(Time, forKey: "connectedTime")
        do{
            try context.save()
            print("saved")
            
        } catch let error as NSError{
            print("not saved \(error), \(error.userInfo)")
        } catch{
            
        }
        
    }
    
    func fetch_InternetConnected_Times() -> [Connected]?{
        var resultArray: [Connected]?
        let fetchRequest = NSFetchRequest<NSFetchRequestResult> (entityName:"Connected")
        fetchRequest.predicate = NSPredicate(format : "connectedTime == @")
        fetchRequest.returnsObjectsAsFaults = false
        do{
            resultArray = try getcontext().fetch(fetchRequest) as? [Connected]
            print("Connected time = \(resultArray!.count)")
        }
        catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
        return resultArray
    }
    
}
