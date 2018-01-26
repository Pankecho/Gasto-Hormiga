//
//  Establecimiento.swift
//  Gasto Hormiga
//
//  Created by Juan Pablo Martinez Ruiz on 15/11/17.
//  Copyright © 2017 Juan Pablo Martinez Ruiz. All rights reserved.
//

import Foundation

class Establecimiento: NSObject {
    static var establecimientos: [Establecimiento]! = [Establecimiento]()
    var nombre: String!
    var sucursales: [Sucursal]!
    var imagen: String!
    
    init(nombre: String!, imagen: String!) {
        self.nombre = nombre
        self.imagen = imagen
        self.sucursales = [Sucursal]()
    }
}
