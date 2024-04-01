//
//  L11ModernUICollectionView.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 1/4/24.
//

import UIKit

/*
 En esta lección, vamos a aprender a como crear un CollectionView de una forma más
 moderna y simple. Para ello, emplearemos un DiffableDataSource y un CompositionalLayout.
 Vamos a verlo:
 */

struct DeviceWithID: Hashable {
    let id: UUID = UUID()
    let title: String
    let imageName: String
}

let home = [
    DeviceWithID(title: "Laptop", imageName: "laptopcomputer"),
    DeviceWithID(title: "Mac mini", imageName: "macmini"),
    DeviceWithID(title: "Mac Pro", imageName: "macpro.gen3"),
    DeviceWithID(title: "Pantallas", imageName: "display.2"),
    DeviceWithID(title: "Apple TV", imageName: "appletv")
]

let office = [
    DeviceWithID(title: "Laptop", imageName: "laptopcomputer"),
    DeviceWithID(title: "Mac mini", imageName: "macmini"),
    DeviceWithID(title: "Mac Pro", imageName: "macpro.gen3")
]

final class L11ModernUICollectionView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped) // Creamos una configuración con una apariencia
        let layout = UICollectionViewCompositionalLayout.list(using: configuration) // Generamos un layout con la configuración creada
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout) // Creamos el CollectionView pasándole el layout (con la configuración)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var dataSource: UICollectionViewDiffableDataSource<Int, DeviceWithID> = {
        // Vamos a crear una celda rápidamente de esta forma:
        let deviceCell = UICollectionView.CellRegistration<UICollectionViewListCell, DeviceWithID> { cell, indexPath, model in
            var listContentConfiguration = UIListContentConfiguration.cell() // Con esto, podemos crear una interfaz rápidamente, por ejemplo, una celda.
            listContentConfiguration.text = model.title
            listContentConfiguration.image = UIImage(systemName: model.imageName)
            cell.contentConfiguration = listContentConfiguration
        }
        
        // Creamos el dataSource para nuestro CollectionView pasándole la celda, el indexPath y datos correspondientes
        let dataSource = UICollectionViewDiffableDataSource<Int, DeviceWithID>(collectionView: collectionView) { collectionView, indexPath, model in
            return collectionView.dequeueConfiguredReusableCell(using: deviceCell, for: indexPath, item: model)
        }
        
        return dataSource
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
        collectionView.backgroundColor = .green
        addDataToCollectionView()
    }
    
    private func addSubviews() {
        [collectionView].forEach(addSubview)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func addDataToCollectionView() {
        var snapshot = dataSource.snapshot() // Creamos lo que se conoce como una snapshot, que es una "foto" del estado actual del CollectionView, y la cual, podemos modificar
        snapshot.appendSections([0, 1]) // Le pasamos las secciones que debe de tener el CollectionView. En este caso, la 0 y la 1.
        snapshot.appendItems(home, toSection: 0) // Les pasamos los items (en este caso, el array de home) que va a tener esa sección
        snapshot.appendItems(office, toSection: 1)
        dataSource.apply(snapshot) // Aplicamos la configuración del snapshot en el dataSource del CollectionView
        
        
        // Como curiosidad, vamos a simular que se añaden más elementos (3) al CollectionView después de dos segundos.
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Con el DispatchQueue podemos ejecutar una tarea después de un tiempo determinado en la hilo/cola principal de la app. En este caso, dos segundos.
            // Tras los dos segundos, vamos a añadir más items al snapshot (sección 0), y reflejarlo en el dataSource del CollectionView:
            snapshot.appendItems(
                [
                    .init(title: "New Device", imageName: "appletv"),
                    .init(title: "New Device 2", imageName: "appletv"),
                    .init(title: "New Device 3", imageName: "appletv")
                ],
                toSection: 0)
            self.dataSource.apply(snapshot)
        }
    }
    
}
