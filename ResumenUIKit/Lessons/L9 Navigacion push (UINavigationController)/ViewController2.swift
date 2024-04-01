//
//  ViewController2.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 31/3/24.
//

import UIKit

/*
 Al entrar a este ViewController, por defecto, nos aparecerá un botón de ir atrás
 en la parte izquierda de la barra de nevagación. Si lo pulsamos o hacemos el gesto,
 volveremos al ViewController anterior.
 */

class ViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        title = "View Controller 2"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Next",
            style: .done,
            target: self,
            action: #selector(nextViewController))
    }
    
    @objc
    private func nextViewController() {
        self.navigationController?.pushViewController(ViewController3(), animated: true)
    }
    
}
