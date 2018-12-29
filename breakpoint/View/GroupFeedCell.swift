//
//  GroupFeedCell.swift
//  breakpoint
//
//  Created by tarek bahie on 12/29/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userLbl: UILabel!
    @IBOutlet weak var groupFeedLbl: UILabel!
    
    func configureCell(image : UIImage, email : String, groupFeed : String){
        self.profileImg.image = image
        self.userLbl.text = email
        self.groupFeedLbl.text = groupFeed
    }

}
