//
//  Bebidas+CoreDataClass.swift
//  Barman
//
//  Created by Alan Ulises on 21/10/24.
//
//

import Foundation
import CoreData

@objc(Bebidas)
public class Bebidas: NSManagedObject {
    func inicializaCon(_ dict:Dictionary<String,Any>){
        let name = (dict["name"] as? String) ?? ""
        let directions = (dict["directions"] as? String) ?? ""
        let ingredients = (dict["ingredients"] as? String) ?? ""
        let img = (dict["img"] as? String) ?? ""
        self.name = name
        self.directions = directions
        self.ingredients = ingredients
        self.img = img
        
    }

}
