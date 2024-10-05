//
//  DataManager.swift
//  4Oct
//
//  Created by Alan Ulises on 05/10/24.
//

import Foundation

class DataManager:NSObject {
    // Singleton Pattern
    static let shared =  DataManager()
    // To avoid instance the object we need change to private the constructor
    private override init() {
    }
    
    var arregloJSON : [Persona] = []
    
    func leeInfo() {
        
    }
    func guardaInfo() {
        
    }
    func guardaPersona(_ unaPersona:Persona) {
        arregloJSON.append(unaPersona)
        
    }
}
