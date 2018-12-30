//
//  MeCell.swift
//  breakpoint
//
//  Created by tarek bahie on 12/30/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

class MeCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    

    func configureCell(profileImage : UIImage, email : String, content : String){
        self.profileImg.image = profileImage
        self.emailLbl.text = email
        self.messageLbl.text = content
    }

}
