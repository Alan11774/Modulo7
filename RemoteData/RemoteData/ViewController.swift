//
//  ViewController.swift
//  RemoteData
//
//  Created by Alan Ulises on 12/10/24.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    let internetMonitor = InternetMonitor()
    let webView = WKWebView()
    let solecito = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        webView.frame = self.view.bounds
        self.view.addSubview(webView)
        solecito.hidesWhenStopped = true
        solecito.center = view.center
        webView.navigationDelegate = self
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var mensaje = "No hay conexión a internet"
        if internetMonitor.hayConexion{
            mensaje = "Conexión a internet Disponible"
            if internetMonitor.tipoConexionWifi{
                mensaje += "\nConexión WiFi"
            }else{
                mensaje += "\nPero solo por datos celulares"
                
                let ac = UIAlertController(title: "Hola", message: mensaje, preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default){
                    alertAction in
                    self.cargaImagen()
                }
                ac.addAction(action)
                let action2 = UIAlertAction(title: "Cancelar", style: .destructive)
                ac.addAction(action2)
                self.present(ac, animated:true)
            }
        }else{
            let ac = UIAlertController(title: "Hola", message: mensaje, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            ac.addAction(action)
            self.present(ac, animated:true)
            
        }

    }
    func cargaImagen() {
        solecito.startAnimating()
        //if let isURL = URL(string: "https://apod.nasa.gov/apod/image/2410/241010_eggleston_1024.jpg"){
        if let isURL = URL(string: "http://janzelaznog.com/DDAM/iOS/vim/localidades.xlsx"){
            
            if UIApplication.shared.canOpenURL(isURL){
                UIApplication.shared.open(isURL)
            }
            let elRequest = URLRequest(url: isURL)
            webView.load(elRequest)
            DataManager.shared.guardaImagen(isURL)
        }
    }
}

// Me permite agregar metodos y propiedades a una clase sin tener que heredarla y reemplazar las clases en el codigo
extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.solecito.stopAnimating()
    
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        self.solecito.stopAnimating()
    }
}

