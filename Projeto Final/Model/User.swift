//
//  User.swift
//  Projeto Final
//
//  Created by ALUNO on 20/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import Foundation

class User{
    var userId : String!
    var firstName : String!
    var lastName : String!
    var email : String!
    var wantList: [String]!
    var myGarden : [String]!
    var myAchievements : [String]!
    var planted : [String]!
    
    init(_ userId : String, _ firstName : String, _ lastName : String, _ email: String, _ wantList : [String], _ myGarden : [String], _ myAchievements : [String], _ planted : [String] ){
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.wantList = wantList
        self.myGarden = myGarden
        self.myAchievements = myAchievements
        self.planted = planted
    }
    
    
}
