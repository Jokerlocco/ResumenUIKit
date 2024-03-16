//
//  ViewController.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 13/3/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func loadView() {
        self.view = OnboardingView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }


}

