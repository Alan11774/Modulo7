//
//  FormularioViewController.swift
//  Barman
//
//  Created by Alan Ulises on 28/10/24.
//

import UIKit

class FormularioViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBAction func Cancelar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil) // Regresa a la vista anterior
    }
    @IBAction func Guardar(_ sender: UIButton) {
        if AñadeInstruccion.text != "" && AñadeIngredientes.text != "" && ImagenCargada.image != nil {
                print("Campos llenados")
            
                // Crear un nuevo objeto Bebida y guardarlo en Core Data
                let context = DataManager.shared.persistentContainer.viewContext
                let nuevaBebida = Bebidas(context: context)
                
                nuevaBebida.name = AñadeNombre.text
                nuevaBebida.ingredients = AñadeIngredientes.text
                nuevaBebida.directions = AñadeInstruccion.text

                // Guardar la imagen
                if let image = ImagenCargada.image, let imageData = image.jpegData(compressionQuality: 0.8) {
                    let imageName = UUID().uuidString + ".jpg" // Nombre único para la imagen
                    saveImageToDocumentsDirectory(imageData, withName: imageName)
                    nuevaBebida.img = imageName
                }
                
                // Guardar el contexto de Core Data
                do {
                    try context.save()
                    print("Receta guardada correctamente")
                } catch {
                    print("Error al guardar la receta: \(error.localizedDescription)")
                }
                
                // Navegar de regreso al TableViewController o hacer otras acciones
            NotificationCenter.default.post(name: NSNotification.Name("nuevaRecetaGuardada"), object: nil)
            self.dismiss(animated: true, completion: nil)
            
                
            } else {
                print("Debes llenar todos los campos")
                let showAlert = UIAlertController(title: "Campos vacios", message: "Por favor llena todos los campos y carga una imagen", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                showAlert.addAction(ok)
                present(showAlert, animated: true, completion: nil)
            }
        }
    
    func saveImageToDocumentsDirectory(_ imageData: Data, withName imageName: String) {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let imageURL = documentDirectory.appendingPathComponent(imageName)
            do {
                try imageData.write(to: imageURL)
                print("Imagen guardada en \(imageURL)")
            } catch {
                print("Error al guardar la imagen: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func CargarImagen(_ sender: Any) {
        // Es necesario heredar UIImagePickerControllerDelegate y UINavigationControllerDelegate
        // Se realizara esta acción cada vez que el usaurio seleccione una imagen.
        let imageSelection = UIImagePickerController()
        imageSelection.delegate = self
        imageSelection.sourceType = .photoLibrary
        imageSelection.allowsEditing = false
        present(imageSelection,animated: true, completion: nil)
        print("Boton para cargar imagen")
    }
    
    // Metodo cuando el usaurio selecciono una imagen
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            ImagenCargada.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    // El usuario cancela la selección
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var AñadeInstruccion: UITextField!
    @IBOutlet weak var AñadeNombre: UITextField!
    
    
    @IBOutlet weak var ImagenCargada: UIImageView!
    
    @IBOutlet weak var AñadeIngredientes: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//    }

}
