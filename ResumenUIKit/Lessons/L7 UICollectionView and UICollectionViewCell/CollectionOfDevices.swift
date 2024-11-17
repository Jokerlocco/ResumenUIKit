//
//  CollectionOfDevices.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 26/3/24.
//

import UIKit

private let house: [Device] = [ // Vamos a utilizar la clase Device que creamos en la lección de las tablas, pues haremos algo similar
    Device(title: "Laptop", imageName: "laptopcomputer"),
    Device(title: "Mac mini", imageName: "macmini"),
    Device(title: "Mac Pro", imageName: "macpro.gen3"),
    Device(title: "Pantallas", imageName: "display.2"),
    Device(title: "Apple TV", imageName: "appletv"),
    Device(title: "Laptop", imageName: "laptopcomputer"),
    Device(title: "Mac mini", imageName: "macmini"),
    Device(title: "Mac Pro", imageName: "macpro.gen3"),
    Device(title: "Pantallas", imageName: "display.2"),
    Device(title: "Apple TV", imageName: "appletv"),
    Device(title: "Laptop", imageName: "laptopcomputer"),
    Device(title: "Mac mini", imageName: "macmini"),
    Device(title: "Mac Pro", imageName: "macpro.gen3"),
    Device(title: "Pantallas", imageName: "display.2"),
    Device(title: "Apple TV", imageName: "appletv"),
    Device(title: "Laptop", imageName: "laptopcomputer"),
    Device(title: "Mac mini", imageName: "macmini"),
    Device(title: "Mac Pro", imageName: "macpro.gen3"),
    Device(title: "Pantallas", imageName: "display.2"),
    Device(title: "Apple TV", imageName: "appletv"),
    Device(title: "Laptop", imageName: "laptopcomputer"),
    Device(title: "Mac mini", imageName: "macmini"),
    Device(title: "Mac Pro", imageName: "macpro.gen3"),
    Device(title: "Pantallas", imageName: "display.2"),
    Device(title: "Apple TV", imageName: "appletv")
]

final class CollectionOfDevices: UIView {
    
    /*
     Un UICollectionView en UIKit es una clase que permite mostrar y gestionar una colección de 
     elementos de datos en distintas disposiciones (layouts). La más empleada es UICollectionViewFlowLayout,
     que es una disposición similar a una cuadrícula. Se encarga de organizar las celdas en filas y columnas,
     y se puede personalizar para ajustar el tamaño, el espaciado y otros aspectos del diseño.
     Su contrucción es muy similar al de las UITableView (usa celdas, datasource, delegate, etc)
     */
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // Tipo de scroll en la colección. Por defecto, es vertical. Puedes probar a cambiar esta propiedad para ver los distintos tipos de diseños/comportamientos.
        layout.itemSize = .init(width: 200, height: 80) // Tamaño de cada elemento en el layout
        layout.minimumLineSpacing = 10 // Añade un espacio entre los elementos de las filas
        layout.minimumInteritemSpacing = 10 // Añade un espacio entre los elementos de las columnas
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
        configureCollectionView()
    }
    
    private func addSubviews() {
        [collectionView].forEach(addSubview)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor), // Fijaos que en esta constraint estamos vinculando el CollectionView a los margenes de la vista padre, y no a la vista en sí misma. Es decir, que la collection no estará pegada arriba del todo, sino que tendrá un margen.
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell") // Al igual que con las tablas, hay que registrar (para la optimización de la pantalla) las celdas que vamos a utilizar en el CollectionView. En este caso, una celda personalizada (sacada de la clase del sistema: UICollectionViewCell).
    }
    
}

extension CollectionOfDevices: UICollectionViewDataSource {
    
    // Cantidad exacta de elementos a mostrar en el CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return house.count
    }
    
    // Creación de cada elemento (celda) del collectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        
        if let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as? CustomCollectionViewCell {
            let model = house[indexPath.row]
            reusableCell.configure(model: model)
            cell = reusableCell
        }
        else {
            cell = UICollectionViewCell()
        }
        
        return cell
    }
    
}
