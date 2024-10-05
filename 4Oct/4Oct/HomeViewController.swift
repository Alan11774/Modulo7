//
//  HomeViewController.swift
//  4Oct
//
//  Created by Alan Ulises on 05/10/24.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let btnSalir = UIButton(type: .custom)
        btnSalir.setTitle("Salir de sesión", for: .normal)
        btnSalir.frame = CGRect(x: 0, y: 0, width: 120, height: 44)
        btnSalir.backgroundColor = .red
        btnSalir.addTarget(self, action: #selector(btnSalirTouch), for: .touchUpInside)
        btnSalir.center = view.center
        view.addSubview(btnSalir)
        
    }
    
    @objc func btnSalirTouch() {
        print("Salir de sesión")
        // Change the User Default flag to empty string
        let ud = UserDefaults.standard
        ud.set("", forKey: Utils.LOGIN_KEY)
        // To close the view
        dismiss(animated: true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
