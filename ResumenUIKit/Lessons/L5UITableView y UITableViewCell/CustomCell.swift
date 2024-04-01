//
//  TableViewCell.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 25/3/24.
//

import UIKit

class CustomCell: UITableViewCell {
    
    private let deviceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let deviceNameLabel: UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    // Fijaos que en las UITableViewCell customizadas, el init es distinto al de las Views:
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        [deviceImageView, deviceNameLabel].forEach(addSubview)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            deviceImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            deviceImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            deviceImageView.widthAnchor.constraint(equalToConstant: 40),
            
            deviceNameLabel.leadingAnchor.constraint(equalTo: deviceImageView.trailingAnchor, constant: 20),
            deviceNameLabel.centerYAnchor.constraint(equalTo: deviceImageView.centerYAnchor)
        ])
    }
    
    func configure(model: Device) {
        deviceImageView.image = UIImage(systemName: model.imageName)
        deviceNameLabel.text = model.title
    }
    
}
