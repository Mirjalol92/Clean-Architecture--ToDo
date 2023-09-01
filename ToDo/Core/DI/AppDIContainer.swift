//
//  AppDIContainer.swift
//  ToDo
//
//  Created by Ali on 2022/11/14.
//

import Foundation
import UIKit
import CoreData




//MARK: - Main
class AppDIContainer{
    //Instance
    static func getInstance() -> AppDIContainer{
        return (UIApplication.shared.delegate as? AppDelegate)!.appDI
    }
    
    //MARK: - Core Data
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoDataModel")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error\(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var viewModelHolder = ViewModelHolder()
    lazy var useCaseHolder = UseCaseHolder()
}

//MARK: - CoreData
extension AppDIContainer{
    var context: NSManagedObjectContext{
        get{
            return persistentContainer.viewContext
        }
    }
}




