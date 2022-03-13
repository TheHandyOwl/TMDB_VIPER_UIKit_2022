//
//  CoreDataManager.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 12/3/22.
//

import CoreData
import Foundation


// MARK: - CoreDataManager
final class CoreDataManager {
    
    /// Singleton pattern
    static var shared: CoreDataManager = {
        let instance = CoreDataManager()
        return instance
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: Constants.Managers.CoreData.favoritesPersistentContainer)
        
        container.loadPersistentStores { (_ storeDescription, error) in
            if let error = error as Error? {
                print("\(Constants.Strings.errorLiteral): \(error.localizedDescription)")
            }
        }
        
        return container
         
    }()
    
    func saveContext() throws {
        
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                throw error
            }
        }
        
    }
    
}
