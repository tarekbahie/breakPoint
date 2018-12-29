//
//  GroupCell.swift
//  breakpoint
//
//  Created by tarek bahie on 12/29/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var membersLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(withTitle title : String, withDescription description : String, andMembers members : Int){
        self.titleLbl.text = title
        self.descriptionLbl.text = description
        self.membersLbl.text = "\(members) members"
    }
    

}
