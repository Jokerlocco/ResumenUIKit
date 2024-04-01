//
//  TableOfDevices.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 25/3/24.
//

import UIKit

/*
 Curiosidad:
 Esta clase "TableOfDevices" está destinada a la configuración visual de la tabla, y sus extensiones adicionales,
 se encargan de la lógica específica de la tabla, como la configuración de las secciones, las filas y las acciones del usuario.
 Es decir, se trata de una clase que representa una vista (View).

 Si estuvieramos en una app con una arquitectura de diseño implementada (MVC, MVP, etc), las variables de datos que definimos a
 continuación (house, work y allMyDevices) no deberían de estar en esta clase.
 Pero para no complicar la explicación, nos centraremos en la creación de la tabla y ya, así que, las incluimos en esta misma clase.
 */

private let house: [Device] = [
    Device(title: "Laptop", imageName: "laptopcomputer"),
    Device(title: "Mac mini", imageName: "macmini"),
    Device(title: "Mac Pro", imageName: "macpro.gen3"),
    Device(title: "Pantallas", imageName: "display.2"),
    Device(title: "Apple TV", imageName: "appletv")
]

private let work: [Device] = [
    Device(title: "Iphone", imageName: "iphone"),
    Device(title: "iPad", imageName: "ipad"),
    Device(title: "Airpods", imageName: "airpods"),
    Device(title: "Apple Watch", imageName: "applewatch")
]

private var allMyDevices: [[Device]] = [house, work]

class TableOfDevices: UIView {
    
    private let devicesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(devicesTableView)
        configureConstraints()
        configureTableView()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            devicesTableView.topAnchor.constraint(equalTo: topAnchor),
            devicesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            devicesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            devicesTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureTableView() {
        devicesTableView.dataSource = self // El dataSource sirve para definir la información que se muestra en cada sección y fila de la tabla. Crearemos una extensión de esta clase para definir sus funciones correspondientes.
        devicesTableView.delegate = self // El delegate sirve para definir las acciones que se deben de realizar cuando el usuario interactúa con la tabla (slecciona una fila, toca un botón, etc). Crearemos una extensión de esta clase para definir sus funciones correspondientes.
        devicesTableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell") // Debemos de registrar que tipo de celdas va a tener la tabla para una optimización del funcionamiento de la tabla. En este caso, solo es de un tipo ("CustomCell"), pero si usasemos una celda distinta, habría que registrarla adicionalmente.
    }
    
}

extension TableOfDevices: UITableViewDataSource {
    
    // Por defecto, las tablas tienen una sola sección, pero podemos crear más en base al contenido que tengamos:
    func numberOfSections(in tableView: UITableView) -> Int {
        return allMyDevices.count // Si solo es una línea, se puede evitar el poner el "return", pero me gusta ponerlo
    }
    
    // Título (opcional) para cada sección de la tabla:
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName = ""
        
        if section == 0 {
            sectionName = "Device House"
        }
        else {
            sectionName = "Device Work"
        }
        
        return sectionName
    }
    
    // Configurar el número de filas/celdas que tendrá la tabla:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMyDevices[section].count
    }
    
    // Crear cada celda (estilo, datos, etc) de la fila correspondiente. Se puede tener ifs para crear celdas de distinto tipo (o cualquier otra cosa que se requiera diferenciar).
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        // Nunca es rescomendable usar ! para desempaquetar una comprobación de nil, por lo tanto, haremos lo siguiente:
        if let reusableCell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell {
            let model = allMyDevices[indexPath.section][indexPath.row] // Entramos a la sección correspondiente, y luego a la fila correspondiente de esa sección
            reusableCell.configure(model: model)
            cell = reusableCell
        }
        else {
            cell = UITableViewCell()
        }
        
        return cell
    }
    
    // Con esta función, habilitamos (true) o no (false, por defecto), si la tabla es editable por el usuario. Configuraremos la acción de edición con otra función (vista a continuación).
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Con esta función podemos establecer la edición de la tabla:
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete { // Con esto, el usuario puede eliminar una fila de la tabla (debe de arrastrar la fila hacia la izquierda por completo; o arrastrarla un poco, y darle al botón de "Borrar")
            allMyDevices[indexPath.section].remove(at: indexPath.row) // Eliminamos la fila (de la sección) seleccionada por el usuario (eliminamos el elemento del array)
            
            if allMyDevices[indexPath.section].isEmpty {
                allMyDevices.remove(at: indexPath.section)
            }
            
            tableView.reloadData() // Recargamos la tabla para que se refleje el cambio del array de forma visual
        }
    }
    
}

extension TableOfDevices: UITableViewDelegate {
    
    // Esta función se llama cuando el usuario clica en una celda/fila de la tabla:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return print("Estoy pulsando la fila \(indexPath.row + 1) de la sección \(indexPath.section + 1)") // Hay que sumar 1 para que sea amigable para el usuario, pues para nosotros empieza en 0.
    }
    
}
