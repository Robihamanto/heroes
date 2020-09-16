//
//  MainViewController.swift
//  Heroes
//
//  Created by Robihamanto on 16/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    private var viewModel: MainViewModel!
    private var users = [Hero]()
    
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
//        let inputs = viewModel.input
//        let outputs = viewModel.output
        
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
