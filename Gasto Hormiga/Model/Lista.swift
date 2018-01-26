//
//  Lista.swift
//  Gasto Hormiga
//
//  Created by Juan Pablo Martinez Ruiz on 05/11/17.
//  Copyright © 2017 Juan Pablo Martinez Ruiz. All rights reserved.
//

import Foundation
import UIKit

class Lista: NSObject {
    
    static var listas: [Lista] = [Lista]()
    
    var nombre: String!
    var lugarCompra: String!
    var productos: Dictionary<Producto,Int>!
    var total: Double
    var observer: ListaActualVC!
    
    init(nombre: String!, lugar: String!){
        self.nombre = nombre
        self.lugarCompra = lugar
        self.productos = [Producto:Int]()
        self.total = 0.00
    }
    
    func setObserver(view: ListaActualVC){
        self.observer = view
    }
    
    func getTotal(){
        self.total = 0.00
        for i in productos{
            self.total += (i.key.precio[lugarCompra]! * Double(i.value))
        }
    }
    
    func add(p: Producto, c: Int){
        if let pr = productos[p] {
            productos.updateValue(pr + c, forKey: p)
        }else{
            productos[p] = c
        }
        getTotal()
        observer.update()
        observer.tableView.reloadData()
    }
    
    func removeElement(p: Producto){
        if let _ = productos[p] {
            productos.remove(at: productos.index(forKey: p)!)
            getTotal()
            observer.update()
        }
    }
    
    func changeValue(p: Producto, c: Int){
        if let _ = productos[p] {
            productos.updateValue(c, forKey: p)
        }else{
            productos[p] = c
        }
        getTotal()
        observer.update()
    }
    
}
