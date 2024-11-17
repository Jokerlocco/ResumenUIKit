//
//  RandomPokemonNameView.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 1/4/24.
//

import UIKit

/*
 En Swift (y en otros lenguajes y frameworks) se emplea mucho el patrón de delegado (Delegation Pattern)
 para delegar responsabilidades, y tener un código mucho más organizado y correcto.
 De hecho, lo hemos utilizado con los UITableView y los UICollectionView.
 Es muy importante entenderlo, y saber aplicarlo como desarrolladores mobile.
 Consiste en dar una responsabilidad a otro objeto para que complemente un trabajo.
 Como la vida misma: Un arquitecto se encarga de diseñar un edificio, pero él no lo construye,
 delega ese trabajo a los constructores.
 Otra analogía aún más acertada con el patrón:
 Imagina que tienes un asistente para ayudarte con las tareas del hogar.
 Tú delegas la responsabilidad/acción de limpiar la casa a tu asistente.
 Cuando tu asistente ha terminado de limpiar la casa, te lo notifica (por si quieres revisarlo
 o cualquier otra cosa).
 
 En cuanto al código y su diseño, por ejemplo, una View no debería de encargarse de realizar llamadas HTTPS
 para obtener datos de un servidor. Esa acción la debería de hacer otra clase en su lugar.
 La View solo debería centrarse en construir la parte visual. Eso sí, debe de estar a la espera de recibir los
 resultados del delegado para mostrar los datos recibidos.
 En esta lección, vamos a aprender a como implementar este patrón delegado siguiendo con este ejemplo.
 
 Vamos a tener una View (llamada "RandomPokemonNameView") que tendrá un UILabel y un UIButton.
 Al pulsar en el botón, se llamará (a través de una petición HTTPS) a la API gratuita de Pokémon, de la cual se
 extraerán datos, y entonces, se cogerá un nombre aleatorio de un Pokémon, y se mostrará en el UILabel de la View.
 La acción de llamar a la API, y manejar los datos recibidos no la hará la View, sino una clase delegada de la misma (llamada "APIClient").
 La View solo se encargará de mostrar el resultado final de esos datos cuando los reciba.
 
 * La vista delega la responsabilidad de obtener los datos a APIClient.
 
 * Pero por otro lado, la vista actúa como el delegado de APIClient. Se encarga de notificar a
   APIClient cuando el usuario pulsa el botón, y también, dibuja los resultados que le entrega APIClient.
 
 Existirá una variable llamada "delegate" que hará la "conexión" entre ambas clases, y sus responsabilidades y contactos.
 
 1. Se pulsa en el botón de recibir un nombre aleatorio de un Pokémon en la View de RandomPokemonNameView.
 2. RandomPokemonNameView le pide a APIClient que se encargue de llamar a la API para recibir los datos, y manipularlos.
 3. APIClient realiza las acciones delegadas pertinentes, y devuelve los datos al RandomPokemonNameView.
 4. RandomPokemonNameView muestra el nombre del Pokémon.
 
 RandomPokemonNameView
       (UIButton) Solicitud de la acción --> APIClient
                                         <-- Realizá la acción, y devuelve el resultado
       Se pinta el resultado por pantalla
 
 Vamos a verlo en código:
 
 Nota: Debes de saber conceptos básicos de acceso y manipulación de APIs para comprender todo correctamente, pero lo intentaré explicar de forma simple.
 */

final class RandomPokemonNameView: UIView {
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "PlaceHolder"
        return label
    }()
    
    private lazy var updatePokemonButton: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Update Pokemon"
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { [weak self] _ in // Indicamos el weak self, debido a que sino, estaría ocurriendo un retain cycle entre el botón y la vista. Explico esto en la clase del APIClient (con otro caso)
            self?.didTapOnUpdatePokemonButton()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let apiClient = APIClient() // Inicializamos el APIClient que será el encargado de la responsabilidad de obtener los datos de la API (algo externo a la interfaz visual)
    
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
        
        // RandomPokemonNameView actúa como el delegado de APIClient para notificar la pulsación del botón, y también para mostrar el resultado de los datos de la API
        apiClient.delegate = self
    }
    
    private func addViews() {
        [nameLabel, updatePokemonButton].forEach(addSubview)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            updatePokemonButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            updatePokemonButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func didTapOnUpdatePokemonButton() { // Acción del botón
        apiClient.getPokemons() // La View le pide al ApiClient que realice la acción de traer los datos (Pokémons), y entonces, a través de la variable "delegate", y la extensión de la View, modificaremos el (nombre) Pokémon en la interfaz.
    }
}

/* Creamos una extensión de la View, para recibir los datos del delegado, y mostrarlos en la interfaz.
   De esta forma, separamos la responsabilidad de la delegación de la propia responsabilidad de la View.
 */
extension RandomPokemonNameView: APIClientDelegate {
    
    func updatePokemon(pokemons: PokemonResponseDataModel) {
        /* Hacemos un control del hilo principal de la app (que es el encargado de modificar el apartado visual).
           Esto es debido a que como al acceder a la API, puede tardar un rato en recibir los datos y demás, la pantalla puede
           tardar un rato en actualizarse, y si no lo controlamos, se bloqueará por los hilos, y crasheará.
           Por lo tanto, al hacer el control del hilo de forma asíncrona, la interfaz se actualizará cuando tenga los datos, y no antes, evitando el pete.
         */
        DispatchQueue.main.async {
            if let randomPokemonName: String = pokemons.pokemons.randomElement()?.name { // Cogemos aleatoriamente un pokémon (concretamente, su nombre), y lo mostramos en el UILabel de la View
                self.nameLabel.text = randomPokemonName
            }
        }
    }
    
}
