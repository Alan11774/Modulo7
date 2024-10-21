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
        super.init()
        leeInfo()
    }
    
    var arregloJSON : [Persona] = []
    
    func buscaPersona(correo: String) -> Persona? {
        // HOF High Order Function
        var tmp = arregloJSON.filter{ // Se puede hacer con un for y comparando cada elemento del arreglo con el correo
            personita in personita.correo == correo
        }
        if tmp.count > 0{
            return tmp.first
        }
        return nil
    }
    
    func leeInfo() {
        // Usado para un seleccionar el primer elemento de un arreglo.
        if var ruta = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            
            ruta.append(component:Utils.LOGIN_FILE)
            if !FileManager.default.fileExists(atPath: ruta.path){
                print("El archivo no existe")
            }else{
                do{
                    let losBytes = try Data(contentsOf: ruta)
                    let tmp = try JSONDecoder().decode([Persona].self, from: losBytes)
                    if !tmp.isEmpty{
                        arregloJSON = tmp
                    }
                }catch{
                    print("No se puede recuperar el contenido del archivo  \(error.localizedDescription)")
                }
            }
        }
        
    }
    func guardaInfo() {
        if var ruta = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            
            ruta.append(component:Utils.LOGIN_FILE)
            do{
                let losBytes = try JSONEncoder().encode(arregloJSON)
                try losBytes.write(to: ruta, options: .atomic)
                
            }catch{
                print("No se puede convertir el arreglo en un archivo \(error.localizedDescription) ")
            }
        }
    }
    func guardaPersona(_ unaPersona:Persona) {
        arregloJSON.append(unaPersona)
        
    }
}
