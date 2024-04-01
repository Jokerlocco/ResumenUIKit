//
//  L3UILabelView.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 18/3/24.
//

import UIKit

final class L3UILabelView: UIView {
    
    private let label1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Suscríbete a SwiftBeta"
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 26)
        label.textAlignment = .center
        label.textColor = .purple
        return label
    }()
    
    private let label2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Aprende a programar Swift y SwiftUI. Crea apps en Xcode y súbelas a la App Store"
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0 // Líneas infinitas (hasta que se vea el texto por completo)
        return label
    }()
    
    private let label3: UILabel = {
        let text = "Aprende a programar Swift y SwiftUI. Crea apps en Xcode y súbelas a la App Store"
        let attributedText: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.red,
            .foregroundColor: UIColor.white,
            .backgroundColor: UIColor.blue,
            .font: UIFont.systemFont(ofSize: 32)
        ]
        let attributedString = NSAttributedString(string: text, attributes: attributedText)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = attributedString // Label con distintos atributos visuales
        label.numberOfLines = 0
        return label
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
        [label1, label2, label3].forEach(addSubview)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            label1.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 12),
            label2.centerXAnchor.constraint(equalTo: centerXAnchor),
            label2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            label2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 12),
            label3.centerXAnchor.constraint(equalTo: centerXAnchor),
            label3.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            label3.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
    }
    
}
