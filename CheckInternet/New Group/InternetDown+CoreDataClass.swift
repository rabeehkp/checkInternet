//
//  InternetDown+CoreDataClass.swift
//  CheckInternet
//
//  Created by Rabeeh KP on 28/01/18.
//  Copyright © 2018 Rabeeh KP. All rights reserved.
//
//

import Foundation
import CoreData
import  UIKit

@objc(InternetDown)
public class InternetDown: NSManagedObject {

    func getcontext () -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func Store_InternetDown_Time(Time: String) {
        let context = getcontext()
        let entity = NSEntityDescription.entity(forEntityName: "InternetDown", in: context)
        let internetDown = NSManagedObject(entity: entity!, insertInto: context)
        internetDown.setValue(Time, forKey: "downTime")
        do{
            try context.save()
            print("saved")
            
        } catch let error as NSError{
            print("not saved \(error), \(error.userInfo)")
        } catch{
            
        }
        
    }
    
    func fetch_InternetDown_Times() -> [InternetDown]?{
        var resultArray: [InternetDown]?
        let fetchRequest = NSFetchRequest<NSFetchRequestResult> (entityName:"InternetDown")
        fetchRequest.predicate = NSPredicate(value:true)
        fetchRequest.returnsObjectsAsFaults = false
        do{
            resultArray = try getcontext().fetch(fetchRequest) as? [InternetDown]
            print("time = \(resultArray!.count)")
        }
        catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
        return resultArray
    }
    
    
}
