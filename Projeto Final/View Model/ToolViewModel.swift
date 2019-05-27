//
//  ToolViewModel.swift
//  Projeto Final
//
//  Created by Guest User on 26/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import Foundation
import FirebaseFirestore
class ToolViewModel{
    
    var db = Firestore.firestore().collection("utensilio")
    
    func getTools(completion: @escaping (([Tool]) -> Void) ){
        var tools = [Tool]()
        db.getDocuments { (querySnapshot, error) in
            if error != nil{
                print("Error on get tools \(error)")
            }else{
                for document in querySnapshot!.documents{
                    let name = document.get("name") as! String
                    let photoUrl = document.get("photo") as! String
                    var photo : UIImage!
                    self.getImage(photoUrl, completion: { (image) in
                        photo = image
                    })
                    let description = document.get("description") as! String
                    let tool = Tool(name, photo, description)
                    tools.append(tool)
                }
            }
            tools.sort(by: {$0.name < $1.name})
            completion(tools)
        }
    }
    
    func getImage(_ url : String, completion: @escaping (UIImage) -> Void) {
        do{
            let imageURL = try Data(contentsOf: URL.init(string: url)!)
            completion(UIImage(data: imageURL)!)
        }catch{
            print("Erro ao buscar imagem de planta \(error)")
        }
    }

    
}
