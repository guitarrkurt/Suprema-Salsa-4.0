//
//  PrincipalTableViewCell.swift
//  Suprema Salsa
//
//  Created by guitarrkurt on 14/07/15.
//  Copyright (c) 2015 guitarrkurt. All rights reserved.
//

import UIKit

class PrincipalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imagen           : UIImageView!
    @IBOutlet weak var etiquetaTitulo   : UILabel!
    @IBOutlet weak var etiquetaPrecio   : UILabel!
    @IBOutlet weak var botonFavoritos   : UIButton!
    @IBOutlet weak var botonAgregar     : UIButton!
    @IBOutlet weak var `switch`         : UISwitch!
    @IBOutlet weak var queso            : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
