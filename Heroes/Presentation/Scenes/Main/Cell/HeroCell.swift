//
//  HeroCell.swift
//  Heroes
//
//  Created by Robihamanto on 16/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit
import Kingfisher

class HeroCell: UICollectionViewCell {
    
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func updateView(_ hero: Hero) {
        
        heroNameLabel.text = hero.localizedName ?? ""
        
        let link = "https://api.opendota.com\(hero.image ?? "")"
        let url = URL(string: link)
        heroImageView.kf.setImage(with: url)
    }

}
