//
//  NewsTableViewController.swift
//  Suprema Salsa
//
//  Created by guitarrkurt on 04/07/15.
//  Copyright (c) 2015 guitarrkurt. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    // MARK: - Propertys
    var recievedData     : NSMutableData?
    var arrayJson        : [AnyObject]    = [AnyObject]()
    var imageStringArray : [String]       = [String]()
    var tituloArray      : [String]       = [String]()
    var bodyArray        : [String]       = [String]()
    var precioArray      : [String]       = [String]()
    
    //From Carrito
    var arrayCuponInfo   : NSMutableArray = NSMutableArray()
    var arrayCarrito     : NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet var myTableView: UITableView!
    var formatoURLImage: NSURL  = NSURL()
    var imageData      : NSData = NSData()
    
    
    // MARK: - Refreshing
    @IBAction func refreshing(sender: UIRefreshControl) {
        //Limpiamos los arrays
        arrayJson  = []
        imageStringArray = []
        tituloArray = []
        bodyArray = []
        precioArray = []

        //dispatch_async(dispatch_get_main_queue(), { () -> Void in
        refresh()
        //self.tableView.reloadData()
        //})
        
        
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    // MARK: - Constructor
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        recievedData = NSMutableData(capacity: 0)
        let url     : NSURL               = NSURL(string: "http://supremasalsa.azurewebsites.net/movil/promo.php")!
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let conn    : NSURLConnection     = NSURLConnection(request: request, delegate: self)!
    }

    // MARK: - Conexion Asincrona
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        
        recievedData?.length = 0
    }
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        
        recievedData?.appendData(data)
    }
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        
        NSLog("Error: \(error.localizedDescription): \(error.userInfo)")
    }
    func connectionDidFinishLoading(connection: NSURLConnection) {
        //¡IGNORAR COMENT! Esto lo hicimos antes con la miss: let str = NSString(data: recievedData!, encoding: NSASCIIStringEncoding)

        getData()
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return imageStringArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("NewsCellIdentifier", forIndexPath: indexPath) as! NewsTableViewCell
        
        cell.etiquetaTitulo.text = tituloArray[indexPath.row]
        cell.etiquetaBody.text   = bodyArray[indexPath.row]
             formatoURLImage     = NSURL(string: imageStringArray[indexPath.row])!
             imageData           = NSData(contentsOfURL: formatoURLImage)!
        println("Celda: \(tituloArray[indexPath.row]) cargando imagen: \(imageStringArray[indexPath.row]))")
        cell.imagen.image        = UIImage(data: imageData)
        
        
        //Target Buton Cupon
        cell.botonDescuento.addTarget(self, action: "botonDescuentoAction:", forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    func getData() {
        var allContacts: AnyObject! = NSJSONSerialization.JSONObjectWithData(recievedData!, options: NSJSONReadingOptions(0), error: nil)
        if let arrayJson = allContacts as? Array<AnyObject> {
            println("El JSON contiene:")
            println(arrayJson)
            for index in 0...arrayJson.count-1 {
                
                let contact : AnyObject? = arrayJson[index]
                println("Contact")
                println(contact)
                
                let collection = contact! as! Dictionary<String, AnyObject>
                println("Collection")
                println(collection)
                
                let body : AnyObject? = collection["descripcion"]
                println("Body \(body)")
                
                let image : AnyObject? = collection["imagen"]
                println("image \(image)")
                
                let precio : AnyObject? = collection["precio"]
                println("precio \(precio)")
                
                let title : AnyObject? = collection["titulo"]
                println("title \(title)")
                
                bodyArray.append(body as! String)
                println("bodyArray: \(bodyArray[index])")
                
                precioArray.append(precio as! String)
                println("precioArray: \(precioArray[index])")
                
                tituloArray.append(title as! String)
                println("titleArray: \(tituloArray[index])")
                
                var url = "http://supremasalsa.azurewebsites.net" + (image as! NSString).substringFromIndex(2)
                println("url: \(url)")
                imageStringArray.append(url)
                println("imageStringArray: \(imageStringArray[index])")
                
            }
            
        }
        println("Cargo los datos provenientes del JSON")
    }
    
    func refresh(){
        println("Refresh()")
        let url=NSURL(string:"http://supremasalsa.azurewebsites.net/movil/promo.php")
        let allContactsData=NSData(contentsOfURL:url!)
        var allContacts: AnyObject! = NSJSONSerialization.JSONObjectWithData(allContactsData!, options: NSJSONReadingOptions(0), error: nil)
        if let arrayJson = allContacts as? Array<AnyObject> {
            println("El JSON contiene:")
            println(arrayJson)
            for index in 0...arrayJson.count-1 {
                
                let contact : AnyObject? = arrayJson[index]
                println("Contact")
                println(contact)
                
                let collection = contact! as! Dictionary<String, AnyObject>
                println("Collection")
                println(collection)
                
                let body : AnyObject? = collection["descripcion"]
                println("Body \(body)")
                
                let image : AnyObject? = collection["imagen"]
                println("image \(image)")
                
                let precio : AnyObject? = collection["precio"]
                println("precio \(precio)")
                
                let title : AnyObject? = collection["titulo"]
                println("title \(title)")
                
                bodyArray.append(body as! String)
                println("bodyArray: \(bodyArray[index])")
                
                precioArray.append(precio as! String)
                println("precioArray: \(precioArray[index])")
                
                tituloArray.append(title as! String)
                println("titleArray: \(tituloArray[index])")
                
                var url = "http://supremasalsa.azurewebsites.net" + (image as! NSString).substringFromIndex(2)
                //era con 16
                println("url: \(url)")
                imageStringArray.append(url)
                println("imageStringArray: \(imageStringArray[index])")
                
            }
            
        }
        println("Refreshing Cargo los datos provenientes del JSON")
    }

    func botonDescuentoAction(sender: UIButton) {
        //Limpiamos porque es Mutable y se va acumulando los datos
        arrayCuponInfo = []
        if arrayCarrito.count != 0 {
            println("entra a botonDescuentoAction.arrayCarrito.count != 0")
            //Obtenemos la celda que hizo clic
            var theParentCell = (sender.superview?.superview as! NewsTableViewCell)
            var indexPathOfBotonDes = myTableView.indexPathForCell(theParentCell)
            //Lenamos el array a enviar
            //Imagen
            arrayCuponInfo.addObject(theParentCell.imagen.image!)
            //Titulo
            println("Titulo: \(tituloArray[indexPathOfBotonDes!.row])")
            arrayCuponInfo.addObject(tituloArray[indexPathOfBotonDes!.row])
            //Precio
            arrayCuponInfo.addObject(precioArray[indexPathOfBotonDes!.row])
            
            performSegueWithIdentifier("BackCarritoIdentifier", sender: self)
        }else{
            //Alerta Selecciona algo del carrito
            let alert = UIAlertView()
            alert.delegate = self
            alert.title = "Selecciona Algo Del Menú "
            alert.message = "Por favor añade algun producto al carrito 🚗"
            alert.addButtonWithTitle("Ok")
            alert.addButtonWithTitle("Ir al Menú")
            alert.show()
        }

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "BackCarritoIdentifier" {
            
            let nav = (segue.destinationViewController as! UINavigationController)
            let event = (nav.topViewController as! CarritoViewController)
                event.arrayCuponInfo = arrayCuponInfo
                event.arrayCarrito   = arrayCarrito
                event.banderaOnceBotonCupon = true
            
            /*(segue.destinationViewController as! CarritoViewController).arrayCuponInfo = arrayCuponInfo
            println("PrepareForSegue.arrayCuponInfo.Title: \(arrayCuponInfo.objectAtIndex(1)as! String)")
            (segue.destinationViewController as! CarritoViewController).arrayCarrito = arrayCarrito*/

        }


    }
    
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        
        switch buttonIndex{
            
            //OK
        case 0:
            println("OK")
            //No hagas nada
            break;
            //Enviar
        case 1:
            println("Ir al carrito")
            performSegueWithIdentifier("cuponesToMenuIdentifier", sender: self)
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
