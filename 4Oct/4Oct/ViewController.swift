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
        var message = ""
        let correo = txtCorreo.text ?? ""
        let contraseña = txtContraseña.text ?? ""
        if correo.isEmpty {
            message += "Ingrese un correo\n"
        }else if contraseña.isEmpty {
            message += "Ingrese una contraseña\n"
        }
        else{
            // With regex we can evaluate the string using the predicate in correo valido.
            // we use correo valido to evaluate correo variable.
            let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let correoValido = NSPredicate(format: "SELF MATCHES %@", regex)
            // if not expression
            if !correoValido.evaluate(with: correo){
                message = "No es un correo valido"
            }
            
        }
        if message.isEmpty{
            print("Haz iniciado sesion")
            let ud = UserDefaults.standard
            ud.set("OK", forKey: Utils.LOGIN_KEY)
            performSegue(withIdentifier: "loginOk", sender: self)
            
        }
        else{
            // Like the toast this is the opup messages.
            //message += "Bienvenido "
            let ac = UIAlertController(title: "Hola", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
                ac.addAction(action)
                self.present(ac, animated: true)
            }
        }
    }
    

