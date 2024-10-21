//
//  DataManager.swift
//  RemoteData
//
//  Created by Alan Ulises on 12/10/24.
//

import Foundation

class DataManager:NSObject{
    
    static let shared = DataManager()
    
    private override init() {
        super.init()
    }
    
    func guardaImagen(_ url: URL){
        let sesion = URLSession(configuration: .default)
        let tarea = sesion.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error{
                print("No se pudo descargar la imagen\(error?.localizedDescription ?? "")")
                return
            }
            if let urlDocumentos = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
                // Nombre dela rchivo usando la url
                let urlArchivo = urlDocumentos.appendingPathComponent(url.lastPathComponent)
                
                do{
                    try data?.write(to: urlArchivo)
                } catch{
                    print("No se pudo guardar la imagen\(error.localizedDescription)")
                }
            }
            
        }
        tarea.resume()
        print("Holaa")
    }
}
