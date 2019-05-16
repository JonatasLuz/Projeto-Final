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
import FacebookCore

class Login: UIViewController {
    

    @IBOutlet weak var logo: UILabel!
    
    @IBOutlet weak var loginExterno: UIView!
    

    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var signUp: UIButton!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let loginFacebookbutton = LoginButton(readPermissions: [ .publicProfile, .email,])
        // loginExterno.addSubview(loginFacebookbutton)
        // loginFacebookbutton.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        logo.adjustsFontSizeToFitWidth = true
    }

    @IBAction func sigIn(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: email.text ?? "", password: password.text ?? "") { (authResult, error) in
        
        }
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: email.text ?? "email", password: password.text ?? "") { (authResult, error) in
            guard (authResult?.user) != nil
                else {
                    print("Erro no cadastro:  \(String(describing: error))")
                return
            }
        }
    }
}

/*
extension Login : LoginButtonDelegate{
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        //if let acessToken = AccessToken.current{
            //let credential = FacebookAuthProvider.credential(withAccessToken: acessToken.userId!)
           
        //}
        let acessToken = AccessToken.current
        let credential = FacebookAuthProvider.credential(withAccessToken: (acessToken?.authenticationToken)!)
        //Auth.auth().signIn(with: credencial)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
        
        }
    
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
       
    }
 
}*/

