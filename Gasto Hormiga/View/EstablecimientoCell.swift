//
//  EstablecimientoCell.swift
//  Gasto Hormiga
//
//  Created by Juan Pablo Martinez Ruiz on 20/11/17.
//  Copyright © 2017 Juan Pablo Martinez Ruiz. All rights reserved.
//

import UIKit

class EstablecimientoCell: UITableViewCell {
    @IBOutlet weak var establecimientoImage: UIImageView!
    @IBOutlet weak var nombreEstablecimientoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
