//
//  OriginalTableViewCell.swift
//  Chat
//
//  Created by Masato Hayakawa on 2019/02/18.
//  Copyright © 2019 masappe. All rights reserved.
//

import UIKit

class OriginalTableViewCell: UITableViewCell {

    @IBOutlet weak var cellNameLabel: UILabel!
    @IBOutlet weak var cellTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
