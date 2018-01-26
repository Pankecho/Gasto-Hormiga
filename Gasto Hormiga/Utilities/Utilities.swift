//
//  Utilities.swift
//  Gasto Hormiga
//
//  Created by Juan Pablo Martinez Ruiz on 20/11/17.
//  Copyright © 2017 Juan Pablo Martinez Ruiz. All rights reserved.
//

import Foundation
import FirebaseDatabase
import SystemConfiguration

class Utilities: NSObject {
    class func isInternetAvailable() -> Bool{
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    class func getTipoDeLugar(lugar: String!) -> String!{
        var cadena: String! = ""
        switch lugar {
        case "mercado":
            cadena = "Mercado"
            break
        case "mercado_ambulante":
            cadena = "Mercado Ambulante"
            break
        case "tianguis":
            cadena = "Tianguis"
            break
        case "tienda_autoservicio":
            cadena = "Tienda de Autoservicio"
            break
        default:
            cadena = "No reconocido"
            break
        }
        return cadena
    }
    
    class func getCategorias(){
        let database: DatabaseReference! = Database.database().reference()
        database.child("categoria").observe(.value) { (snap) in
            let array = snap.value as! [Dictionary<String,AnyObject>]
            for i in array {
                let c = Categoria(nombre: i["nombre"] as! String,img: i["imagen"] as! String)
                let productos = i["productos"] as! [Dictionary<String, AnyObject>]
                for j in productos {
                    let precios = j["precio"] as! Dictionary<String, AnyObject>
                    let producto = Producto(nombre: j["nombre"] as! String, m: precios["mercado"] as! Double, ma: precios["mercado_ambulante"] as! Double, t: precios["tianguis"] as! Double, au: precios["tienda_autoservicio"] as! Double)
                    c.productos.append(producto)
                }
                Categoria.categorias.append(c)
            }
        }
    }
    
    class func getEstablecimientos(){
        let database: DatabaseReference! = Database.database().reference()
        database.child("establecimiento").observe(.value) { (snap) in
            let array = snap.value as! [Dictionary<String,AnyObject>]
            for i in array {
                let e = Establecimiento(nombre: i["nombre"] as! String, imagen: i["imagen"] as! String)
                let s = i["sucursal"] as! [Dictionary<String, AnyObject>]
                for j in s {
                    let sucursal = Sucursal(nombre: j["nombre"] as! String, latitud: j["longitud"] as! Double, longitud: j["latitud"] as! Double)
                    e.sucursales.append(sucursal)
                }
                Establecimiento.establecimientos.append(e)
            }
        }
    }
}
