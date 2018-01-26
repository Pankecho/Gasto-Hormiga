//
//  Producto.swift
//  Gasto Hormiga
//
//  Created by Juan Pablo Martinez Ruiz on 26/10/17.
//  Copyright © 2017 Juan Pablo Martinez Ruiz. All rights reserved.
//

import Foundation

class Producto: NSObject {
    var nombre: String!
    var precio: Dictionary<String,Double>!
    
    init(nombre: String, m: Double, ma: Double, t: Double, au: Double){
        self.nombre = nombre
        self.precio = ["mercado":m,"mercado_ambulante": ma, "tianguis": t, "tienda_autoservicio": au]
    }
}
