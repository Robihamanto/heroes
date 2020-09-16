//
//  MainViewController.swift
//  Heroes
//
//  Created by Robihamanto on 16/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    private var viewModel: MainViewModel!
    private var role = [String]()
    private var heroes = [Hero]()
    private var heroesIdByrole = [String:[Int]]()
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        
        bindViewModel()
        setupTableView()
    }
    
    func setupTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    private func bindViewModel() {
        let outputs = viewModel.output
        
        outputs.heroes.subscribe(onNext: {[weak self] heroes in
            self?.populateHeroes(heroes)
            }).disposed(by: disposeBag)
    }
    
    func populateHeroes(_ heroes: [Hero]) {
        
        for hero in heroes {
            if let roles = hero.roles {
                for role in roles {
                    
                    if heroesIdByrole[role]?.count ?? 0 > 0 {
                        heroesIdByrole[role]?.append(hero.id ?? 0)
                    } else {
                        heroesIdByrole[role] = [hero.id ?? 0]
                    }
                    
                    if !self.role.contains(role) {
                        self.role.append(role)
                    }
                }
            }
        }
        
        role = role.sorted(by: { $0 < $1 })
        print(role)
        print(heroesIdByrole)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }    

}
