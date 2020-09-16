//
//  Coordinator.swift
//  Heroes
//
//  Created by Robihamanto on 16/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
