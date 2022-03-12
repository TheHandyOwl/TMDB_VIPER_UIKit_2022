//
//  FavoriteMovie+CoreDataProperties.swift
//  
//
//  Created by Carlos on 12/3/22.
//
//

import Foundation
import CoreData


extension FavoriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }

    @NSManaged public var id: Int32
    @NSManaged public var image: String?
    @NSManaged public var synopsis: String?
    @NSManaged public var title: String?

}
