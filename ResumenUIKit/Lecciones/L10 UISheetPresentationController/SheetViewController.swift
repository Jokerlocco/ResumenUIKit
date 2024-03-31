//
//  SheetViewController.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 31/3/24.
//

import UIKit

/*
 El UISheetPresentationController es otra forma que tenemos de navegar entre pantallas.
 Usa los presents de la navagación modal, pero en este caso, podemos configurar unas propiedades
 para poder ajustar el tamaño de presentación del ViewController y otras cosas.
 */

class SheetViewController: UIViewController {
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SwiftBeta!"
        label.font = .systemFont(ofSize: 32)
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // A continuación, configuraremos las propiedades del SheetPresentation del ViewController
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.selectedDetentIdentifier = .medium // Posición por defecto al cargar el ViewController a través del SheetPresentation. En este caso, lo pondremos en mitad de la pantalla.
            presentationController.detents = [ // Indicamos las posiciones válidas (que tan grande o pequeño se puede hacer por parte del usuario) del ViewController a través del SheetPresentation.
                .large(), // Se puede establecer casi al tope de la pantalla. Si no indicáramos esta propiedad en este array, el ViewController no se podría ampliar hasta aquí. Puedes probar a quitarlo para comprobarlo.
                .medium() // O también se puede establecer en mitad de la pantalla
                // Nota: Si se tira por debajo del medium, entonces, se realizá un dimiss del ViewController.
            ]
            presentationController.prefersGrabberVisible = true // Añade una línea visual en la parte superior del ViewController (a través del SheetPresentation) para indicar al usuario que puede interactuar con la vista para ajustar su posición (en este caso, medium o large).
            presentationController.preferredCornerRadius = 20 // Añadimos unos bordes redondeados al ViewController (a través del SheetPresentation)
        }
    }
    
}
