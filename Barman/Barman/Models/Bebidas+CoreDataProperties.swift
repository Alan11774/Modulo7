//
//  Bebidas+CoreDataProperties.swift
//  Barman
//
//  Created by Alan Ulises on 21/10/24.
//
//

import Foundation
import CoreData


extension Bebidas {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bebidas> {
        return NSFetchRequest<Bebidas>(entityName: "Bebidas")
    }

    @NSManaged public var directions: String?
    @NSManaged public var name: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var img: String?

}

extension Bebidas : Identifiable {

}
