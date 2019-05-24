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
        var user = User()
        let userRef = db.collection("usuario")
        var firstName : String!
        var lastName : String!
        var wantList = [String]()
        var myGarden = [PlantedPlant]()
        var myAchievements = [String]()
        var planted = [String]()
        let myGardenRef = db.collection("usuario").document(userId).collection("myGarden")
        userRef.document(userId)
        userRef.getDocuments { (querySnapshot, error) in
            if let error = error{
                print(error)
            }
            else{
                if querySnapshot != nil && querySnapshot!.count > 0{
                    for userData in querySnapshot!.documents{
                        firstName = userData.get("firstName") as? String
                        lastName = userData.get("lastName") as? String
                        if userData.get("want") != nil{
                            wantList = userData.get("want") as! [String]
                        }
                        if userData.get("myAchievements") != nil{
                            myAchievements = userData.get("myAchievements") as! [String]
                        }
                        if userData.get("planted") != nil{
                            planted = userData.get("planted") as! [String]
                        }
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
                }
            }
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

