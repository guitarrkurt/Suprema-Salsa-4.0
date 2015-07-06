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
    
    var imageTitle  : [String]  = [String]()
    var bodyArray   : [String]  = [String]()
    var precioArray : [Float]   = [Float]()
    
    // MARK: - Constructor
    override func viewDidLoad() {
        //Slide out menu
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        //Load Image from Promos.plist
        let path = NSBundle.mainBundle().pathForResource("Promos", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)

        bodyArray = dict!.objectForKey("ProductDescription") as! [String]
        precioArray = dict!.objectForKey("Price") as! [Float]
        imageTitle = dict!.objectForKey("ImageTitle") as! [String]
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
        return bodyArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! PromosTableViewCell

        cell.imageCell.image = UIImage(named: imageTitle[indexPath.row])
        cell.labelBodyCell.text  = bodyArray[indexPath.row]
        cell.labelPrecioCell.text = "$\(precioArray[indexPath.row])"

        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        println("Selecciono: \(bodyArray[indexPath.row])")
        
            performSegueWithIdentifier("showDescription", sender: self)

    }

}
