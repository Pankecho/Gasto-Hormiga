//
//  Sucursal.swift
//  Gasto Hormiga
//
//  Created by Juan Pablo Martinez Ruiz on 15/11/17.
//  Copyright © 2017 Juan Pablo Martinez Ruiz. All rights reserved.
//

import Foundation

class Sucursal: NSObject {
    var nombre: String!
    var latitud: Double!
    var longitud: Double!
    
    init(nombre: String!, latitud: Double!, longitud: Double!) {
        self.nombre = nombre
        self.latitud = latitud
        self.longitud = longitud
    }
}
