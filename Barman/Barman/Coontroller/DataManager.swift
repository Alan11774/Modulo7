//
//  DataManager.swift
//  Pets
//
//  Created by Ángel González on 18/10/24.
//

import Foundation
import CoreData

class DataManager: NSObject {
    
    static let shared = DataManager()
    
    private override init() {
        super.init()
    }

    func todasLasBebidas() -> [Bebidas] {
        var arreglo = [Bebidas]()
        let elQuery = Bebidas.fetchRequest()
        do {
            arreglo = try persistentContainer.viewContext.fetch(elQuery)
        } catch { print ("error en el query!") }
        return arreglo
    }
    
    func llenaBD () {
        let ud = UserDefaults.standard
        if ud.integer(forKey: "BD-OK") != 1 {  // La base de datos no se ha descargado
            if InternetMonitor.shared.hayConexion {
                if let laURL = URL(string: Constants.URL_BASE) { //Constants.URL_DRINK_IMAGES
                    let sesion = URLSession(configuration: .default)
                    let tarea = sesion.dataTask(with:URLRequest(url:laURL)) { data, response, error in
                        if error != nil {  // let _ = error (MUY swifty)
                                           // algo salió mal
                            print ("no se pudo descargar el feed de bebidas \(error?.localizedDescription ?? "")")
                            return
                        }
                            // llenar la base de datos
                        do {
                            let tmp = try JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
//                            print(tmp)
                            self.guardaBebidas(tmp)
                        }
                        catch { print ("no se obtuvo un JSON en la respuesta") }
                    ud.set(1, forKey:"BD-OK")
                    }
                    tarea.resume()
                }
            }
        }
    }


    func verifyImage (_ unaURL:URL) {
        // esto no debe usarse para descargar contenido de Internet, porque bloquea el hilo principal
        //let losBytes = Data(contentsOf: unaURL)
        if let urlDocumentos = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask).first {
            let urlDelArchivo = urlDocumentos.appending(component:unaURL.lastPathComponent)
            print(urlDelArchivo)
            // comprobar si un archivo ya existe, para no descargarlo dos veces
            if !FileManager.default.fileExists(atPath: urlDelArchivo.path) {
                let sesion = URLSession(configuration: .default)
                let tarea = sesion.dataTask(with:URLRequest(url: unaURL)) { data, response, error in
                    if error != nil {  // let _ = error (MUY swifty)
                        // algo salió mal
                        print ("no se pudo descargar la imagen \(error?.localizedDescription ?? "")")
                        return
                    }
                    // obtener la url de documents:
                    do {
                        try data?.write(to: urlDelArchivo)
                    } catch {
                        print ("no se pudo guardar la imagen")
                    }
                }
                tarea.resume()
            }
        }
    }
//    func verifyImage(_ imageUrl: URL) {
//      let session = URLSession(configuration: .default)
//      let task = session.dataTask(with: imageUrl) { data, response, error in
//
//        if let error = error {
//          print("Error downloading image: \(error.localizedDescription)")
//          return
//        }
//        
//        guard
//     let data = data else { return }
//        
//        // Save the downloaded image data to documents directory (modify as needed)
//        if let urlDocumentos = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//          let urlDelArchivo = urlDocumentos.appendingPathComponent(imageUrl.lastPathComponent)
//          do {
//            try data.write(to: urlDelArchivo)
//            print("Image downloaded successfully: \(urlDelArchivo)")
//          } catch {
//            print("Error saving downloaded image: \(error.localizedDescription)")
//          }
//        }
//      }
//      task.resume()
//    }

            func guardaBebidas(_ arregloJSON:[[String:Any]]) {
                guard let entidadDesc = NSEntityDescription.entity(forEntityName:"Bebidas", in:persistentContainer.viewContext)
                else { return }
                for dict in arregloJSON {
                    // 1. crear un objeto Mascota
                    let b = NSManagedObject(entity: entidadDesc, insertInto: persistentContainer.viewContext) as! Bebidas
                    // 2. setear las properties del objeto, con los datos del dict
                    b.inicializaCon(dict)
                    if let laURL = URL(string:b.img ?? "") {
//                    if let laURL = URL(string:Constants.URL_BASE) {
                        verifyImage(laURL)
                    }
                }
                // 3. salvar el objeto
                saveContext()
            }
//    func guardaResponsables(_ arregloJSON:[[String:Any]]) {
//        guard let entidadDesc = NSEntityDescription.entity(forEntityName:"Bebidas", in:persistentContainer.viewContext)
//        else { return }
//        for dict in arregloJSON {
//            let b = NSManagedObject(entity: entidadDesc, insertInto: persistentContainer.viewContext) as! Bebidas
//            b.inicializaCon(dict)
//            // buscar si existe una mascota relacionada
//            if let idMascota = dict["name"] as? String,
//               idMascota != "" {
//                if let mascota = buscaMascotaConId(idMascota) {
//                    // establecemos la relación del responsable con la mascota
//                    r.mascotas?.adding(mascota)
//                    saveContext()
//                    // y también la relación de la mascota con el responsable
//                    mascota.responsable = r
//                }
//                else { saveContext() }
//            }
//            else { saveContext() }
//        }
//    }
//
//    func buscaMascotaConId(_ idM: Int16) -> Mascota? {
//        let elQuery = NSFetchRequest<NSFetchRequestResult>(entityName:"Mascota")
//        let elFiltro = NSPredicate (format:"id == %d", idM)
//        elQuery.predicate = elFiltro
//        do {
//            let tmp = try persistentContainer.viewContext.fetch(elQuery) as! [Mascota]
//            return tmp.first
//        } catch { print ("error en el query!") }
//        return nil
//    }

            lazy var persistentContainer: NSPersistentContainer = {
                /*
                 The persistent container for the application. This implementation
                 creates and returns a container, having loaded the store for the
                 application to it. This property is optional since there are legitimate
                 error conditions that could cause the creation of the store to fail.
                 */
                let container = NSPersistentContainer(name: "Barman")
                container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                    if let error = error as NSError? {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        
                        /*
                         Typical reasons for an error here include:
                         * The parent directory does not exist, cannot be created, or disallows writing.
                         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                         * The device is out of space.
                         * The store could not be migrated to the current model version.
                         Check the error message to determine what the actual problem was.
                         */
                        fatalError("Unresolved error \(error), \(error.userInfo)")
                    }
                })
                return container
            }()
        
            // MARK: - Core Data Saving support
        
            func saveContext () {
                let context = persistentContainer.viewContext
                if context.hasChanges {
                    do {
                        try context.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nserror = error as NSError
                        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                    }
                }
            }
    
    
}
