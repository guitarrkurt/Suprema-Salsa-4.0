//
//  NewsTableViewCell.swift
//  Suprema Salsa
//
//  Created by guitarrkurt on 19/07/15.
//  Copyright (c) 2015 guitarrkurt. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var etiquetaTitulo: UILabel!
    @IBOutlet weak var etiquetaBody: UILabel!
    @IBOutlet weak var botonDescuento: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
