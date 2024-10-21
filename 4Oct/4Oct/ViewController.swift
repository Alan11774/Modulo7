//
//  ViewController.swift
//  4Oct
//
//  Created by Alan Ulises on 04/10/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtCorreo: UITextField!
    
    @IBOutlet weak var txtContraseña: UITextField!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after loading the view.
        let ud = UserDefaults.standard
        if ud.string(forKey: Utils.LOGIN_KEY) == "OK"{
            performSegue(withIdentifier: "loginOk", sender: self)
        }
    }
    @IBAction func btnRegistroTouch(_ sender: Any) {
        //Muy parecido al segue, es otra forma de abrir una vista
        // Abre RegisterViewController y hace lo declarado en cocoa touch script
        let rvc = RegisterViewController()
        
        // Si se desea full screen
        rvc.modalPresentationStyle = .fullScreen
        present(rvc, animated: true) // this
    }
    // We can track the action of the biutton clicked in this class
    @IBAction func btnEntrarTouch(_ sender: Any) {
        // validar si los cuadros de texto no están vacios
        var mensaje = ""
        // desempaquetamos los strings en los opcionales
        let correo = txtCorreo.text ?? ""
        let contraseña = txtContraseña.text ?? ""
        if  correo.isEmpty {
            mensaje = "Por favor indique su correo"
        }
        else if contraseña.isEmpty {
            mensaje = "Debe indicar su contraseña"
        }
        // Otras validaciones....
        else { // validamos que parezca un correo válido
            let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let correoValido = NSPredicate(format:"SELF MATCHES %@", regex)
            if !correoValido.evaluate(with: correo) {
                mensaje = "No es un correo válido"
            }
            // TODO: buscar el correo, y comparar el password
            if let unaPersona = DataManager.shared.buscaPersona(correo: correo) {
                if !unaPersona.password.elementsEqual(contraseña) {
                    mensaje = "El password no coincide"
                }
            }
            else { mensaje = "no existe ese correo" }
        }
        if mensaje.isEmpty {
            print( "Todo OK. hacer el login" )
            // guardar la bandera de login Y navegar a HOME
            let ud = UserDefaults.standard
            ud.set("OK", forKey:Utils.LOGIN_KEY)
            performSegue(withIdentifier:"loginOK", sender: self)
        }
        else {
            let ac = UIAlertController(title: "hola", message:mensaje, preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default)
            ac.addAction(action)
            self.present(ac, animated: true)
        }
    }
}
    

