//
//  PromosTableViewController.swift
//  Suprema Salsa
//
//  Created by guitarrkurt on 04/07/15.
//  Copyright (c) 2015 guitarrkurt. All rights reserved.
//

import UIKit

class PromosTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Propertys
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var arrayConsulta            :  NSMutableArray        =  NSMutableArray()
    var promoFromArrayConsulta   :  Promos                 =  Promos        ()
    
    // MARK: - Constructor
    override func viewDidLoad() {
        //Slide out menu
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        //Hacemos la consulta a la DB(SupremaSalsa.sqlite) y lo alojamos en un NSMuatableArray
        arrayConsulta     =  ModelManager.instance.selectFromPromos()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return arrayConsulta.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("promosIdentifier", forIndexPath: indexPath) as! PromosTableViewCell
        
        //Casteamos cada item del NSMutableArray que es un objeto de tipo Promos
        promoFromArrayConsulta = arrayConsulta[indexPath.row] as! Promos
        
        cell.imageCell.image      = UIImage(named: promoFromArrayConsulta.imageTitle)
        cell.labelBodyCell.text   = promoFromArrayConsulta.nombreProducto
        cell.labelPrecioCell.text = "$ \(promoFromArrayConsulta.precioProducto)"

        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
            performSegueWithIdentifier("showDescription", sender: self)

    }

}
