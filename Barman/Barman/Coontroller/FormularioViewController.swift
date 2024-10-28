//
//  FormularioViewController.swift
//  Barman
//
//  Created by Alan Ulises on 28/10/24.
//

import UIKit

class FormularioViewController: UIViewController {

    @IBAction func Cancelar(_ sender: UIButton) {
        print("Regresar a vista anterior")
    }
    @IBAction func Guardar(_ sender: UIButton) {
        print("Hola")
        print(AñadeNombre.text ?? "Valor no llenado en nombre")
        print(AñadeInstruccion.text ?? "Valor no llenado en instruccion")
    }
    @IBAction func CargarImagen(_ sender: Any) {
        print("Boton para cargar imagen")
        ImagenCargada.image = UIImage(named: "square.and.arrow.down.badge.clock")
    }
    @IBOutlet weak var AñadeInstruccion: UITextField!
    @IBOutlet weak var AñadeNombre: UITextField!
    
    
    @IBOutlet weak var ImagenCargada: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
