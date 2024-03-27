//
//  ViewControllerB.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 27/3/24.
//

import UIKit

final class ViewControllerB: UIViewController {
    
    private lazy var presentViewControllerCButton: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Present ViewController C"
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.presentViewControllerC()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var dismissViewControllerBButton: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Dismiss ViewController B"
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.dismissViewControllerB()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .green
        addSubviews()
        configureConstraints()
    }
    
    private func addSubviews() {
        [presentViewControllerCButton, dismissViewControllerBButton].forEach(view.addSubview)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            presentViewControllerCButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentViewControllerCButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            dismissViewControllerBButton.topAnchor.constraint(equalTo: presentViewControllerCButton.bottomAnchor, constant: 32),
            dismissViewControllerBButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func presentViewControllerC() {
        present(ViewControllerC(), animated: true) { // De esta forma, podemos ejecutar un completion cuando se presente la pantalla (en este caso, hacemos un print):
            print("ViewController C is presented")
        }
    }
    
    private func dismissViewControllerB() { // Los dismiss también tienen completions
        dismiss(animated: true) {
            print("ViewController B is dismissed")
        }
    }
    
}
