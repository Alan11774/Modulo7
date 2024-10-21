//
//  Mascota+CoreDataClass.swift
//  Pets
//
//  Created by Alan Ulises on 18/10/24.
//
//

import Foundation
import CoreData

@objc(Mascota)
public class Mascota: NSManagedObject {
    func inicializaCon(_ dict: [String:Any]) {
        let nombre = (dict["nombre"] as? String) ?? ""
        let genero = (dict["genero"] as? String) ?? ""
        let tipo = (dict["tipo"] as? String) ?? ""
        let edad = (dict["edad"] as? Double) ?? 0.0
        let id = (dict["id"] as? Int16) ?? 0
        self.nombre = nombre
        self.genero = genero
        self.tipo = tipo
        self.edad = edad
        self.id = id
    }

}
