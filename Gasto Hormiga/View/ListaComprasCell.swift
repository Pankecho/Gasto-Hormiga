//
//  ListaComprasCell.swift
//  Gasto Hormiga
//
//  Created by Juan Pablo Martinez Ruiz on 05/11/17.
//  Copyright © 2017 Juan Pablo Martinez Ruiz. All rights reserved.
//

import UIKit

class ListaComprasCell: UITableViewCell {

    @IBOutlet weak var nombreListaLabel: UILabel!
    @IBOutlet weak var lugarCompraLabel: UILabel!
    @IBOutlet weak var totalListaCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
