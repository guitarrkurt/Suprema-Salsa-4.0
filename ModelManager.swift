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
        sharedInstance.database = FMDatabase(path: Util.getPath("SupremaSalsa5.sqlite"))
        var path = Util.getPath("SupremaSalsa5.sqlite")
        println("path DB: \(path)")
        return sharedInstance
    }

    func selectTodo() -> NSMutableArray{
        var array: NSMutableArray = NSMutableArray()
        
        sharedInstance.database!.open()
        var query = "SELECT * FROM productos WHERE Promo=0"
        println("\n query: \(query)")

        var resultSet: FMResultSet! = sharedInstance.database!.executeQuery(query, withArgumentsInArray: nil)
        
        if (resultSet != nil) {
            while resultSet.next() {
                var instancia   : productos = productos()
                
                instancia.IdP          = (resultSet.stringForColumn("IdP") as NSString).integerValue
                println("Idp: \(instancia.IdP)")
                
                instancia.NombreP      = resultSet.stringForColumn("NombreP")//Asi solita regresa un String
                println("NombreP: \(instancia.NombreP)")
                
                instancia.DescripcionP = resultSet.stringForColumn("DescripcionP")
                println("DescripcionP: \(instancia.DescripcionP)")
                
                instancia.PrecioP      = (resultSet.stringForColumn("PrecioP") as NSString).floatValue
                println("PrecioP: \(instancia.PrecioP)")
                
                instancia.PrecioQuesoP = (resultSet.stringForColumn("PrecioQuesoP") as NSString).floatValue
                println("PrecioQuesoP: \(instancia.PrecioQuesoP)")
                
                instancia.Queso        = (resultSet.stringForColumn("Queso") as NSString).integerValue
                println("Queso: \(instancia.Queso)")
                
                instancia.Favorito     = (resultSet.stringForColumn("Favorito") as NSString).integerValue
                println("Favorito: \(instancia.Favorito)")
                
                instancia.Arabe        = (resultSet.stringForColumn("Arabe") as NSString).integerValue
                println("Arabe: \(instancia.Arabe)")
                
                instancia.Pastor       = (resultSet.stringForColumn("Pastor") as NSString).integerValue
                println("Pastor: \(instancia.Pastor)")
                
                instancia.Bebida       = (resultSet.stringForColumn("Bebida") as NSString).integerValue
                println("Bebida: \(instancia.Bebida)")
                
                instancia.Promo        = (resultSet.stringForColumn("Promo") as NSString).integerValue
                println("Promo: \(instancia.Promo)")
                
                instancia.ImagenP      = resultSet.stringForColumn("ImagenP")
                println("ImagenP: \(instancia.ImagenP)")
                
                instancia.QuesoOnP      = (resultSet.stringForColumn("QuesoOnP") as NSString).integerValue
                println("QuesoOnP: \(instancia.QuesoOnP)")
                
                array.addObject(instancia)
            }
            
        }else{
            println("Error al hacer la consulta")
        }
        sharedInstance.database!.close()
        return array
    }

    func selectPaquetes() -> NSMutableArray{
        var array: NSMutableArray = NSMutableArray()
        
        sharedInstance.database!.open()
        var query = "SELECT * FROM productos WHERE Promo=1"
        println("\n query: \(query)")
        
        var resultSet: FMResultSet! = sharedInstance.database!.executeQuery(query, withArgumentsInArray: nil)
        
        if (resultSet != nil) {
            while resultSet.next() {
                var instancia   : productos = productos()
                
                instancia.IdP          = (resultSet.stringForColumn("IdP") as NSString).integerValue
                println("Idp: \(instancia.IdP)")
                
                instancia.NombreP      = resultSet.stringForColumn("NombreP")//Asi solita regresa un String
                println("NombreP: \(instancia.NombreP)")
                
                instancia.DescripcionP = resultSet.stringForColumn("DescripcionP")
                println("DescripcionP: \(instancia.DescripcionP)")
                
                instancia.Queso        = (resultSet.stringForColumn("Queso") as NSString).integerValue
                println("Queso: \(instancia.Queso)")
                
                instancia.PrecioP      = (resultSet.stringForColumn("PrecioP") as NSString).floatValue
                println("PrecioP: \(instancia.PrecioP)")
                
                instancia.Favorito     = (resultSet.stringForColumn("Favorito") as NSString).integerValue
                println("Favorito: \(instancia.Favorito)")
                
                instancia.Promo        = (resultSet.stringForColumn("Promo") as NSString).integerValue
                println("Promo: \(instancia.Promo)")
                
                instancia.ImagenP      = resultSet.stringForColumn("ImagenP")
                println("ImagenP: \(instancia.ImagenP)")
                
                array.addObject(instancia)
            }
            
        }else{
            println("Error al hacer la consulta")
        }
        sharedInstance.database!.close()
        return array
    }

    func selectPastor() -> NSMutableArray{
        var array: NSMutableArray = NSMutableArray()
        
        sharedInstance.database!.open()
        var query = "SELECT * FROM productos WHERE Pastor=1 and Promo=0"
        println("\n query: \(query)")
        
        var resultSet: FMResultSet! = sharedInstance.database!.executeQuery(query, withArgumentsInArray: nil)
        
        if (resultSet != nil) {
            while resultSet.next() {
                var instancia   : productos = productos()
                
                instancia.IdP          = (resultSet.stringForColumn("IdP") as NSString).integerValue
                println("Idp: \(instancia.IdP)")
                
                instancia.NombreP      = resultSet.stringForColumn("NombreP")//Asi solita regresa un String
                println("NombreP: \(instancia.NombreP)")
                
                instancia.DescripcionP = resultSet.stringForColumn("DescripcionP")
                println("DescripcionP: \(instancia.DescripcionP)")
                
                instancia.PrecioP      = (resultSet.stringForColumn("PrecioP") as NSString).floatValue
                println("PrecioP: \(instancia.PrecioP)")
                
                instancia.PrecioQuesoP = (resultSet.stringForColumn("PrecioQuesoP") as NSString).floatValue
                println("PrecioQuesoP: \(instancia.PrecioQuesoP)")
                
                instancia.Queso        = (resultSet.stringForColumn("Queso") as NSString).integerValue
                println("Queso: \(instancia.Queso)")
                
                instancia.Favorito     = (resultSet.stringForColumn("Favorito") as NSString).integerValue
                println("Favorito: \(instancia.Favorito)")
                
                instancia.Pastor       = (resultSet.stringForColumn("Pastor") as NSString).integerValue
                println("Pastor: \(instancia.Pastor)")
                
                instancia.ImagenP      = resultSet.stringForColumn("ImagenP")
                println("ImagenP: \(instancia.ImagenP)")
                
                instancia.QuesoOnP      = (resultSet.stringForColumn("QuesoOnP") as NSString).integerValue
                println("QuesoOnP: \(instancia.QuesoOnP)")
                
                array.addObject(instancia)
            }
            
        }else{
            println("Error al hacer la consulta")
        }
        sharedInstance.database!.close()
        return array
    }
    
    func selectArabe() -> NSMutableArray{
        var array: NSMutableArray = NSMutableArray()
        
        sharedInstance.database!.open()
        var query = "SELECT * FROM productos WHERE Arabe=1 and Promo=0"
        println("\n query: \(query)")
        
        var resultSet: FMResultSet! = sharedInstance.database!.executeQuery(query, withArgumentsInArray: nil)
        
        if (resultSet != nil) {
            while resultSet.next() {
                var instancia   : productos = productos()
                
                instancia.IdP          = (resultSet.stringForColumn("IdP") as NSString).integerValue
                println("Idp: \(instancia.IdP)")
                
                instancia.NombreP      = resultSet.stringForColumn("NombreP")//Asi solita regresa un String
                println("NombreP: \(instancia.NombreP)")
                
                instancia.DescripcionP = resultSet.stringForColumn("DescripcionP")
                println("DescripcionP: \(instancia.DescripcionP)")
                
                instancia.PrecioP      = (resultSet.stringForColumn("PrecioP") as NSString).floatValue
                println("PrecioP: \(instancia.PrecioP)")
                
                instancia.PrecioQuesoP = (resultSet.stringForColumn("PrecioQuesoP") as NSString).floatValue
                println("PrecioQuesoP: \(instancia.PrecioQuesoP)")
                
                instancia.Queso        = (resultSet.stringForColumn("Queso") as NSString).integerValue
                println("Queso: \(instancia.Queso)")
                
                instancia.Favorito     = (resultSet.stringForColumn("Favorito") as NSString).integerValue
                println("Favorito: \(instancia.Favorito)")
                
                instancia.Arabe        = (resultSet.stringForColumn("Arabe") as NSString).integerValue
                println("Arabe: \(instancia.Arabe)")
                
                instancia.ImagenP      = resultSet.stringForColumn("ImagenP")
                println("ImagenP: \(instancia.ImagenP)")
                
                instancia.QuesoOnP      = (resultSet.stringForColumn("QuesoOnP") as NSString).integerValue
                println("QuesoOnP: \(instancia.QuesoOnP)")
                
                array.addObject(instancia)
            }
            
        }else{
            println("Error al hacer la consulta")
        }
        sharedInstance.database!.close()
        return array
    }
    
    func selectBebidas() -> NSMutableArray{
        var array: NSMutableArray = NSMutableArray()
        
        sharedInstance.database!.open()
        var query = "SELECT * FROM productos WHERE Bebida=1 and Promo=0"
        println("\n query: \(query)")
        
        var resultSet: FMResultSet! = sharedInstance.database!.executeQuery(query, withArgumentsInArray: nil)
        
        if (resultSet != nil) {
            while resultSet.next() {
                var instancia   : productos = productos()
                
                instancia.IdP          = (resultSet.stringForColumn("IdP") as NSString).integerValue
                println("Idp: \(instancia.IdP)")
                
                instancia.NombreP      = resultSet.stringForColumn("NombreP")//Asi solita regresa un String
                println("NombreP: \(instancia.NombreP)")
                
                instancia.DescripcionP = resultSet.stringForColumn("DescripcionP")
                println("DescripcionP: \(instancia.DescripcionP)")
                
                instancia.PrecioP      = (resultSet.stringForColumn("PrecioP") as NSString).floatValue
                println("PrecioP: \(instancia.PrecioP)")
                
                instancia.Queso        = (resultSet.stringForColumn("Queso") as NSString).integerValue
                println("Queso: \(instancia.Queso)")
                
                instancia.Favorito     = (resultSet.stringForColumn("Favorito") as NSString).integerValue
                println("Favorito: \(instancia.Favorito)")
                
                instancia.Bebida       = (resultSet.stringForColumn("Bebida") as NSString).integerValue
                println("Bebida: \(instancia.Bebida)")
                
                instancia.ImagenP      = resultSet.stringForColumn("ImagenP")
                println("ImagenP: \(instancia.ImagenP)")
                
                array.addObject(instancia)
            }
            
        }else{
            println("Error al hacer la consulta")
        }
        sharedInstance.database!.close()
        return array
    }
    
    func selectFavoritos() -> NSMutableArray{
        var array: NSMutableArray = NSMutableArray()
        
        sharedInstance.database!.open()
        var query = "SELECT * FROM productos WHERE Favorito=1"
        println("\n query: \(query)")
        
        var resultSet: FMResultSet! = sharedInstance.database!.executeQuery(query, withArgumentsInArray: nil)
        
        if (resultSet != nil) {
            while resultSet.next() {
                var instancia   : productos = productos()
                
                instancia.IdP          = (resultSet.stringForColumn("IdP") as NSString).integerValue
                println("Idp: \(instancia.IdP)")
                
                instancia.NombreP      = resultSet.stringForColumn("NombreP")//Asi solita regresa un String
                println("NombreP: \(instancia.NombreP)")
                
                instancia.DescripcionP = resultSet.stringForColumn("DescripcionP")
                println("DescripcionP: \(instancia.DescripcionP)")
                
                instancia.PrecioP      = (resultSet.stringForColumn("PrecioP") as NSString).floatValue
                println("PrecioP: \(instancia.PrecioP)")
                
                instancia.PrecioQuesoP = (resultSet.stringForColumn("PrecioQuesoP") as NSString).floatValue
                println("PrecioQuesoP: \(instancia.PrecioQuesoP)")
                
                instancia.Queso        = (resultSet.stringForColumn("Queso") as NSString).integerValue
                println("Queso: \(instancia.Queso)")
                
                instancia.Favorito     = (resultSet.stringForColumn("Favorito") as NSString).integerValue
                println("Favorito: \(instancia.Favorito)")
                
                instancia.Arabe        = (resultSet.stringForColumn("Arabe") as NSString).integerValue
                println("Arabe: \(instancia.Arabe)")
                
                instancia.Pastor       = (resultSet.stringForColumn("Pastor") as NSString).integerValue
                println("Pastor: \(instancia.Pastor)")
                
                instancia.Bebida       = (resultSet.stringForColumn("Bebida") as NSString).integerValue
                println("Bebida: \(instancia.Bebida)")
                
                instancia.Promo        = (resultSet.stringForColumn("Promo") as NSString).integerValue
                println("Promo: \(instancia.Promo)")
                
                instancia.ImagenP      = resultSet.stringForColumn("ImagenP")
                println("ImagenP: \(instancia.ImagenP)")
                
                instancia.QuesoOnP      = (resultSet.stringForColumn("QuesoOnP") as NSString).integerValue
                println("QuesoOnP: \(instancia.QuesoOnP)")
                
                array.addObject(instancia)
            }
            
        }else{
            println("Error al hacer la consulta")
        }
        sharedInstance.database!.close()
        return array
    }

    func updateFavoritoON(IdP: Int){
        var query = "UPDATE productos SET Favorito=1 WHERE IdP=\(IdP)"
        println("\nquery: \(query)")
        
        sharedInstance.database!.open()

        //var a = "1"
        //var b = "\(IdP)"
        //sharedInstance.database!.executeQuery("UPDATE productos SET Favorito=? WHERE IdP=?", withArgumentsInArray: [a, b])
        
        sharedInstance.database!.executeUpdate(query, withArgumentsInArray:nil)
        
        sharedInstance.database!.close()
 
    }
    
    func updateFavoritoOFF(IdP: Int){
        var query = "UPDATE productos SET Favorito=0 WHERE IdP=\(IdP)"
        println("\nquery: \(query)")
        
        sharedInstance.database!.open()
        
        sharedInstance.database!.executeUpdate(query, withArgumentsInArray:nil)
        
        sharedInstance.database!.close()
    }
    
    func updateQuesoOn(IdP: Int){
        var query = "UPDATE productos SET QuesoOn=1 WHERE IdP=\(IdP)"
        println("\nquery: \(query)")
        
        sharedInstance.database!.open()
        
        sharedInstance.database!.executeUpdate(query, withArgumentsInArray:nil)
        
        sharedInstance.database!.close()
    }
    
    func updateQuesoOFF(IdP: Int){
        var query = "UPDATE productos SET QuesoOn=0 WHERE IdP=\(IdP)"
        println("\nquery: \(query)")
        
        sharedInstance.database!.open()
        
        sharedInstance.database!.executeUpdate(query, withArgumentsInArray:nil)
        
        sharedInstance.database!.close()
    }
    
}
