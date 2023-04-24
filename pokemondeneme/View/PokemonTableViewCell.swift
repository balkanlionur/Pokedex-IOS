//
//  PokemonTableViewCell.swift
//  pokemondeneme
//
//  Created by Admin on 16.04.2023.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tableImage: UIImageView!
    
    @IBOutlet weak var nameText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
