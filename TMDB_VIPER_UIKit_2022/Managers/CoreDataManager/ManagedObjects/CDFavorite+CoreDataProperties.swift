//
//  CDFavorite+CoreDataProperties.swift
//  
//
//  Created by Carlos on 13/3/22.
//
//

import Foundation
import CoreData


extension CDFavorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFavorite> {
        return NSFetchRequest<CDFavorite>(entityName: "CDFavorite")
    }

    @NSManaged public var id: Int32
    @NSManaged public var image: String?
    @NSManaged public var synopsis: String?
    @NSManaged public var title: String?

}
