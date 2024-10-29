//
//  TableViewController.swift
//  Barman
//
//  Created by Alan Ulises on 21/10/24.
//

import UIKit

class TableViewController: UITableViewController {
    var bebidas = [Bebidas]()
    
    @IBAction func nuevaReceta(_ sender: Any) {
        print("Agregar Receta")
        performSegue(withIdentifier:"addDrink", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bebidas = DataManager.shared.todasLasBebidas() // Cargar las recetas existentes

        // Observar la notificación cuando se guarde una nueva receta
        NotificationCenter.default.addObserver(self, selector: #selector(recargarTabla), name: NSNotification.Name("nuevaRecetaGuardada"), object: nil)
    }

    // Método que se ejecutará cuando se reciba la notificación
    @objc func recargarTabla() {
        bebidas = DataManager.shared.todasLasBebidas() // Recargar los datos desde Core Data
        tableView.reloadData() // Actualizar la tabla
    }

    deinit {
        // Remover el observador cuando la vista se destruya
        NotificationCenter.default.removeObserver(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bebidas = DataManager.shared.todasLasBebidas()
        NotificationCenter.default.addObserver(self, selector: #selector(mostrarTabla), name: NSNotification.Name(rawValue: "BD_LISTA"), object: nil)
    }
    @objc func mostrarTabla() {
            bebidas = DataManager.shared.todasLasBebidas()
            print("Mostrando la tabla")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(bebidas.count)
        return bebidas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bebidaCell", for: indexPath)
        let b = bebidas[indexPath.row]
        
        // Customize text label
        cell.textLabel?.text = b.name
        cell.textLabel?.textColor = .white
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let b = bebidas[indexPath.row]
        //Nombre del segue para llamar el cambio de vista
        performSegue(withIdentifier:"detailedDrink", sender:b)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailedDrink"
        {
            let destino = segue.destination as! ViewController
            destino.laBebida = sender as? Bebidas
        } else {
            _ = segue.destination as! FormularioViewController
        }
    }


}
