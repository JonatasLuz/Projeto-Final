//
//  ViewController.swift
//  Projeto Final
//
//  Created by ALUNO on 08/04/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import UIKit
import Firebase
import FacebookLogin

class Login: UIViewController {
    


    @IBOutlet weak var loginExterno: UIView!
    

    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var signUp: UIButton!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginFacebookbutton = LoginButton(readPermissions: [ .publicProfile ])
        
        loginExterno.addSubview(loginFacebookbutton)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func sigIn(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: email.text ?? "", password: password.text ?? "") { (authResult, error) in
            
        }
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: email.text ?? "email", password: password.text ?? "") { (authResult, error) in
            guard (authResult?.user) != nil
                else {
                    print("Erro no cadastro:  \(error)")
                return
            }
        }
    }
    
}

