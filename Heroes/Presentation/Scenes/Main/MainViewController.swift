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

class MainViewController: UIViewController, Storyboarded, Alertable {
    
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
        setupCollectionView()
        bindViewModel()
    }
    
    func setupTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    func setupCollectionView() {
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        let nib = UINib(nibName: "HeroCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "heroCell")
    }
    
    private func bindViewModel() {
        let outputs = viewModel.output
        
        outputs.heroes.subscribe(onNext: {[weak self] heroes in
            self?.heroes = heroes
            self?.tableView.reloadData()
            self?.collectionView.reloadData()
            }).disposed(by: disposeBag)
        
        outputs.heroesByRole.subscribe(onNext: { [weak self] heroesByRole in
            self?.heroesByrole = heroesByRole
            }).disposed(by: disposeBag)
        
        outputs.roles.subscribe(onNext: { [weak self] roles in
            self?.roles = roles
            self?.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        outputs.error.subscribe(onNext: { [weak self] errorMessage in
            self?.showAlert(message: errorMessage)
            }).disposed(by: disposeBag)
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "roleCell") else { return UITableViewCell() }
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 16
        cell.backgroundColor = .black
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = roles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let role = roles[indexPath.row]
        heroes = heroesByrole[role] ?? []
        collectionView.reloadData()
        
        title = role
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "heroCell", for: indexPath) as? HeroCell else { return UICollectionViewCell() }
        cell.updateView(heroes[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hero = heroes[indexPath.row]
        let heroes = self.heroes
        coordinator?.navigateToHeroDetail(withHero: hero, andHeroes: heroes)
    }

}
