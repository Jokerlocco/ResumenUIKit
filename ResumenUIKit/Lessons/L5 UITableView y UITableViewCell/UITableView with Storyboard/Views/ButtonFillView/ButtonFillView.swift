//
//  ButtonFillView.swift
//  Tabla_Con_Componentes_Encapsulados_UIKIT
//
//  Created by Gonzalo Arques on 26/1/25.
//

import UIKit

class ButtonFillView: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet weak var button: UIButton!
    
    // MARK: - Variables
    weak var delegate: ButtonFillViewDelegate?
    
    // MARK: - Initialization methods
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let nib = UINib(nibName: "ButtonFillView", bundle: nil) // En el caso de las UIView personalizadas, NO indicaremos la clase controladora en la propia UIView (porque petará por memoria), sino en el File Owner del .xib.
        guard let customView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        else { fatalError("Error instantiating the custom view") }
        addSubview(customView)
        
        if let button = button {
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
    }
    
    @objc private func buttonTapped() {
        delegate?.buttonDidTapped(self)
    }
    
}

// Patrón de delegado:
protocol ButtonFillViewDelegate: AnyObject {
    func buttonDidTapped(_ sender: ButtonFillView)
}
