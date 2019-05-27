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

    //Set the email and UserID from Firebase Auth
    func setUserInfo(_ userFirebaseId : String, _ userFirebaseEmail : String){
        self.userFirebaseId = userFirebaseId
        self.userFirebaseEmail = userFirebaseEmail
    }
    
    func getUser(_ userId : String, _ userEmail : String, _ userName : String , completion: @escaping ((User) -> Void)){
        var user = User()
        let userRef = db.collection("usuario")
        var firstName : String!
        var lastName : String!
        var wantList = [String]()
        var myGarden = [PlantedPlant]()
        var myAchievements = [String]()
        var planted = [String]()
        let myGardenRef = db.collection("usuario").document(Auth.auth().currentUser!.uid).collection("myGarden")
        userRef.document(Auth.auth().currentUser!.uid).getDocument { (querySnapshot, error) in
            if let error = error{
                print(error)
            }
            else{
                if querySnapshot != nil && querySnapshot?.get("firstName") != nil{
                    firstName = querySnapshot!.get("firstName") as? String
                    lastName = querySnapshot!.get("lastName") as? String
                    if querySnapshot!.get("want") != nil{
                        wantList = querySnapshot!.get("want") as! [String]
                    }
                    if querySnapshot!.get("myAchievements") != nil{
                        myAchievements = querySnapshot!.get("myAchievements") as! [String]
                    }
                    if querySnapshot!.get("planted") != nil{
                        planted = querySnapshot!.get("planted") as! [String]
                    }
                
                    myGardenRef.getDocuments { (querySnapShot, error) in
                        if querySnapShot != nil && querySnapShot!.count > 0{
                            for document in querySnapShot!.documents{
                                let plantId = document.get("plantId") as! String
                                let plantedDate = document.get("plantedDate") as! String
                                let harvestMinLimit = document.get("harvestMinLimit") as! String
                                let harvestMaxLimit = document.get("harvestMaxLimit") as! String
                                let plantedPlant = PlantedPlant(plantId, plantedDate, harvestMinLimit,harvestMaxLimit, document.documentID)
                                myGarden.append(plantedPlant)
                            }
                            user = User(userId, firstName, lastName , userEmail, wantList, myGarden, myAchievements, planted)
                            completion(user)
                        }
                        else{
                            user = User(userId, firstName, lastName , userEmail, wantList, myGarden, myAchievements, planted)
                            completion(user)
                        }
                    }
                }else{
                    
                    if let providerData = Auth.auth().currentUser?.providerData {
                        for userInfo in providerData {
                            switch userInfo.providerID {
                            case "facebook.com":
                                let request = GraphRequest(graphPath: "me", parameters: ["fields":"id,first_name, last_name, email"])
                                request.start(completionHandler: { (connection, result, error) -> Void in
                                    let userResult = result as! NSDictionary
                                    self.userFirebaseId = userResult.value(forKey: "id") as! String
                                    self.userFirstName = userResult.value(forKey: "first_name") as? String
                                    self.userLastName = userResult.value(forKey: "last_name") as? String
                                    self.userFirebaseEmail = userResult.value(forKey: "email") as! String
                                    self.createUserFacebook()
                                    let user = User(Auth.auth().currentUser!.uid, self.userFirstName, self.userLastName , userEmail, [String](), [PlantedPlant](), [String](), [String]())
                                    completion(user)
                                })
    
                            default:
                                let user = User(Auth.auth().currentUser!.uid, userName, userName , userEmail, [String](), [PlantedPlant](), [String](), [String]())
                                self.createUser(userName,userName)
                                completion(user)
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func createUser(_ firstName : String,_  lastName: String){
        db.collection("usuario").document(Auth.auth().currentUser!.uid).setData([
            "firstName" : firstName,
            "lastName" : lastName
            ])
    }
    
    func createUserFacebook(){
        db.collection("usuario").document(Auth.auth().currentUser!.uid).setData([
            "firstName" : self.userFirstName,
            "lastName" : self.userLastName
        ])
    }
}

