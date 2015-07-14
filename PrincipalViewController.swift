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
    
    var arrayConsultaPromos      :  NSMutableArray        =  NSMutableArray()
    var arrayConsultaCarta       :  NSMutableArray        =  NSMutableArray()
    
    var promoFromArrayConsulta   :  Promos                =  Promos        ()
    var cartaFromArrayConsulta   :  carta                 =  carta        ()
    
    //Auxiliar segment
    var banderaPrimeraVez: Bool = true
    
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
        //Hacemos la consulta a la DB(SupremaSalsa.sqlite) y lo alojamos en un NSMuatableArray
        arrayConsultaPromos     =  ModelManager.instance.selectFromPromos()
        arrayConsultaCarta      =  ModelManager.instance.selectFromCarta()
        
    }


    
    //MARK: Actions
    @IBAction func segmentPrincipalAction(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        //Paquetes
        case 0:
            self.segmentCarta.hidden = true
            println("1segmentPrincipalAction case 0, sender.selectedSegmentIndex: \(sender.selectedSegmentIndex)")
            break;
        //Carta
        case 1:
            self.segmentCarta.hidden = false
            println("1egmentPrincipalAction case 1, sender.selectedSegmentIndex: \(sender.selectedSegmentIndex)")
            break;
        default:
            break;
        }
        self.myTableView.reloadData()
        println("1self.myTableView.reloadData()")
    }
    
    @IBAction func segmentCartaAction(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        //Todo
        case 0:
            println("2segmentPrincipalAction case 0, sender.selectedSegmentIndex: \(sender.selectedSegmentIndex)")
            break;
        //⭐️
        case 1:
            println("2segmentPrincipalAction case 1, sender.selectedSegmentIndex: \(sender.selectedSegmentIndex)")
            break;
        //Pastor
        case 2:
            println("2segmentPrincipalAction case 2, sender.selectedSegmentIndex: \(sender.selectedSegmentIndex)")
            break;
        //Arabe
        case 3:
            println("2segmentPrincipalAction case 3, sender.selectedSegmentIndex: \(sender.selectedSegmentIndex)")
            break;
        //Bebida
        case 4:
            println("2segmentPrincipalAction case 4, sender.selectedSegmentIndex: \(sender.selectedSegmentIndex)")
            break;
        default:
            break;
        }
        self.myTableView.reloadData()
        println("2self.myTableView.reloadData()")
    }
    
    //MARK: TableView Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        println("entra numberOfRowsInSection")
        var numberOfRows: Int = Int()
        
        println("numberOfRowsInSection, segmentPrincipal.selectedSegmentIndex vale: \(segmentPrincipal.selectedSegmentIndex) ")
        switch segmentPrincipal.selectedSegmentIndex
        {

        //Paquetes
        case 0:
            self.segmentCarta.hidden = true
            numberOfRows = arrayConsultaPromos.count
        //Carta
        case 1:
            
            self.segmentCarta.hidden = false
            if(banderaPrimeraVez){
                
                //self.banderaPrimeraVez = false
                numberOfRows = arrayConsultaCarta.count
                
            }else{
                switch segmentCarta.selectedSegmentIndex
                {
                //Todo
                case 0:
                    numberOfRows = arrayConsultaCarta.count
                //⭐️
                case 1:
                    
                    break;
                //Pastor
                case 2:
                    
                    break;
                //Arabe
                case 3:
                    
                    break;
                //Bebida
                case 4:
                    
                    break;
                default:
                    break;
                }
            
            }
            
            break;
        default:
            break;
        }

        return numberOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        /*let cell = tableView.dequeueReusableCellWithIdentifier("PrincipalTableViewCell", forIndexPath: indexPath) as! PrincipalTableViewCell
        
        //Casteamos cada item del NSMutableArray que es un objeto de tipo Promos
        promoFromArrayConsulta = arrayConsultaPromos[indexPath.row] as! Promos
        
        cell.imagen.image           = UIImage(named: promoFromArrayConsulta.imageTitle)
        cell.etiquetaTitulo.text    = promoFromArrayConsulta.nombreProducto
        cell.etiquetaPrecio.text    = "$ \(promoFromArrayConsulta.precioProducto)"
        
        return cell*/
            let cell = tableView.dequeueReusableCellWithIdentifier("PrincipalTableViewCell", forIndexPath: indexPath) as! PrincipalTableViewCell
        
        switch segmentPrincipal.selectedSegmentIndex
        {
        //Paquetes
        case 0:
            self.segmentCarta.hidden = true
            
            promoFromArrayConsulta = arrayConsultaPromos[indexPath.row] as! Promos
            
            cell.imagen.image           = UIImage(named: promoFromArrayConsulta.imageTitle)
            cell.etiquetaTitulo.text    = promoFromArrayConsulta.nombreProducto
            cell.etiquetaPrecio.text    = "$ \(promoFromArrayConsulta.precioProducto)"
            
            //Carta
        case 1:
            self.segmentCarta.hidden = false
            if(banderaPrimeraVez){
                self.banderaPrimeraVez = false

                
                cartaFromArrayConsulta = arrayConsultaCarta[indexPath.row] as! carta
                
                cell.imagen.image           = UIImage(named: cartaFromArrayConsulta.imageTitle)
                cell.etiquetaTitulo.text    = cartaFromArrayConsulta.nombre
                cell.etiquetaPrecio.text    = "$ \(cartaFromArrayConsulta.precio)"
                
            }else{
                switch segmentCarta.selectedSegmentIndex
                {
                    //Todo
                case 0:
                    break;
                    //⭐️
                case 1:
                    
                    break;
                    //Pastor
                case 2:
                    
                    break;
                    //Arabe
                case 3:
                    
                    break;
                    //Bebida
                case 4:
                    
                    break;
                default:
                    break;
                }
                
            }
            
            break;
        default:
            break;
        }
        
        
        return cell
    }
    //MARK - CollectionView Data Source
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return arrayConsultaPromos.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("PrincipalCollectionViewCell", forIndexPath: indexPath) as! PrincipalCollectionViewCell
        
        promoFromArrayConsulta = arrayConsultaPromos[indexPath.row] as! Promos
    
        
        cell.imagen.image = UIImage(named: promoFromArrayConsulta.imageTitle)
        
        return cell
        
    }

    //MARK: Others
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
