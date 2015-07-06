//
//  PromosTableViewCell.swift
//  Suprema Salsa
//
//  Created by guitarrkurt on 04/07/15.
//  Copyright (c) 2015 guitarrkurt. All rights reserved.
//

import UIKit

class PromosTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var labelBodyCell: UILabel!
    @IBOutlet weak var labelPrecioCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
