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
    
    func getData(completion: @escaping ()->()){
        
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
                        
                    }
                }else{
                    self.createUserFacebook()
                    print("Nao ha user")
                    
                    
                }
                completion()
            }
        }
        
    }
    //Set the email and UserID from Firebase Auth
    func setUserInfo(_ userFirebaseId : String, _ userFirebaseEmail : String){
        self.userFirebaseId = userFirebaseId
        self.userFirebaseEmail = userFirebaseEmail
    }
    
    func getUserData(completion: @escaping ()->()){
        getData {
            completion()
        }

        let request = GraphRequest(graphPath: "me", parameters: ["fields":"id, first_name, last_name"])
        request.start(completionHandler: { (connection, result, error) -> Void in
            let user = result as! NSDictionary
            self.userFirstName = user.value(forKey: "first_name") as? String
            self.userLastName = user.value(forKey: "last_name") as? String
            completion()
        })
    }
    
    func getUser(_ userId : String, _ userEmail : String, completion: @escaping ((User) -> Void)){
        var user : User!
        let userRef = db.collection("usuario")
        userRef.document(userId)
        userRef.getDocuments { (querySnapshot, error) in
            if let error = error{
                print(error)
            }
            else{
                if querySnapshot != nil && querySnapshot!.count > 0{
                    print("Ha users")
                    for userData in querySnapshot!.documents{
                        let firstName = userData.get("firstName") as! String
                        let lastName = userData.get("lastName") as! String
                        var wantList = [String]()
                        if userData.get("want") != nil{
                            wantList = userData.get("want") as![String]
                        }
                        var myGarden = [String]()
                        if userData.get("myGarden") != nil{
                            myGarden = userData.get("myGarden") as! [String]
                        }
                        var myAchievements = [String]()
                        if userData.get("myAchievements") != nil{
                            myAchievements = userData.get("myAchievements") as! [String]
                        }
                        var planted = [String]()
                    
                        if userData.get("planted") != nil{
                            planted = userData.get("planted") as! [String]
                        }
                        user = User(userId, firstName, lastName , userEmail, wantList, myGarden, myAchievements, planted)
                        
                    }
                }
                else{
                    user = User()
                    print("Nao ha users")
                    
                }
            }
            completion(user)
        }
    }
    
    
    
    func createUserFacebook(){
        print(self.userFirstName)
        db.collection("usuario").document(self.userFirebaseId).setData([
            "firstName" : self.userFirstName,
            "lastName" : self.userLastName
        ])
    }
}
