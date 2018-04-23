//
//  PostTableViewCell.swift
//  Joystick Junkies
//
//  Created by Bonala,Santhosh on 4/22/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    // this is a reference outlet which holds post name label
    @IBOutlet weak var postname: UILabel!
    
    // this is a reference outlet which holds post basebid label
    @IBOutlet weak var postBaseBid: UILabel!
    
    // this is a reference outlet which holds post image view
    @IBOutlet weak var postImage: UIImageView!
    
}
