//
//  ProductoListaCell.swift
//  Gasto Hormiga
//
//  Created by Juan Pablo Martinez Ruiz on 05/11/17.
//  Copyright © 2017 Juan Pablo Martinez Ruiz. All rights reserved.
//

import UIKit

class ProductoListaCell: UITableViewCell {

    @IBOutlet weak var nombreProductoLabel: UILabel!
    @IBOutlet weak var precioProductoLabel: UILabel!
    @IBOutlet weak var cantidadProductoLabel: UILabel!
    
    var producto: Producto!
    var listaIndex: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func cantidadChanged(_ sender: UIStepper) {
        let valor = Int(sender.value)
        Lista.listas[listaIndex].changeValue(p: producto, c: valor)
        cantidadProductoLabel.text = "\(valor)"
    }
}
