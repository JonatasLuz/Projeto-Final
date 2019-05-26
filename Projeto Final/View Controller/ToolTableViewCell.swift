//
//  ToolTableViewCell.swift
//  Projeto Final
//
//  Created by Guest User on 26/05/19.
//  Copyright © 2019 Jonatas da Luz. All rights reserved.
//

import UIKit

class ToolTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var toolImageView: UIImageView!
    
    @IBOutlet weak var imageWC: NSLayoutConstraint!
    @IBOutlet weak var imageHC: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageWC.constant = toolImageView.frame.height
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
