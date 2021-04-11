//
//  InventorySelectorTableViewCell.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 3/16/21.
//

import UIKit

class InventorySelectorTableViewCell: UITableViewCell {

    @IBOutlet weak var inventorySelectButton: UIButton!
    @IBOutlet weak var inventoryLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
