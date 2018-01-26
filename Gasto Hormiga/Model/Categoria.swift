//
//  Categoria.swift
//  Gasto Hormiga
//
//  Created by Juan Pablo Martinez Ruiz on 05/11/17.
//  Copyright © 2017 Juan Pablo Martinez Ruiz. All rights reserved.
//

import Foundation

class Categoria: NSObject {
    static var categorias: [Categoria]! = [Categoria]()
    var nombre: String!
    var productos: [Producto]!
    var imagen: String!
    
    init(nombre: String,img: String!) {
        self.nombre = nombre
        self.imagen = img
        self.productos = [Producto]()
    }
}
