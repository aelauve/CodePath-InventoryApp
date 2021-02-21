//
//  ShopListItemsTableViewCell.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 2/21/21.
//

import UIKit

class ShopListItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var listItemImage: UIImageView!
    @IBOutlet weak var listItemName: UILabel!
    @IBOutlet weak var listItemAmount: UILabel!
    @IBOutlet weak var checkOffButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
