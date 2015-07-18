//
//  CarritoViewController.swift
//  Suprema Salsa
//
//  Created by guitarrkurt on 08/07/15.
//  Copyright (c) 2015 guitarrkurt. All rights reserved.
//

import UIKit

class CarritoViewController: UIViewController, UITableViewDataSource {

    //MARK: Propertys
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var botonCompraEfectivo: UIButton!
    @IBOutlet weak var etiquetaTotal: UILabel!
    @IBOutlet weak var botonCupon: UIButton!
    
    var arrayCarrito: NSMutableArray = NSMutableArray()
    var arrayEnviar : NSMutableArray = NSMutableArray()
    var producto    : productos      = productos()
    var titulo      : String         = String()
    var detalle     : String         = String()
    var total       : Float          = Float()
    
    //MARK: Constructor
    override func viewDidLoad() {
        super.viewDidLoad()

        //Bordes del botonCupon
        botonCupon.layer.cornerRadius = 5
        botonCupon.layer.borderWidth = 1
        botonCupon.layer.borderColor = UIColor.orangeColor().CGColor
        
        //Hacemos el LOOP FOR por un tes donde al hacer SCROLL UP el precio incrementa
        for var index=0; index < arrayCarrito.count; ++index{
            
            producto = arrayCarrito.objectAtIndex(index) as! productos
            
            if producto.QuesoOnP == 1{
                
                titulo = "\(producto.NombreP) con Queso"
                arrayEnviar.addObject(titulo)
                detalle = "$ \(producto.PrecioQuesoP)"
                arrayEnviar.addObject(detalle)
                //Suma
                total += producto.PrecioQuesoP
                
            }else{
                
                titulo = "\(producto.NombreP)"
                arrayEnviar.addObject(titulo)
                detalle = "$ \(producto.PrecioP)"
                arrayEnviar.addObject(detalle)
                //Suma
                total += producto.PrecioP
            }
        }
        //Al final anadimos el Precio Total
        arrayEnviar.addObject("Total: $ \(total)")
        
        //Etiqueta con el total
        etiquetaTotal.text = "Total: $ \(total)"

    }

    //MARK: TableView Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrayCarrito.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("carritoCellIdentifier", forIndexPath: indexPath) as! UITableViewCell
        
        producto = arrayCarrito.objectAtIndex(indexPath.row) as! productos
        
        if producto.QuesoOnP == 1{
            
            //Title
            titulo = "\(producto.NombreP) con Queso"
            cell.textLabel?.text = titulo
            //Detail
            detalle = "$ \(producto.PrecioQuesoP)"
            cell.detailTextLabel?.text = detalle

        }else{
            
            //Title
            titulo = "\(producto.NombreP)"
            cell.textLabel?.text = titulo
            //Detail
            detalle = "$ \(producto.PrecioP)"
            cell.detailTextLabel?.text = detalle

        }
        
        return cell
    
    }
    
    //MARK: Buttons Actions
    @IBAction func botonCuponAction(sender: UIButton) {

    }
    
    @IBAction func compraEfectivoAction(sender: UIButton) {
        //Alerta
        let alert = UIAlertView()
        alert.delegate = self
        alert.title = "Confirmar Pedido"
        alert.message = "Se hace el pedido a Juanito Perez\n Desea Confirmar"
        alert.addButtonWithTitle("Cancelar")
        alert.addButtonWithTitle("Enviar")
        alert.show()

    }
    
    //MARK: AlertView
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        
        switch buttonIndex{
            
        //Cancelar
        case 0:
            println("Cancelar")
            //No hagas nada
            break;
        //Enviar
        case 1:
            println("Enviar")
            /*for var i = 0; i < arrayEnviar.count; ++i{
            var texto = arrayEnviar.objectAtIndex(i) as! String
            println(texto)
            }*/
            
            //Preparamos para enviar
            //arrayEnviar
            break;
            
        default:
            break;
        }
    }
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
