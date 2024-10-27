//
//  TableViewController.swift
//  Barman
//
//  Created by Alan Ulises on 21/10/24.
//

import UIKit

class TableViewController: UITableViewController {
    var bebidas = [Bebidas]()

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
        cell.textLabel?.text = b.name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let b = bebidas[indexPath.row]
        performSegue(withIdentifier:"show", sender:b)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destino = segue.destination as! ViewController
        destino.laBebida = sender as? Bebidas
    }


}
