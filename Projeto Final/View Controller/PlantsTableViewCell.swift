//
//  PlantsTableViewCell.swift
//  Projeto Final
//
//  Created by ALUNO on 22/04/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import UIKit

class PlantsTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var plantNameLabel: UILabel!
    @IBOutlet weak var plantImage: UIImageView!
    override func awakeFromNib() {
        plantNameLabel.centerYAnchor.constraint(equalTo: plantImage.centerYAnchor, constant: 1).isActive = true
        plantImage.layer.borderWidth = 5
        plantImage.layer.borderColor = plantNameLabel.textColor.cgColor
        plantImage.layer.cornerRadius = plantImage.frame.height/2
        plantImage.layer.masksToBounds = true        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
