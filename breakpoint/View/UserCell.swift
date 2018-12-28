//
//  UserCell.swift
//  breakpoint
//
//  Created by tarek bahie on 12/28/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var checkmarkLbl: UIImageView!
    
    var showing = false
    
    
    
    
    func configureCell(profileImage image : UIImage, email : String, isSelected : Bool){
        self.profileImg.image = image
        self.emailLbl.text = email
        if isSelected {
            self.checkmarkLbl.isHidden = false
        } else {
            self.checkmarkLbl.isHidden = true
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if showing == false{
            checkmarkLbl.isHidden = false
                showing = true
        }else {
            checkmarkLbl.isHidden = true
                showing = false
        }
        }
    }

}
