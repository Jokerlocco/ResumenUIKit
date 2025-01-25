//
//  ViewControllerC.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 27/3/24.
//

import UIKit

final class ViewControllerC: UIViewController {
    
    private lazy var viewControllerWithStoryboard: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Present ViewController with Storyboard"
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.presentViewControllerWithStoryboard()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
        addSubviews()
        configureConstraints()
    }
    
    private func addSubviews() {
        [viewControllerWithStoryboard, dismissViewControllerBButton].forEach(view.addSubview)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            viewControllerWithStoryboard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewControllerWithStoryboard.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            dismissViewControllerBButton.topAnchor.constraint(equalTo: viewControllerWithStoryboard.bottomAnchor, constant: 32),
            dismissViewControllerBButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func presentViewControllerWithStoryboard() {
        // Hasta ahora, lo hemos hecho todo por código, pero veamos cómo se presenta un Storyboard:
        
        /* Nota importante:
         En el apartado de los "Attribute Inspector" del ViewController principal del storyboard,
         deberemos de marcar la casilla "Is Initial View Controller" para que se establezca la primera pantalla a cargar en el storyboard.
         Si no hay ningúna marcada así, no funcionará.
         */
        let storyboardName = "PresentStoryboard" // Debemos de indicar el nombre exacto del fichero del Storyboard (aunque sin indicar el .storyboard)
        let storyboardID = "PresentStoryboardViewController" // En el apartado de "Identity" del storyboard, debemos de escribir un storyboard ID en su correspondiente campo, y entonces, es el que debemos de poner aquí también. Nota: No es recomendable marcar la opción "Use Storyboard ID", mejor escribirlo a mano en el campo.
        if let viewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: storyboardID) as? PresentStoryboardViewController { // Instanciamos el storyboard junto a su ViewController asociado
            // viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true)
        }
    }
    
    private func dismissViewControllerC() {
        dismiss(animated: true)
    }
    
}
