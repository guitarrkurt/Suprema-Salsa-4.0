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
    let arrayPicker = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

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
        cell.precioCarta.text = "$ \(promoFromArrayConsulta.precio)"


        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
