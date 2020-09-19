//
//  HeroViewController.swift
//  Heroes
//
//  Created by Robihamanto on 16/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HeroDetailViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rolesLabel: UILabel!
    
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var armorLabel: UILabel!
    @IBOutlet weak var manaLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var attributeLabel: UILabel!
    
    @IBOutlet weak var similarHeroOneImageView: UIImageView!
    @IBOutlet weak var similarHeroTwoImageView: UIImageView!
    @IBOutlet weak var similarHeroThreeImageView: UIImageView!
    
    
    weak var coordinator: MainCoordinator?
    var hero: Hero?
    var heroes: [Hero]?
    
    private var viewModel: HeroDetailViewModel!
    private let disposeBag = DisposeBag()
    
    func create(viewModel: HeroDetailViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        let outputs = viewModel.output
        
        title = outputs.hero.localizedName
        
        heroImageView.kf.setImage(with: URL(string: outputs.hero.link))
        rolesLabel.text = hero?.roles?.joined(separator: ", ")
        
        attackLabel.text = "\(outputs.hero.baseAttackMin ?? 0) - \(outputs.hero.baseAttackMax ?? 0)"
        healthLabel.text = "\(outputs.hero.baseHealth ?? 0)"
        armorLabel.text = "\(outputs.hero.baseArmor ?? 0)"
        manaLabel.text = "\(outputs.hero.baseMana ?? 0)"
        speedLabel.text = "\(outputs.hero.moveSpeed ?? 0)"
        attributeLabel.text = "\(outputs.hero.primaryAttribute ?? "")"

        let similarHeroes = outputs.similarHeroes
        similarHeroOneImageView.kf.setImage(with: URL(string: similarHeroes[0].link))
        similarHeroTwoImageView.kf.setImage(with: URL(string: similarHeroes[1].link))
        similarHeroThreeImageView.kf.setImage(with: URL(string: similarHeroes[2].link))
        
    }
    
}
