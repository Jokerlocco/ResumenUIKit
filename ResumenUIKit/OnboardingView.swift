//
//  OnboardingView.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 13/3/24.
//

import Foundation
import UIKit

final class OnboardingView: UIView {
    
    private let onboardingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "umbrella")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 // Infinite lines
        label.textAlignment = .center
        label.text = "Bienvenido"
        label.font = UIFont(name: "Arial Rounded MT bold", size: 26)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var skipOnboardingButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Pulsa para continuar"
        config.subtitle = "onboarding"
        
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(showMessage), for: .touchUpInside)
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
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
        [onboardingImageView,
         textLabel,
         skipOnboardingButton
        ].forEach(addSubview)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            onboardingImageView.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            onboardingImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            onboardingImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textLabel.topAnchor.constraint(equalTo: onboardingImageView.bottomAnchor, constant: 32),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            skipOnboardingButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 42),
            skipOnboardingButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    @objc func showMessage() {
        print("Skip onboarding")
    }
    
}
