//
//  Mascota+CoreDataProperties.swift
//  Pets
//
//  Created by Alan Ulises on 18/10/24.
//
//

import Foundation
import CoreData


extension Mascota {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mascota> {
        return NSFetchRequest<Mascota>(entityName: "Mascota")
    }

    @NSManaged public var id: Int16
    @NSManaged public var genero: String?
    @NSManaged public var nombre: String?
    @NSManaged public var tipo: String?
    @NSManaged public var edad: Double
    @NSManaged public var responsable: Responsable?

}

extension Mascota : Identifiable {

}
