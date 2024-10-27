//
//  ViewController.swift
//  Barman
//
//  Created by Alan Ulises on 21/10/24.
//

import UIKit

class ViewController: UIViewController {
    var laBebida: Bebidas!
    var detalle: DetailView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        detalle = DetailView(frame:view.bounds.insetBy(dx: 40, dy: 40))
        view.addSubview(detalle)
        
    }
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
        var info = "\(laBebida.name ?? "")\n" +
        "Ingredients: \(laBebida.ingredients ?? "")\n" +
        "Intructions: \(laBebida.directions ?? "")\n"
        if laBebida.img != nil {
            info += "Procesar Imagen"
            print(info)
            }
            else {
                info += "\nDISPONIBLE PARA ADOPCIÓN"
            }
            detalle.tv.text = info
        }

}

