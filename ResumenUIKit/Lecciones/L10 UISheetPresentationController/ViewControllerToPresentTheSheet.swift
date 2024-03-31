//
//  ViewControllerToPresentTheSheet.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 31/3/24.
//

import UIKit

class ViewControllerToPresentTheSheet: UIViewController {
    
    private lazy var button: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Presentar el Sheet"
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.presentSheetViewController()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func presentSheetViewController() {
        let viewControllerToPresent = SheetViewController()
        present(viewControllerToPresent, animated: true)
    }
    
}
