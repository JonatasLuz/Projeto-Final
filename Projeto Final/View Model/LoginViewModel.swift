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
    init (){
    }
    
    func getData(completion: @escaping ([String]) -> Void ){
        
        let userRef = db.collection("usuario")
        print(userFirebaseId)
        
        
        userRef.document(userFirebaseId)
        
        userRef.getDocuments { (querySnapShot, error) in
            print("Document")
            
            if let error = error{
                print("Erro \(error)")
            }else{
                if querySnapShot != nil{
                    for user in querySnapShot!.documents{
                        let userInfo = user.data()
                        print("Ha user")
                        print(userInfo)
                        
                    }
                }else{
                    print("Nao ha user")
                    
                }
            }
        }
        
    }
    
    func setUserId(_ userFirebirdId : String){
        self.userFirebaseId = userFirebirdId
    }
    
    func getUserData(completion: @escaping ()->()){
        //var userArray = [String]()
        getData { (userArray) in
            print("eita")
        
        }
        
        
        let request = GraphRequest(graphPath: "me", parameters: ["fields":"id, email, name, picture.width(480).height(480)"])
        request.start(completionHandler: { (connection, result, error) -> Void in
            let teste = result as! NSDictionary
        })
    }
}
