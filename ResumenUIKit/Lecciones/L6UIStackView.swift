//
//  L6UIStackView.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 25/3/24.
//

import UIKit

final class L6UIStackView: UIView {
    
    private let label1: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32)
        label.text = "😀 In App Purchases 😀"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /*
     Un UIStackView es un contenedor especial en UIKit que te permite organizar fácilmente una colección de vistas,
     ya sea de forma horizontal o vertical. Te facilita la tarea de distribuir y alinear las vistas sin necesidad de
     crear manualmente las constraints, únicamente habrá que añadir un spacing entre los elementos.
     Nota: El propio StackView sí que requiere de constraints.
     */
    private let stackView1: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical // Los elementos que contenga el StackView, se colocaran de forma vertical. Por defecto, es horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviewsToView()
        configureConstraints()
        addSubviewsToStackView()
    }
    
    private func addSubviewsToView() {
        [label1, stackView1].forEach(addSubview)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            label1.leadingAnchor.constraint(equalTo: leadingAnchor),
            label1.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stackView1.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 20),
            stackView1.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView1.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func addSubviewsToStackView() {
        // Vamos a crear un array de precios, los recorreremos, y crearemos un botón para cada uno de ellos. Finalmente, los añadiremos al StackView:
        ["1.99€", "2.99€", "14.99€", "24.99€"].forEach { price in
            var configuration = UIButton.Configuration.borderedTinted()
            configuration.title = price
            configuration.subtitle = "Suscripción"
            configuration.image = UIImage(systemName: "eurosign.circle.fill")
            configuration.imagePadding = 12
            configuration.baseBackgroundColor = .systemBlue
            let button = UIButton(configuration: configuration)
            
            stackView1.addArrangedSubview(button)
        }
    }
    
}
