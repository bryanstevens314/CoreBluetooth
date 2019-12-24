//
//  TableViewCell.swift
//  Core_Bluetooth
//
//  Created by Bryan Stevens on 1/29/19.
//  Copyright © 2019 IGMOTIVE. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var peripheral_Name: UILabel!
    @IBOutlet weak var uuid_Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
