//
//  ViewController.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 13/3/24.
//

import UIKit

class MainViewController: UIViewController {
    
    override func loadView() {
        /*
         Esta es la clase principal de esta app. Se debe de cambiar la siguiente línea con la view de la lección que se quiera cargar:
         */
        self.view = CollectionOfDevices()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
    }


}

