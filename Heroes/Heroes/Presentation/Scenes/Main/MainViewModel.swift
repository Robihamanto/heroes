//
//  MainViewModel.swift
//  Heroes
//
//  Created by Robihamanto on 16/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Foundation

protocol MainViewModelInput {
    
}

protocol MainViewModelOutput {
    
}

protocol MainViewModelType {
    var input: MainViewModelInput { get }
    var output: MainViewModelOutput { get }
}

class MainViewModel: MainViewModelType, MainViewModelInput, MainViewModelOutput  {
    
    //MARK: - Input & Output
    var input : MainViewModelInput { return self }
    var output: MainViewModelOutput { return self }
    
}
