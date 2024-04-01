//
//  ViewController3.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 31/3/24.
//

import UIKit

/*
 Como en este punto tenemos dos ViewControllers anteriores cargados en la pila de la
 jerarquía del Navigation Controller, si mantenemos pulsado el botón de ir atrás, podremos
 seleccionar a que ViewController anterior queremos ir.
 */

class ViewController3: UIViewController {
    
    private lazy var button1: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Ir al View Controller 4"
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.presentViewController()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var button2: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Volver"
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.popCurrentViewController()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        title = "View Controller 3"
        
        view.addSubview(button1)
        view.addSubview(button2)
        NSLayoutConstraint.activate([
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 20),
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func presentViewController() {
        // Podemos combinar los distintos tipos de navegaciones sin problemas:
        self.present(ViewController4(), animated: true)
    }
    
    private func popCurrentViewController() {
        self.navigationController?.popViewController(animated: true) // Volvemos al ViewController anterior de la pila
        // self.navigationController?.popToRootViewController(animated: true) Con esto, podemos hacer un pop para volver directamente al ViewController raíz (root) de la navegación.
    }
    
}
