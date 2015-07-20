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
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var arrayQuery     : NSMutableArray    =   NSMutableArray()
    var producto       : productos         =   productos()
    
    //UPDATEs en botonFavoritosAction:
    var IdP            : Int               = Int()
    //Persistencia Switches
    var arraySwitches  : NSMutableArray    = NSMutableArray()
    //Persistencia Favoritos
    var arrayFavoritos : NSMutableArray    = NSMutableArray()
    //Persistencia EtiquetaPrecio
    var arrayPrecio    : NSMutableArray    = NSMutableArray()


    /*----------Collection Carrito Compras------*/
    var arrayCarrito            : NSMutableArray           = NSMutableArray()
    //persistencia Imagen Sub
    var arraySubImageCarrito    : NSMutableArray           = NSMutableArray()
    var index                   :Int                       = Int()
    
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

    //MARK: Segments

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
            println("bebidas")
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
        arrayPrecio    = []
        for var i = 0; i < arrayQuery.count; ++i{
            arraySwitches.addObject("")
            arrayFavoritos.addObject("")
            arrayPrecio.addObject("")
        }
        //Numero de filas
        return arrayQuery.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("PrincipalTableViewCell", forIndexPath: indexPath) as! PrincipalTableViewCell
        
        producto = arrayQuery[indexPath.row] as! productos
        println("\(producto.NombreP)")
        //Si el producto NO usa Queso y es Promo oculta el queso y como es Promo en ves de estrella lleva un TIF
        if producto.Queso == 0 && producto.Promo == 1{
            println("NO lleva Queso y SI es Promo 🍖")
            cell.`switch`.hidden = true
            cell.queso.hidden    = true

            cell.imagen.image           = UIImage(named: producto.ImagenP)
            cell.etiquetaTitulo.text    = producto.NombreP
            //cell.etiquetaPrecio.text    = "$ \(producto.PrecioP)"
            //Persistencia etiquetaPrecio 💰
            arrayPrecio.replaceObjectAtIndex(indexPath.row, withObject: "$ \(producto.PrecioP)")
            arrayPrecio.addObject("\(producto.PrecioP)")
            //Identificamos que este boton es TIF
            cell.botonFavoritos.tag = -1
            //Agregar al carrito 🚗
            cell.botonAgregar.tag   = producto.IdP
            
        }
        else if producto.Queso == 0{
            println("Solo NO lleva Queso y NO es Promo)")
            cell.`switch`.hidden = true
            cell.queso.hidden    = true
            
            cell.imagen.image           = UIImage(named: producto.ImagenP)
            cell.etiquetaTitulo.text    = producto.NombreP
            //cell.etiquetaPrecio.text    = "$ \(producto.PrecioP)"
            //Persistencia etiquetaPrecio 💰
            arrayPrecio.replaceObjectAtIndex(indexPath.row, withObject: "$ \(producto.PrecioP)")
            //Pasamos el IdP de la celda
            cell.botonFavoritos.tag = producto.IdP
            //Agregar al carrito 🚗
            cell.botonAgregar.tag   = producto.IdP
            
            //Persistencia Favoritos toma DB y refleja ⭐️
            if producto.Favorito == 1{
                arrayFavoritos.replaceObjectAtIndex(indexPath.row, withObject: "ON")
                println("Solo NO lleva Queso y NO es Promo FAVORITO ON)")
            }else{
                arrayFavoritos.replaceObjectAtIndex(indexPath.row, withObject: "OFF")
                println("Solo NO lleva Queso y NO es Promo FAVORITO OFF)")
            }
            
        }
        else{
            println("Producto que SI lleva Queso")
            cell.`switch`.hidden = false
            cell.queso.hidden    = false
            
            cell.imagen.image           = UIImage(named: producto.ImagenP)
            cell.etiquetaTitulo.text    = producto.NombreP
            //cell.etiquetaPrecio.text    = "$ \(producto.PrecioP)"
            //Persistencia etiquetaPrecio 💰
            //A pesar de que es posible que lleve Queso el Switch aun no se ha activado
            //Por eso le pasamos el Precio corriente
            

            if (arraySwitches.objectAtIndex(indexPath.row) as! String) == "ON"{
                cell.`switch`.on = true
                
                //Persistencia EtiquetaPrecio 💰
                cell.etiquetaPrecio.text = arrayPrecio.objectAtIndex(indexPath.row) as? String
                println("etiquetaPrecioGood: \(arrayPrecio.objectAtIndex(indexPath.row))")
            }else{
                cell.`switch`.on = false
                
                arrayPrecio.replaceObjectAtIndex(indexPath.row, withObject: "$ \(producto.PrecioP)")
                //Persistencia EtiquetaPrecio 💰
                cell.etiquetaPrecio.text = arrayPrecio.objectAtIndex(indexPath.row) as? String
                println("etiquetaPrecioGood: \(arrayPrecio.objectAtIndex(indexPath.row))")
            }
            
            
            //Pasamos el IdP de la celda
            cell.botonFavoritos.tag = producto.IdP
            //Agregar al carrito 🚗
            cell.botonAgregar.tag   = producto.IdP
            
            //Persistencia Favoritos toma DB y refleja ⭐️
            if producto.Favorito == 1{
                arrayFavoritos.replaceObjectAtIndex(indexPath.row, withObject: "ON")
                println("Producto que SI lleva Queso FAVORITO ON")
            }else{
                arrayFavoritos.replaceObjectAtIndex(indexPath.row, withObject: "OFF")
                println("Producto que SI lleva Queso FAVORITO OFF")
            }

        }

        //Persistencia Favoritos
            cell.botonFavoritos.addTarget(self, action: "botonFavoritosAction:", forControlEvents: .TouchUpInside)
        if (arrayFavoritos.objectAtIndex(indexPath.row) as! String) == "ON"{
            cell.botonFavoritos.setImage(UIImage(named: "start.png"), forState: UIControlState.Normal)
            println("\(producto.NombreP) Favoritos Star ON")
        }else{
            if cell.botonFavoritos.tag == -1{
                
                cell.botonFavoritos.setImage(UIImage(named: "tif.png"), forState: UIControlState.Normal)
                println("Favoritos TIF")
            }else{
                cell.botonFavoritos.setImage(UIImage(named: "startWhite.png"), forState: UIControlState.Normal)
                println("\(producto.NombreP) Favoritos Star OFF")
            }
        }
        //Persistencia Switches
            cell.`switch`.addTarget(self, action: "switchAction:", forControlEvents: .ValueChanged)
        if (arraySwitches.objectAtIndex(indexPath.row) as! String) == "ON"{
            cell.`switch`.on = true
            
            //Persistencia EtiquetaPrecio 💰
            cell.etiquetaPrecio.text = arrayPrecio.objectAtIndex(indexPath.row) as? String
            println("etiquetaPrecioGood: \(arrayPrecio.objectAtIndex(indexPath.row))")
        }else{
            cell.`switch`.on = false
            
            //Persistencia EtiquetaPrecio 💰
            cell.etiquetaPrecio.text = arrayPrecio.objectAtIndex(indexPath.row) as? String
            println("etiquetaPrecioGood: \(arrayPrecio.objectAtIndex(indexPath.row))")
        }
        


        
        //Agregar al carrito 🚗
            cell.botonAgregar.addTarget(self, action: "botonAgregarAction:", forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    //Switch target
    func switchAction(sender: UISwitch){
        println("switchAction:")
        var theParentCell = (sender.superview?.superview as! PrincipalTableViewCell)
        var indexPathOfSwitch = myTableView.indexPathForCell(theParentCell)
        
        producto = arrayQuery[indexPathOfSwitch!.row] as! productos
        
        if sender.on {
            arraySwitches.replaceObjectAtIndex(indexPathOfSwitch!.row, withObject: "ON")
            //Modificamos el precio con Queso
            theParentCell.etiquetaPrecio.text = "$ \(producto.PrecioQuesoP)"
            arrayPrecio.replaceObjectAtIndex(indexPathOfSwitch!.row, withObject: "$ \(producto.PrecioQuesoP)")
            println("etiquetaPrecio: \(indexPathOfSwitch?.row): \(arrayPrecio.objectAtIndex(indexPathOfSwitch!.row))")
            
        }else{
            arraySwitches.replaceObjectAtIndex(indexPathOfSwitch!.row, withObject: "OFF")
            //Modificamos el precio sin Queso
            theParentCell.etiquetaPrecio.text = "$ \(producto.PrecioP)"
            arrayPrecio.replaceObjectAtIndex(indexPathOfSwitch!.row, withObject: "$ \(producto.PrecioP)")
            println("etiquetaPrecio: \(indexPathOfSwitch?.row): \(arrayPrecio.objectAtIndex(indexPathOfSwitch!.row))")
            
        }
        
    }

    //Favoritos Target
    func botonFavoritosAction(sender:UIButton!){
        println("Entra al target Favoritos")
        var theParentCell = (sender.superview?.superview as! PrincipalTableViewCell)
        var indexPathOfFavoritos = myTableView.indexPathForCell(theParentCell)

        //Si es tif
        if sender.tag == -1{
            println("Boton es tif")
            let mensaje = "💡La certificación TIF (Tipo de Inspección Federal) es un reconocimiento que la Secretaría de Agricultura, Ganadería y Desarrollo Rural (SAGAR) otorga a las plantas procesadoras de carnes que cumplen con todas las normas y exigencias del Gobierno Mexicano, en cuanto a su tratamiento y manejo de sanidad se refiere. Esta certificación trae consigo una serie de beneficios a la industria cárnica, ya que le permite la movilización dentro del país de una manera más fácil ya que cuenta con la garantía de la calidad sanitaria con la que fue elaborado el producto."
            let alertView = UIAlertView(title: "Calidad TIF", message: mensaje, delegate: nil, cancelButtonTitle: "🍖 Ok 😍")
                alertView.show()
        }else{
            IdP = sender.tag
            //Todos
            if segmentCarta.selectedSegmentIndex == 0{
                /*************************************/
                if  (arrayFavoritos.objectAtIndex(indexPathOfFavoritos!.row) as! String) == "ON"{
                    
                    println("Boton Favorito 🌠Desactivado")
                    ModelManager.instance.updateFavoritoOFF(IdP)
                    sender.setImage(UIImage(named: "startWhite.png"), forState: UIControlState.Normal)
                    //Persistencia
                    arrayFavoritos.replaceObjectAtIndex(indexPathOfFavoritos!.row, withObject: "OFF")
    
                }else{
                    println("Boton Favorito ⭐️Activado")
                    ModelManager.instance.updateFavoritoON(IdP)
                    sender.setImage(UIImage(named: "start.png"), forState: UIControlState.Normal)
                    //Persistencia
                    arrayFavoritos.replaceObjectAtIndex(indexPathOfFavoritos!.row, withObject: "ON")
                }
                arrayQuery = []
                arrayQuery = ModelManager.instance.selectTodo()
                /***************************************/
            }
            //Si esta seleccionado SegmentControlFavoritos⭐️ eliminamos la celda de la tabla
            else if segmentCarta.selectedSegmentIndex == 1{
                println("Boton Favorito 🌠Desactivado")
                ModelManager.instance.updateFavoritoOFF(IdP)
                sender.setImage(UIImage(named: "startWhite.png"), forState: UIControlState.Normal)
                //Persistencia
                arrayFavoritos.replaceObjectAtIndex(indexPathOfFavoritos!.row, withObject: "OFF")
                //Elimina la celda de la tabla
                arrayQuery = []
                arrayQuery = ModelManager.instance.selectFavoritos()
                myTableView.reloadData()
            }
            //Pastor
            else if segmentCarta.selectedSegmentIndex == 2{
                /*************************************/
                if  (arrayFavoritos.objectAtIndex(indexPathOfFavoritos!.row) as! String) == "ON"{
                    
                    println("Boton Favorito 🌠Desactivado")
                    ModelManager.instance.updateFavoritoOFF(IdP)
                    sender.setImage(UIImage(named: "startWhite.png"), forState: UIControlState.Normal)
                    //Persistencia
                    arrayFavoritos.replaceObjectAtIndex(indexPathOfFavoritos!.row, withObject: "OFF")
                    
                }else{
                    println("Boton Favorito ⭐️Activado")
                    ModelManager.instance.updateFavoritoON(IdP)
                    sender.setImage(UIImage(named: "start.png"), forState: UIControlState.Normal)
                    //Persistencia
                    arrayFavoritos.replaceObjectAtIndex(indexPathOfFavoritos!.row, withObject: "ON")
                }
                arrayQuery = []
                arrayQuery = ModelManager.instance.selectPastor()
                /***************************************/
            }
            //Arabe
            else if segmentCarta.selectedSegmentIndex == 3{
                /*************************************/
                if  (arrayFavoritos.objectAtIndex(indexPathOfFavoritos!.row) as! String) == "ON"{
                    
                    println("Boton Favorito 🌠Desactivado")
                    ModelManager.instance.updateFavoritoOFF(IdP)
                    sender.setImage(UIImage(named: "startWhite.png"), forState: UIControlState.Normal)
                    //Persistencia
                    arrayFavoritos.replaceObjectAtIndex(indexPathOfFavoritos!.row, withObject: "OFF")
                    
                }else{
                    println("Boton Favorito ⭐️Activado")
                    ModelManager.instance.updateFavoritoON(IdP)
                    sender.setImage(UIImage(named: "start.png"), forState: UIControlState.Normal)
                    //Persistencia
                    arrayFavoritos.replaceObjectAtIndex(indexPathOfFavoritos!.row, withObject: "ON")
                }
                arrayQuery = []
                arrayQuery = ModelManager.instance.selectArabe()
                /***************************************/
            }
            //Bebidas
            else if segmentCarta.selectedSegmentIndex == 4{
                /*************************************/
                if  (arrayFavoritos.objectAtIndex(indexPathOfFavoritos!.row) as! String) == "ON"{
                    
                    println("Boton Favorito 🌠Desactivado")
                    ModelManager.instance.updateFavoritoOFF(IdP)
                    sender.setImage(UIImage(named: "startWhite.png"), forState: UIControlState.Normal)
                    //Persistencia
                    arrayFavoritos.replaceObjectAtIndex(indexPathOfFavoritos!.row, withObject: "OFF")
                    
                }else{
                    println("Boton Favorito ⭐️Activado")
                    ModelManager.instance.updateFavoritoON(IdP)
                    sender.setImage(UIImage(named: "start.png"), forState: UIControlState.Normal)
                    //Persistencia
                    arrayFavoritos.replaceObjectAtIndex(indexPathOfFavoritos!.row, withObject: "ON")
                }
                arrayQuery = []
                arrayQuery = ModelManager.instance.selectBebidas()
                /***************************************/
            }

        }
        

    }

    //AgregarCarrito Target
    func botonAgregarAction(sender: UIButton!){
        println("Agregar al carrito")
        
        //Obtenemos la celda que hizo clic
        var theParentCell = (sender.superview?.superview as! PrincipalTableViewCell)
        var indexPathOfBotonAgregar = myTableView.indexPathForCell(theParentCell)
        
        producto = arrayQuery[indexPathOfBotonAgregar!.row] as! productos
        
        //Verificamos si la celda tenia el switch queso prendido
        if theParentCell.`switch`.on {
            
            arraySubImageCarrito.addObject("ON")
            producto.QuesoOnP = 1
            ModelManager.instance.updateQuesoOn(producto.IdP)
        }else{
            arraySubImageCarrito.addObject("OFF")
            producto.QuesoOnP = 0
            ModelManager.instance.updateQuesoOFF(producto.IdP)
        }
        

        arrayCarrito.addObject(producto)
        
        myCollectionView.reloadData()
    }
    
    
    //MARK: CollectionView Data Source
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return arrayCarrito.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("PrincipalCollectionViewCell", forIndexPath: indexPath) as! PrincipalCollectionViewCell
        
            producto = arrayCarrito.objectAtIndex(indexPath.row) as! productos
            //producto = arrayCarrito[indexPath.row] as! productos
        
        if (arraySubImageCarrito.objectAtIndex(indexPath.row) as! String) == "ON"{
            
            cell.imagenQueso.image = UIImage(named: "cheese.png")
            cell.imagen.image = UIImage(named: producto.ImagenP)
            
        }else{
            //NOTA: Es forzoso que lleve una imagen sino se pierde la PERSISTENCIA
            cell.imagenQueso.image = UIImage(named: "ima_vacia.png")
            cell.imagen.image = UIImage(named: producto.ImagenP)
        
        }
        
        //Identificamos que producto vamos a borrar
            cell.botonCruz.tag = indexPath.row
            cell.botonCruz.addTarget(self, action: "botonCruzAction:", forControlEvents: .TouchUpInside)
        return cell
        
    }
    
    func botonCruzAction(sender: UIButton){
        println("Elimina producto")
        
        //Sender.tag trae el indice del producto
        index = sender.tag
        
        arrayCarrito.removeObjectAtIndex(index)
        arraySubImageCarrito.removeObjectAtIndex(index)
        
        myCollectionView.reloadData()
    
    }
    
    
    
    
    
    
    
    
    @IBAction func enviarCarrito(sender: UIBarButtonItem) {
        if(arrayCarrito.count == 0){
            let alertView = UIAlertView(title: "Suprema Salsa", message: "Añada algo al carrito 🍴", delegate: nil, cancelButtonTitle: "☑️ Ok")
            alertView.show()
        }else{
            performSegueWithIdentifier("carritoIdentifier", sender: self)
        }

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "carritoIdentifier" {
                /*(segue.destinationViewController as! CarritoViewController).arrayCarrito = arrayCarrito*/
                let nav = (segue.destinationViewController as! UINavigationController)
                let event = (nav.topViewController as! CarritoViewController)
                event.arrayCarrito   = arrayCarrito
        }
    }
    

    //MARK: Others
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
