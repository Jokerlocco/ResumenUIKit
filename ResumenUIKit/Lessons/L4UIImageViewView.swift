//
//  L4UIImageViewView.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 18/3/24.
//

import UIKit

final class L4UIImageViewView: UIView {
    
    private let imageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "gamecontroller.fill") // Imagen del sistema (una imagen de un mando de videojuegos rellenada con un color (azul por defecto))
        imageView.contentMode = .scaleAspectFit // Hacemos que se adapte al tamaño del width y height proporcionado en las constraints
        imageView.tintColor = .purple
        imageView.layer.cornerRadius = 150 // Línea redonda alrededor de la imagen (150, porque es la mitad de 300 que es lo que hemos indicado de tamaño en las constraints)
        imageView.layer.borderWidth = 10 // Ancho de la línea
        imageView.layer.borderColor = UIColor.blue.cgColor // Color de la línea
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addViews()
        configureConstraints()
    }
    
    private func addViews() {
        [imageView1].forEach(addSubview)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            imageView1.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            imageView1.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView1.widthAnchor.constraint(equalToConstant: 300),
            imageView1.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
}
