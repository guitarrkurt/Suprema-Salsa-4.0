//
//  ModelManager.swift
//  DataBaseDemo
//
//  Created by Krupa-iMac on 05/08/14.
//  Copyright (c) 2014 TheAppGuruz. All rights reserved.
//

import UIKit

let sharedInstance = ModelManager()

class ModelManager: NSObject {
    
    var database: FMDatabase? = nil
    
    class var instance: ModelManager {
        sharedInstance.database = FMDatabase(path: Util.getPath("SupremaSalsa.sqlite"))
        var path = Util.getPath("SupremaSalsa.sqlite")
        println("path : \(path)")
        return sharedInstance
    }

    func selectFromPromos() -> NSMutableArray{
        var array        : NSMutableArray = NSMutableArray()
        
        sharedInstance.database!.open()

        var query = "SELECT * FROM Promos"
        println("\n query: \(query)")

        var resultSet: FMResultSet! = sharedInstance.database!.executeQuery(query, withArgumentsInArray: nil)
        //Vaciamos en un NSMutableArray
        if (resultSet != nil) {
            while resultSet.next() {
                
                var instancia   : Promos = Promos()

                instancia.id             = (resultSet.stringForColumn("id") as NSString).integerValue
                println("            instancia.pid: \(instancia.id)")
                
                instancia.nombreProducto =  resultSet.stringForColumn("nombreProducto")
                println("instancia.pnombreProducto: \(instancia.nombreProducto)")
                
                instancia.precioProducto = (resultSet.stringForColumn("precioProducto") as NSString).floatValue
                println("instancia.pprecioProducto: \(instancia.precioProducto)")
                
                instancia.imageTitle     =  resultSet.stringForColumn("imageTitle")
                println("     instancia.imageTitle: \(instancia.imageTitle)\n")
                
                array.addObject(instancia)
            }
            
        }
        //Cerramos base
        sharedInstance.database!.close()

        return array
    }

    func selectFromCarta() -> NSMutableArray{
        var array        : NSMutableArray = NSMutableArray()
        
        sharedInstance.database!.open()
        
        var query = "SELECT * FROM carta"
        println("\n query: \(query)")
        
        var resultSet: FMResultSet! = sharedInstance.database!.executeQuery(query, withArgumentsInArray: nil)
        //Vaciamos en un NSMutableArray
        if (resultSet != nil) {
            while resultSet.next() {
                
                var instancia   : carta = carta()
                
                instancia.id                = (resultSet.stringForColumn("id") as NSString).integerValue
                println("instancia.id            : \(instancia.id)")
                
                instancia.nombre            = resultSet.stringForColumn("nombre")
                println("instancia.nombre        : \(instancia.nombre)")
                
                instancia.imageTitle        = resultSet.stringForColumn("imageTitle")
                println("instancia.imageTitle    : \(instancia.imageTitle)")
                
                instancia.precio            = (resultSet.stringForColumn("precio") as NSString).floatValue
                println("instancia.precio        : \(instancia.precio)")
                
                instancia.precioConQueso    = (resultSet.stringForColumn("precioConQueso") as NSString).floatValue
                println("instancia.precioConQueso: \(instancia.precioConQueso)")
                
                instancia.esBebida          = (resultSet.stringForColumn("esBebida") as NSString).boolValue
                println("instancia.esBebida      : \(instancia.esBebida)\n")
                
                
                array.addObject(instancia)
            }
            
        }
        //Cerramos base
        sharedInstance.database!.close()
        
        return array
    }
}
