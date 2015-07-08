//
//  CarritoViewController.swift
//  Suprema Salsa
//
//  Created by guitarrkurt on 08/07/15.
//  Copyright (c) 2015 guitarrkurt. All rights reserved.
//

import UIKit

class CarritoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableVIew: UITableView!
    

    
    var items: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableVIew.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let path = NSBundle.mainBundle().pathForResource("pedido", ofType: "plist")
        println("path: \(path)")
        
        let dict = NSMutableDictionary(contentsOfFile: path!)
        println("dict: \(dict)")
        
        var algo2 = dict?.objectForKey("pedidos") as! String
        items.append(algo2)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = self.tableVIew.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        
        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        var alert = UIAlertView()
        alert.title = "Selecciono"
        alert.message = self.items[indexPath.row]
        alert.addButtonWithTitle("OK")
        alert.show()
        
        
    }
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
}
