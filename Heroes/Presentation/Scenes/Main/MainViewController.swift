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
    private var roles = [String]()
    private var heroes = [Hero]()
    private var heroesByrole = [String:[Hero]]()
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        
        setupTableView()
        bindViewModel()
    }
    
    func setupTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    private func bindViewModel() {
        let outputs = viewModel.output
        
        outputs.heroes.subscribe(onNext: {[weak self] heroes in
            self?.populateHeroes(heroes)
            self?.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    func populateHeroes(_ heroes: [Hero]) {
        
        for hero in heroes {
            if let roles = hero.roles {
                for role in roles {
                    
                    if heroesByrole[role]?.count ?? 0 > 0 {
                        heroesByrole[role]?.append(hero)
                    } else {
                        heroesByrole[role] = [hero]
                    }
                    
                    if !self.roles.contains(role) {
                        self.roles.append(role)
                    }
                }
            }
        }
        
        roles = role.sorted(by: { $0 < $1 })
//        print(role)
//        print(heroesByrole)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "roleCell") else { return UITableViewCell() }
        cell.textLabel?.text = roles[indexPath.row]
        
        return cell
    }    

}
