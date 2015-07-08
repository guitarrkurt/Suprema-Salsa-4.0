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
    
    //Respaldo Precio Inicial
    var banderaInicio = true
    var queso: Float = 5.0
    //Stepper
    var valorStepper: Float = 1.0

    //Switch
    var primeraVezReboteSwitch = true
    var respaldoPrecio: Float = Float()
    var conQueso: Float = Float()
    
    @IBAction func stepperAction(sender: UIStepper) {
        respaldoPrecioInicial()
        //Obtenemos el valor del steppler
        valorStepper = Float(sender.value)
        println("Cantidad: \(valorStepper.description)")
        //Etiqueta arriba del steppler
        self.labelCantidad.text = "Cantidad: \(valorStepper.description)"
        
        //Calculamos el precio * por el steppler(cantidad de productos)
        //Y lo desplegamos en la etiqueta precio
        var total = respaldoPrecio * valorStepper
        self.precioCarta.text = "\(total)"
        
        
    }
    
    @IBAction func switchAction(sender: UISwitch) {
        respaldoPrecioInicial()

            if switchCarta.on{
                
                var aux1 = respaldoPrecio * valorStepper
                var quesoPorRacionCantidad = queso * valorStepper
                var aux2 = aux1 + quesoPorRacionCantidad
                precioCarta.text = "\(aux2)"
            }else{
                
                precioCarta.text = "\(respaldoPrecio * valorStepper)"
            }
    
    
    }

    func respaldoPrecioInicial(){
        
        if banderaInicio == true {
            banderaInicio = false
            
            var aux1 = (precioCarta.text as? NSString)
            println("aux1: \(aux1)")
            
            var aux2 = aux1?.floatValue
            println("aux2: \(aux2)")
            
            respaldoPrecio = aux2!
            println("primeraVezRespaldoPrecio: \(respaldoPrecio)")
        
        }

    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        println("Entro awakeFromNib")
 
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
