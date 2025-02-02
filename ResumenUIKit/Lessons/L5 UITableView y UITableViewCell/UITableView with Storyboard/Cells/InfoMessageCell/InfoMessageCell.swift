//
//  InfoMessageCell.swift
//  Tabla_Con_Componentes_Encapsulados_UIKIT
//
//  Created by Gonzalo Arques on 25/1/25.
//

import UIKit

class InfoMessageCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var infoMessageLabel: UILabel!
    
    // MARK: - Variables
    var infoMessage: String?
    
    // MARK: - Initialization method
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Configure methods
    internal func configure(infoMessage: String) {
        infoMessageLabel.text = infoMessage
    }
    
}
