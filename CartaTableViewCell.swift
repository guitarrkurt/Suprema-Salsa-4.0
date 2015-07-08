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
    @IBOutlet weak var switchCarta: UISwitch!
    @IBOutlet weak var precioCarta: UILabel!
    @IBOutlet weak var labelCantidad: UILabel!
    @IBOutlet weak var stepperOutlet: UIStepper!
    
    @IBAction func stepperAction(sender: UIStepper) {
        println("Cantidad: \(Int(sender.value).description)")
        self.labelCantidad.text = "Cantidad: \(Int(sender.value).description)"
    }
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
