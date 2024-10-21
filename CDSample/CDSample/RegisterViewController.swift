//
//  RegisterViewController.swift
//  4Oct
//
//  Created by Alan Ulises on 05/10/24.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    
    var tecladoArriba = false
    var scrollView:UIScrollView?
    var txtNom:UITextField?
    var txtApp:UITextField?
    var txtMail:UITextField?
    var txtMail2:UITextField? // type: Optional UITextField
    var txtPassword: UITextField! // type : UITextField
    var textFieldWidth:CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow

        let btnSalir = UIButton(type: .custom)
            btnSalir.setTitle("Regresar a logiun", for: .normal)
            btnSalir.frame = CGRect(x: 0, y: 0, width: 120, height: 44)
            btnSalir.backgroundColor = .red
            btnSalir.addTarget(self, action: #selector(btnSalirTouch), for: .touchUpInside)
            //btnSalir.center = view.center
            view.addSubview(btnSalir)
            
            //Constraints, always after addSubview
            btnSalir.translatesAutoresizingMaskIntoConstraints = false
            btnSalir.widthAnchor.constraint(equalToConstant: 120).isActive = true
            btnSalir.heightAnchor.constraint(equalToConstant: 45).isActive = true
            // Consider comntraints direction affects the constant value
            btnSalir.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -25).isActive = true
            btnSalir.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        
        
        let btnRegistra = UIButton(type: .custom)
            btnRegistra.backgroundColor = .green
            btnRegistra.setTitle("Registrar", for: .normal)
            btnRegistra.setTitleColor(.darkGray, for: .normal)
            //btnSalir.frame = CGRect(x: 0, y: 0, width: 120, height: 44)
            
            
            btnRegistra.addTarget(self, action: #selector(btnRegistraTouch), for: .touchUpInside)
            view.addSubview(btnRegistra)
            //Constraints
            // posicionar el objeto, dinámicamente, usando constraints
            btnRegistra.translatesAutoresizingMaskIntoConstraints = false
            btnRegistra.widthAnchor.constraint(equalToConstant:120).isActive = true
            btnRegistra.heightAnchor.constraint(equalToConstant:45).isActive = true
            // considerar que la dirección de los constrainst afecta al valor de la constante
            btnRegistra.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant:-25).isActive = true
            btnRegistra.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant:25).isActive = true
            // Do any additional setup after loading the view.
        
        
        self.buildUX()
    }
    
    @objc func btnRegistraTouch() {
        
        guard let nombre = txtNom?.text,
              let apellidos = txtApp?.text,
              let correo = txtMail?.text,
              let password = txtPassword?.text
        else { return }
        
        let persona = Persona()
        persona.nombre = nombre
        persona.apellidos = apellidos
        persona.correo = correo
        persona.password = password
        
        // Referencia a AppDelegate
        if let ad = UIApplication.shared.delegate as? AppDelegate {
                    if let defPersona = NSEntityDescription.entity(forEntityName:"Persona", in: ad.persistentContainer.viewContext) {
                        let persona = NSManagedObject(entity: defPersona, insertInto:ad.persistentContainer.viewContext) as! Persona
                        persona.nombre=nombre
                        persona.apellidos=apellidos
                        persona.correo=correo
                        persona.password=password
                        ad.saveContext()
                        txtNom?.text = ""
                        txtApp?.text = ""
                        txtMail?.text = ""
                        txtMail2?.text = ""
                        txtPassword.text = ""
                    }
                }
        guard let urlAlArchivo = Bundle.main.url(forResource: "package_foo", withExtension:"xml")
        else { return }
        // encontrar la URL de destino para que el archivo pueda ser de L/E
        // en el caso de iOS no hay varios usuarios, pero igual tenemos que considerar que el método
        // devuelve un arreglo.
        if var urlDestino = FileManager.default.urls(for:.documentDirectory, in:.userDomainMask).first {
            urlDestino.append(component: "archivo.xml")
            do {
                try FileManager.default.copyItem(at: urlAlArchivo, to: urlDestino)
                print (urlDestino)
            } catch {
                print (error.localizedDescription)
        
        }
        }

    }

    @objc func btnSalirTouch() {
        print("Salir")
        dismiss(animated: true)
    }

    func buildUX() {
        textFieldWidth = (Utils.SCREEN_WIDTH - (Utils.kSeparator * 2))
            self.scrollView = UIScrollView(frame:CGRect.init(x:0.0, y:30.0, width:Utils.SCREEN_WIDTH, height:Utils.SCREEN_HEIGHT-140))
            self.view.addSubview(self.scrollView!) // Impoprtant for scroll
        var laY = Utils.kSeparator
        let lbl0 = UILabel(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kLabelHeight))
        lbl0.font = Utils.TITLE_FONT
            lbl0.text = "INFORMACION PERSONAL"
            self.scrollView!.addSubview(lbl0)
        laY += Utils.kLabelHeight + Utils.kSeparator
        let lbl1 = UILabel(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kLabelHeight))
        lbl1.font = Utils.REG_FONT
            lbl1.text = "Nombre (s)"
            self.scrollView!.addSubview(lbl1)
        laY += Utils.kLabelHeight + Utils.kSeparator
        self.txtNom = UITextField(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kTextFieldHeight))
        self.txtNom!.backgroundColor = Utils.txtBackColor
        self.txtNom!.textColor = Utils.txtForeColor
            self.scrollView!.addSubview(self.txtNom!)
        laY += Utils.kTextFieldHeight + Utils.kSeparator
        let lbl2 = UILabel(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kLabelHeight))
        lbl2.font = Utils.REG_FONT
            lbl2.text = "Apellido (s)"
            self.scrollView!.addSubview(lbl2)
        laY += Utils.kLabelHeight + Utils.kSeparator
        self.txtApp = UITextField(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kTextFieldHeight))
        self.txtApp!.backgroundColor = Utils.txtBackColor
        self.txtApp!.textColor = Utils.txtForeColor
            self.scrollView!.addSubview(self.txtApp!)
        laY += Utils.kTextFieldHeight + Utils.kSeparator
        let lbl3 = UILabel(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kLabelHeight))
        lbl3.font = Utils.REG_FONT
            lbl3.text = "Correo electrónico"
            self.scrollView!.addSubview(lbl3)
        laY += Utils.kLabelHeight + Utils.kSeparator
        self.txtMail = UITextField(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kTextFieldHeight))
        self.txtMail!.backgroundColor = Utils.txtBackColor
            self.txtMail!.keyboardType = .emailAddress
            self.txtMail!.autocapitalizationType = UITextAutocapitalizationType.none
            self.txtMail!.autocorrectionType = .no
            self.scrollView!.addSubview(self.txtMail!)
        laY += Utils.kTextFieldHeight + Utils.kSeparator
        let lbl4 = UILabel(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kLabelHeight))
        lbl4.font = Utils.REG_FONT
            lbl4.text = "Confirme su correo"
            self.scrollView!.addSubview(lbl4)
        laY += Utils.kLabelHeight + Utils.kSeparator
        self.txtMail2 = UITextField(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kTextFieldHeight))
        self.txtMail2!.backgroundColor = Utils.txtBackColor
            self.txtMail2!.keyboardType = .emailAddress
            self.txtMail2!.autocapitalizationType = UITextAutocapitalizationType.none
            self.txtMail2!.autocorrectionType = .no
            self.scrollView!.addSubview(self.txtMail2!)
        laY += Utils.kTextFieldHeight + Utils.kSeparator
        let lbl5 = UILabel(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kLabelHeight))
        lbl5.font = Utils.REG_FONT
            lbl5.text = "Password"
            self.scrollView!.addSubview(lbl5)
        laY += Utils.kLabelHeight + Utils.kSeparator
        self.txtPassword = UITextField(frame: CGRect.init(x:Utils.kSeparator, y:laY, width:textFieldWidth, height:Utils.kTextFieldHeight))
        self.txtPassword!.backgroundColor = Utils.txtBackColor
            self.scrollView!.addSubview(self.txtPassword!)
            self.scrollView!.contentSize = (scrollView?.frame.size)!
        
        // This is used to call hide the keyboard function in tapped
            let tap = UITapGestureRecognizer(target: self, action:#selector(tapped))
            self.scrollView!.addGestureRecognizer(tap)
        }
    @objc func tapped(){
        // This chage the value to null
        txtNom?.resignFirstResponder()
        txtApp?.resignFirstResponder()
        txtMail?.resignFirstResponder()
        txtMail2?.resignFirstResponder()
        txtPassword.resignFirstResponder()
        //viewDidAppear(true)
    }
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(tecladoAparece(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(tecladoDesaparece(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func tecladoAparece(_ notification: Notification) {
        print("Up Keyborad")
        if tecladoArriba{return }
        ajustarVista(notification,true)
    }
    @objc func tecladoDesaparece(_ notification: Notification) {
        print("Down Keyborad")
        ajustarVista(notification,false)
    }
    
    func ajustarVista(_ notification:Notification,_ up:Bool) {
        
        let info:Dictionary = notification.userInfo!
        let value = info [UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let frameTeclado = value.cgRectValue
        var contentSize = self.scrollView!.contentSize
         
        if up {
            contentSize.height += frameTeclado.size.height;
            }
        else {
            contentSize.height -= frameTeclado.size.height;
        }
        self.scrollView!.contentSize = contentSize;
        self.tecladoArriba = up
        }
         



}
