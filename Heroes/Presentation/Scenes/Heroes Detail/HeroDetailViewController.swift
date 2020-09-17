//
//  HeroViewController.swift
//  Heroes
//
//  Created by Robihamanto on 16/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit

class HeroDetailViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    var hero: Hero?
    var heroes: [Hero]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
