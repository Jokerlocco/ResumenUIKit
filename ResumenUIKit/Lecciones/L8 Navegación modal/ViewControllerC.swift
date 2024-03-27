//
//  ViewControllerC.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 27/3/24.
//

import UIKit

final class ViewControllerC: UIViewController {
    
    private lazy var dismissViewControllerBButton: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Dismiss ViewController C"
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.dismissViewControllerC()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .red
        view.addSubview(dismissViewControllerBButton)
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            dismissViewControllerBButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dismissViewControllerBButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func dismissViewControllerC() {
        dismiss(animated: true)
    }
    
}
