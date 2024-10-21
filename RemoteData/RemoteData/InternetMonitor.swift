//
//  InternetMonitor.swift
//  RemoteData
//
//  Created by Alan Ulises on 12/10/24.
//

import Foundation
import Network

class InternetMonitor{
    var hayConexion = false
    var tipoConexionWifi = false
    private var monitor = NWPathMonitor()
    
    init(){
        monitor.pathUpdateHandler = { ruta in
            self.hayConexion = ruta.status == .satisfied
            self.tipoConexionWifi = ruta.usesInterfaceType(.wifi)
        }
        
        // Aqui se ejecutara dependiendo al hilo deseado.
        // Cuando es un proceso que tome mucho tiempo no es buena idea meterlo en el hilo
        // En este caso se envia al background (95 % de los casos se hace asi)
        monitor.start(queue: DispatchQueue.global(qos: .background))
    }
}
