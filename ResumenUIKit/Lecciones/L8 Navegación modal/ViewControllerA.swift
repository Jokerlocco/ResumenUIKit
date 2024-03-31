//
//  ViewControllerA.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 27/3/24.
//

import UIKit

final class ViewControllerA: UIViewController { // En este caso, no usamos una View como hasta ahora, ya que vamos a ver como navegar entre ViewControllers.
    
    private lazy var presentViewControllerBButton: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Present ViewController B"
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.presentViewControllerB()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.addSubview(presentViewControllerBButton)
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            presentViewControllerBButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentViewControllerBButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func presentViewControllerB() {
        present(ViewControllerB(), animated: true) // Presentamos el ViewControllerB por encima del A. Activamos la opción de animated para que la pantalla se presente con una animación más bonita.
    }
    
}

