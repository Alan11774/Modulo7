//
//  ViewController.swift
//  Barman
//
//  Created by Alan Ulises on 21/10/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var LabelName: UILabel!
    @IBOutlet weak var LabelIngredients: UILabel!
    @IBOutlet weak var LabelDescription: UILabel!
    @IBOutlet weak var ImageBebidas: UIImageView!
    var laBebida: Bebidas!
    var detalle: DetailView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        detalle = DetailView(frame:view.bounds.insetBy(dx: 40, dy: 40))
//        view.addSubview(detalle)
        
    }
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
//        var info = "\(laBebida.name ?? "")\n" +
//        "Ingredients: \(laBebida.ingredients ?? "")\n" +
//        "Intructions: \(laBebida.directions ?? "")\n"
//        if laBebida.img != nil {
//            info += laBebida.img ?? "No_value"
//            print(laBebida.img ?? "No_value")
//            print(info)
//            
//            }
//            else {
//                info += "\nDISPONIBLE PARA ADOPCIÓN"
//            }
        LabelName.text = laBebida.name
        LabelName.numberOfLines = 0
        
        LabelIngredients.text = laBebida.ingredients
        LabelIngredients.numberOfLines = 0
        LabelIngredients.sizeToFit()
        
        LabelDescription.text = laBebida.directions
        LabelDescription.numberOfLines = 0
        LabelDescription.sizeToFit()
        
        if let urlDocumentos = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask).first {
            let url = urlDocumentos.appendingPathComponent(laBebida.img ?? "")
            print(url.path)
            ImageBebidas.image = UIImage(contentsOfFile: url.path)
        }
        }

}

