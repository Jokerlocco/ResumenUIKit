//
//  ButtonsView.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 16/3/24.
//

import UIKit

final class L2ButtonsView: UIView {
    
    private let button1: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Suscríbete a SwiftBeta"
        configuration.subtitle = "Apoya el canal"
        configuration.image = UIImage(systemName: "play.circle.fill")
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let button2: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Suscríbete a SwiftBeta"
        configuration.titleAlignment = .center
        configuration.subtitle = "Apoya el canal"
        configuration.image = UIImage(systemName: "play.circle.fill")
        configuration.imagePadding = 12
        configuration.imagePlacement = .trailing
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let button3: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Suscríbete a SwiftBeta"
        configuration.titleAlignment = .center
        configuration.subtitle = "Apoya el canal"
        configuration.image = UIImage(systemName: "play.circle.fill")
        configuration.imagePadding = 12
        configuration.imagePlacement = .top
        configuration.buttonSize = .large
        configuration.baseBackgroundColor = .systemPurple
        configuration.baseForegroundColor = .white
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var button4: UIButton = { // Con Lazy hacemos que eso se inicialice cuando se tenga que usar (que es después de .self (la propia view), de esta forma, no petará al intentar acceder a la función de la acción.
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Suscríbete a SwiftBeta"
        configuration.titleAlignment = .center
        configuration.subtitle = "Apoya el canal"
        configuration.image = UIImage(systemName: "play.circle.fill")
        configuration.imagePadding = 12
        configuration.imagePlacement = .top
        configuration.buttonSize = .large
        
        // Una forma distinta (con respecto a la clase de introducción) de añadir una acción al botón (sin depender de Objective-C):
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { _ in
            self.showMessage()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = configuration
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviews()
        configureConstraints()
    }
    
    private func addSubviews() {
        [button1, button2, button3, button4].forEach(addSubview)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            button1.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            button1.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 20),
            button2.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 20),
            button3.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            button4.topAnchor.constraint(equalTo: button3.bottomAnchor, constant: 20),
            button4.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func showMessage() {
        print("Button tapped")
    }
    
}
