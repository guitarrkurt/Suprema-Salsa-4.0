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
    
    var banderaButton = true
    
    @IBAction func botonFavoritosAction(sender: UIButton) {
        if banderaButton {

            //Cambia la bandera
            banderaButton = false
    
            println("Boton Favorito Activado")
            
            self.botonFavoritos.setImage(UIImage(named: "start.png"), forState: UIControlState.Normal)
        }else{

            //Cambia la bandera
            banderaButton = true
            
            println("Boton Favorito Activado")
            
            //Regresa al estado inicial
            self.botonFavoritos.setImage(UIImage(named: "startWhite.png"), forState: UIControlState.Normal)

        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
