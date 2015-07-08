//
//  CartaTableViewController.swift
//  Suprema Salsa
//
//  Created by guitarrkurt on 04/07/15.
//  Copyright (c) 2015 guitarrkurt. All rights reserved.
//

import UIKit

class CartaTableViewController: UITableViewController {

    // MARK: - Propertys
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var arrayConsulta            :  NSMutableArray        =  NSMutableArray()
    var promoFromArrayConsulta   :  carta                 =  carta        ()
    
    //var items: [String] = [String]()
    var items: [String] = [String]()

    // MARK: - Constructor
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        //Hacemos la consulta a la DB(SupremaSalsa.sqlite) y lo alojamos en un NSMuatableArray
        arrayConsulta     =  ModelManager.instance.selectFromCarta()

        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return arrayConsulta.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cartaIdentifier", forIndexPath: indexPath) as! CartaTableViewCell
        
        //Casteamos cada item del NSMutableArray que es un objeto de tipo Promos
        promoFromArrayConsulta = arrayConsulta[indexPath.row] as! carta
        


        cell.imageCarta.image = UIImage(named: promoFromArrayConsulta.imageTitle)
        cell.nameCarta.text = promoFromArrayConsulta.nombre
        //cell.precioCarta.text = "$ \(promoFromArrayConsulta.precio)"
        cell.precioCarta.text = "\(promoFromArrayConsulta.precio)"
        
        return cell
    }
    
    @IBAction func enviarCarrito(sender: UIBarButtonItem) {
        let path = NSBundle.mainBundle().pathForResource("pedido", ofType: "plist")
        println("path: \(path)")
        
        let dict = NSDictionary(contentsOfFile: path!)
        println("dict: \(dict)")
        
        var algo = dict!.objectForKey("productos")
        println("algo: \(algo)")
        items = dict!.objectForKey("productos") as! [String]
        
        
        performSegueWithIdentifier("enviarCarritoSegue", sender: self)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "enviarCarritoSegue" {
            
            (segue.destinationViewController as! CarritoViewController).items = items
            
        }
    }
}
