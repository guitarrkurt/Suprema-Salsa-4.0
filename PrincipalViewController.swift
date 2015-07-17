//
//  PrincipalViewController.swift
//  Suprema Salsa
//
//  Created by guitarrkurt on 14/07/15.
//  Copyright (c) 2015 guitarrkurt. All rights reserved.
//

import UIKit

class PrincipalViewController: UIViewController, UITableViewDataSource, UICollectionViewDataSource {

    //MARK: Propertys
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var segmentPrincipal: UISegmentedControl!
    @IBOutlet weak var segmentCarta: UISegmentedControl!
    @IBOutlet weak var myTableView: UITableView!
    
    var arrayQuery    : NSMutableArray    =   NSMutableArray()
    var producto      : productos         =   productos()
    
    //UPDATEs en botonFavoritosAction:
    var IdP           : Int               = Int()
    //Persistencia Switches
    var arraySwitches : NSMutableArray    = NSMutableArray()
    //Persistencia Favoritos
    var arrayFavoritos: NSMutableArray    = NSMutableArray()


    //MARK: Constructor
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        //Ocultamos segmentCarta
        self.segmentCarta.hidden = true
        //Consulta de lo primero que vamos a cargar
        arrayQuery  = ModelManager.instance.selectPaquetes()
        
    }

    //MARK: Actions

    @IBAction func segmentPrincipalAction(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        //Paquetes
        case 0:
            self.segmentCarta.hidden = true
            arrayQuery = []
            arrayQuery = ModelManager.instance.selectPaquetes()
            break;
        //Carta
        case 1:
            self.segmentCarta.hidden = false
                arrayQuery = []
                arrayQuery = ModelManager.instance.selectTodo()
                segmentCarta.selectedSegmentIndex = 0
            break;
        default:
            break;
        }
        self.myTableView.reloadData()
        println("myTableView.reloadData() in segmentPrincipalAction")
    }
    
    @IBAction func segmentCartaAction(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        //Todo
        case 0:
            arrayQuery = []
            arrayQuery = ModelManager.instance.selectTodo()
            break;
        //⭐️
        case 1:
            arrayQuery = []
            arrayQuery = ModelManager.instance.selectFavoritos()
            break;
        //Pastor
        case 2:
            arrayQuery = []
            arrayQuery = ModelManager.instance.selectPastor()
            break;
        //Arabe
        case 3:
            arrayQuery = []
            arrayQuery = ModelManager.instance.selectArabe()
            break;
        //Bebida
        case 4:
            arrayQuery = []
            arrayQuery = ModelManager.instance.selectBebidas()
            break;
        default:
            break;
        }
        self.myTableView.reloadData()
        println("myTableView.reloadData() in segmentCartaAction")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: TableView Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //Persistencia Switches y Favoritos
        arraySwitches  = []
        arrayFavoritos = []
        for var i = 0; i < arrayQuery.count; ++i{
            arraySwitches.addObject("")
            arrayFavoritos.addObject("")
        }
        //Numero de filas
        return arrayQuery.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("PrincipalTableViewCell", forIndexPath: indexPath) as! PrincipalTableViewCell
        
        producto = arrayQuery[indexPath.row] as! productos

        //Si el producto NO usa Queso y es Promo oculta el queso y como es Promo en ves de estrella lleva un TIF
        if producto.Queso == 0 && producto.Promo == 1{
            println("NO lleva Queso y SI es Promo")
            cell.`switch`.hidden = true
            cell.queso.hidden    = true

            cell.imagen.image           = UIImage(named: producto.ImagenP)
            cell.etiquetaTitulo.text    = producto.NombreP
            cell.etiquetaPrecio.text    = "$ \(producto.PrecioP)"
            //cell.botonFavoritos.setImage(UIImage(named: "tif.png"), forState: UIControlState.Normal)
            //Identificamos que este boton es TIF
            cell.botonFavoritos.tag = -1
            
        }
        else if producto.Queso == 0{
            println("Solo NO lleva Queso y NO es Promo)")
            cell.`switch`.hidden = true
            cell.queso.hidden    = true
            
            cell.imagen.image           = UIImage(named: producto.ImagenP)
            cell.etiquetaTitulo.text    = producto.NombreP
            cell.etiquetaPrecio.text    = "$ \(producto.PrecioP)"
            //cell.botonFavoritos.setImage(UIImage(named: "startWhite.png"), forState: UIControlState.Normal)
            //Pasamos el IdP de la celda
            cell.botonFavoritos.tag = producto.IdP
            
            //Persistencia Favoritos toma DB y refleja
            if producto.Favorito == 1{
                arrayFavoritos.replaceObjectAtIndex(indexPath.row, withObject: "ON")
            }else{
                arrayFavoritos.replaceObjectAtIndex(indexPath.row, withObject: "OFF")
            }
            
        }
        else{
            println("Producto que SI lleva Queso")
            cell.`switch`.hidden = false
            cell.queso.hidden    = false
            
            cell.imagen.image           = UIImage(named: producto.ImagenP)
            cell.etiquetaTitulo.text    = producto.NombreP
            cell.etiquetaPrecio.text    = "$ \(producto.PrecioP)"
            //cell.botonFavoritos.setImage(UIImage(named: "start.png"), forState: UIControlState.Normal)
            //Pasamos el IdP de la celda
            cell.botonFavoritos.tag = producto.IdP
            
            //Persistencia Favoritos toma DB y refleja
            if producto.Favorito == 1{
                arrayFavoritos.replaceObjectAtIndex(indexPath.row, withObject: "ON")
            }else{
                arrayFavoritos.replaceObjectAtIndex(indexPath.row, withObject: "OFF")
            }

        }

        //Persistencia Favoritos
        cell.botonFavoritos.addTarget(self, action: "botonFavoritosAction:", forControlEvents: .TouchUpInside)
        if (arrayFavoritos.objectAtIndex(indexPath.row) as! String) == "ON"{
            cell.botonFavoritos.setImage(UIImage(named: "start.png"), forState: UIControlState.Normal)
        }else{
            if cell.botonFavoritos.tag == -1{
                
                cell.botonFavoritos.setImage(UIImage(named: "tif.png"), forState: UIControlState.Normal)
            }else{
                cell.botonFavoritos.setImage(UIImage(named: "startWhite.png"), forState: UIControlState.Normal)
            }
        }
        //Persistencia Switches
        cell.`switch`.addTarget(self, action: "switchAction:", forControlEvents: .ValueChanged)
        if (arraySwitches.objectAtIndex(indexPath.row) as! String) == "ON"{
            cell.`switch`.on = true
        }else{
            cell.`switch`.on = false
        }
        
        //Agregar al carrito
        cell.botonAgregar.addTarget(self, action: "botonAgregarAction:", forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    func switchAction(sender: UISwitch){
        var theParentCell = (sender.superview?.superview as! PrincipalTableViewCell)
        var indexPathOfSwitch = myTableView.indexPathForCell(theParentCell)
        
        if sender.on {
            arraySwitches.replaceObjectAtIndex(indexPathOfSwitch!.row, withObject: "ON")
            
        }else{
            arraySwitches.replaceObjectAtIndex(indexPathOfSwitch!.row, withObject: "OFF")
        }
        
    }

    func botonAgregarAction(sender: UIButton!){
    
        println("Agregar al carrito")
    }
    
    
    func botonFavoritosAction(sender:UIButton!){
        var theParentCell = (sender.superview?.superview as! PrincipalTableViewCell)
        var indexPathOfSwitch = myTableView.indexPathForCell(theParentCell)

        //Si es tif
        if sender.tag == -1{
            println("Boton es tif")
            let mensaje = "💡La certificación TIF (Tipo de Inspección Federal) es un reconocimiento que la Secretaría de Agricultura, Ganadería y Desarrollo Rural (SAGAR) otorga a las plantas procesadoras de carnes que cumplen con todas las normas y exigencias del Gobierno Mexicano, en cuanto a su tratamiento y manejo de sanidad se refiere. Esta certificación trae consigo una serie de beneficios a la industria cárnica, ya que le permite la movilización dentro del país de una manera más fácil ya que cuenta con la garantía de la calidad sanitaria con la que fue elaborado el producto."
            let alertView = UIAlertView(title: "Calidad TIF", message: mensaje, delegate: nil, cancelButtonTitle: "🍖 Ok 😍")
                alertView.show()
        }else{
            IdP = sender.tag
            //Si esta seleccionado SegmentControlFavoritos⭐️ eliminamos la celda de la tabla
            if segmentCarta.selectedSegmentIndex == 1{
                println("Boton Favorito 🌠Desactivado")
                ModelManager.instance.updateFavoritoOFF(IdP)
                sender.setImage(UIImage(named: "startWhite.png"), forState: UIControlState.Normal)
                //Persistencia
                arrayFavoritos.replaceObjectAtIndex(indexPathOfSwitch!.row, withObject: "OFF")
                
                arrayQuery = []
                arrayQuery = ModelManager.instance.selectFavoritos()
                myTableView.reloadData()
            }else{
                
                if  (arrayFavoritos.objectAtIndex(indexPathOfSwitch!.row) as! String) == "ON"{
                    println("Boton Favorito 🌠Desactivado")
                    ModelManager.instance.updateFavoritoOFF(IdP)
                    sender.setImage(UIImage(named: "startWhite.png"), forState: UIControlState.Normal)
                    //Persistencia
                    arrayFavoritos.replaceObjectAtIndex(indexPathOfSwitch!.row, withObject: "OFF")
                }else{
                    println("Boton Favorito ⭐️Activado")
                    ModelManager.instance.updateFavoritoON(IdP)
                    sender.setImage(UIImage(named: "start.png"), forState: UIControlState.Normal)
                    //Persistencia
                    arrayFavoritos.replaceObjectAtIndex(indexPathOfSwitch!.row, withObject: "ON")
                }
                
            }

        }
        

    }
    
    
    
    
    
    
    
    
    
    
    //MARK - CollectionView Data Source
    /*
    
    
    
    
    //El de abajo
    
    
    
    */
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 1
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("PrincipalCollectionViewCell", forIndexPath: indexPath) as! PrincipalCollectionViewCell
        
            cell.imagen.image = UIImage(named: "chesee.png")
        return cell
        
    }

    //MARK: Others
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
