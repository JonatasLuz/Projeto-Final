//
//  LoginViewModel.swift
//  Projeto Final
//
//  Created by Guest User on 19/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import Foundation
import Firebase
import FacebookCore
import FBSDKCoreKit
import FirebaseFirestore


class LoginViewModel{
    let db = Firestore.firestore()
    var userFirebaseId : String!
    var userFirebaseEmail: String!
    var userFirstName : String!
    var userLastName : String!
    init (){
    }
    
    func getData(completion: @escaping ([String]) -> Void ){
        
        let userRef = db.collection("usuario")
        userRef.document(userFirebaseId)
        userRef.getDocuments { (querySnapShot, error) in
            print("Document")
            if let error = error{
                print("Erro \(error)")
            }else{
                if querySnapShot != nil && querySnapShot?.count != 0{
                    for user in querySnapShot!.documents{
                        let userInfo = user.data()
                        print("Ha user")
                        print(userInfo)
                    }
                }else{
                    self.createUserFacebook()
                    print("Nao ha user")
                    
                }
                completion(["eita"])
            }
        }
        
    }
    //Set the email and UserID from Firebase Auth
    func setUserInfo(_ userFirebaseId : String, _ userFirebaseEmail : String){
        self.userFirebaseId = userFirebaseId
        self.userFirebaseEmail = userFirebaseEmail
    }
    
    func getUserData(completion: @escaping ()->()){
        getData { (userArray) in
            completion()
        }
        
        
        let request = GraphRequest(graphPath: "me", parameters: ["fields":"id, first_name, last_name, middle_name"])
        request.start(completionHandler: { (connection, result, error) -> Void in
            let user = result as! NSDictionary
            
            self.userFirstName = user.value(forKey: "first_name") as? String
            self.userLastName = user.value(forKey: "last_name") as! String
            completion()
        })
    }
    func createUserFacebook(){
        print(self.userFirstName)
        db.collection("usuario").document(self.userFirebaseId).setData([
            "firstName" : self.userFirstName,
            "lastName" : self.userLastName
        ])
    }
}
