//
//  CartaTableViewCell.swift
//  Suprema Salsa
//
//  Created by guitarrkurt on 07/07/15.
//  Copyright (c) 2015 guitarrkurt. All rights reserved.
//

import UIKit

class CartaTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCarta: UIImageView!
    @IBOutlet weak var nameCarta: UILabel!
    @IBOutlet weak var addCarritoCarta: UIButton!
    //@IBOutlet weak var pickerCarta: UIPickerView!
    @IBOutlet weak var switchCarta: UISwitch!
    @IBOutlet weak var precioCarta: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
