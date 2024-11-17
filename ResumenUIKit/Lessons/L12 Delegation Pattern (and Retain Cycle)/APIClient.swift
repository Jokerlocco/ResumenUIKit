//
//  APIClient.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 1/4/24.
//

import Foundation

/*
 Ejemplo del JSON de la API que vamos a obtener:
 
 {
     "count": 1302,
     "next": "https://pokeapi.co/api/v2/pokemon/?offset=151&limit=151",
     "previous": null,
     "results": [
         {
             "name": "bulbasaur",
             "url": "https://pokeapi.co/api/v2/pokemon/1/"
         },
         {
             "name": "ivysaur",
             "url": "https://pokeapi.co/api/v2/pokemon/2/"
         },
         {
             "name": "venusaur",
             "url": "https://pokeapi.co/api/v2/pokemon/3/"
         },
         {
             "name": "charmander",
             "url": "https://pokeapi.co/api/v2/pokemon/4/"
         },
         ...
    ]
 }
 
 Queremos conseguir el array de "results", y luego el "name" y "url" de cada Pokémon del array.
 
 Tipos de datos:
 results -> String
 Array de Pokemons -> Array de objetos
       name -> String
       url -> String
 */

// Modelo de datos de cada Pokémon
struct PokemonDataModel: Decodable { // Implementamos el Decodable para poder hacer la conversión del JSON a objetos de forma exitosa
    let name: String
    let url: String
}

struct PokemonResponseDataModel: Decodable { // También implementamos el Decodable porque también tendrá que convertirse de JSON a objetos
    let pokemons: [PokemonDataModel] // Preparamos una variable para almacenar el arrays de Pokémons
    
    enum CodingKeys: String, CodingKey { // El String representa a "results" en el JSON, y CodingKey representa al propio contenido de "results" (que es un array de Pokémons)
        case results
    }
    
    // Con este init, preparamos el resultado y almacenaje de los datos tras ser convertidos (decodables) a objetos:
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self) // Se crea un contenedor para acceder a las claves JSON
        self.pokemons = try container.decode([PokemonDataModel].self, forKey: .results) // Se decodifica la lista de Pokémons en "results" del enum, y se guarda en la variable de "pokemons".
    }
}

/* Crearemos un protocolo para que la clase que actúe de delegado de APIClient implemente las funciones.
   En este caso, el delegado (la vista) deberá de implementar la función "updatePokemon", que básicamente es para
   mostrar un nuevo (nombre) Pokémon en la interfaz de la pantalla (en el UILabel).
 */
protocol APIClientDelegate: AnyObject {
    func updatePokemon(pokemons: PokemonResponseDataModel)
}

class APIClient {
    
    /*
     Crearemos una variable llamada "delegate" (por convenio, se recomienda que tenga este nombre siempre).
     Esta variable será la "conexión"/"unión" entre el APIClient y la View.
     Realmente, este delegado será la propia View (que en su clase, se establece con: apiClient.delegate = self).
     
     APIClient ha realizado la acción de obtener los datos, y ahora se los enviará a la View (a través de getPokemons() y la variable del delegado),
     y ella, los mostrará en la interfaz (a través de la implementación del protocolo de "updatePokemon" en su clase).
     
     
     
     === Apéndice para explicar los Retain Cycle ===
     Si te fijas, hemos incluido "weak" (débil) a la variable "delegate". Esto es algo recomendable de hacer siempre con esta variable, y con este patrón.
     Si lo piensas:
     
     * La variable "delegate" (ubicada en APIClient) es una referencia (fuerte) a la View.
     * La variable "apiClient" (ubicada en RandomPokemonNameView) es una referencia (fuerte) de APIClient.
     Una no puede funcionar correctamente sin la otra, por lo que siempre estarán "unidas" colaborando juntas.
     Es decir, las referencias de ambos son fuertes, y por lo tanto, evita que sean eliminadas de la memoria.
     Así que, según algunos sucesos (por ejemplo, presentar y dismissear la vista varias veces), hay posibilidades de que se carguen instancias de estas variables varias veces,
     y consuman mucha más memoria de la app, llegando a eventualidad de que pete por exceso de uso de memoria. A esto se le conoce como Ciclo de retención (Retain Cycle).
     
     Básicamente, un ciclo de retención se produce cuando dos o más objetos se mantienen mutuamente en la memoria a través de referencias fuertes.
     Esto puede provocar un uso excesivo de memoria y un comportamiento inesperado.
     Ejemplo sencillo:
     
     class A {
       var b: B? // "b" es una referencia fuerte a una instancia de "B"
     }

     class B {
       var a: A? // "a" es una referencia fuerte a una instancia de "A"
     }

     var a = A()
     var b = B()

     a.b = b
     b.a = a

     // "a" y "b", no se pueden eliminar de la memoria porque se mantienen conectadas entre sí, "viviendo" mutuamente en la memoria.

     Para solucionar este problema, podemos indicar con la palabra reservada "weak" a una de las referencias fuertes conectadas,
     y entonces, convertirla en una referencia débil.
     
     Y justo es lo que hemos hecho con la variable de "delegate" de esta lección.
     
     Una forma fácil de comprobar si está ocurriendo un retain cycle, es compilar, y presentar y dismissear varias veces la View.
     Tras hacerlo, estando en la View, y en el modo debug, pulsar en el botón de "Debug Memory Graph" (es parecido al típico botón de compartir de las redes sociales).
     En la jerarquía de este modo, podemos ver las referencias que están activas en memoria agrupadas por elementos (el AppDelegate, ApiClient, RandomPokemonNameView, etc).
     Justo al lado del nombre del elemento, aparece un número que indica la cantidad de referencias que hay creadas en memoria, y abajo, un listado de ellas (con sus IDs).
     Bueno, pues en este caso, si hay varios (el número de veces que hemos presentado/dismisseado) APIClient y varios RandomPokemonNameView, significa que está ocurriendo
     un retain cycle, y tenemos que solucionarlo.
     
     Consejos para evitar ciclos de retención:
     - Utiliza let siempre que sea posible: Esto ayuda (pero no lo elimina por completo) a evitar la mutación accidental y los ciclos de retención.
     - Utiliza var solo cuando sea necesario: Si necesitas cambiar el valor de una variable a lo largo del tiempo.
     - Ten cuidado al reasignar variables: Asegúrate de que la referencia anterior se libera antes de asignar una nueva.
     - Utiliza el instrumento "Memory Graph" de Xcode: Este instrumento te permite visualizar las referencias entre objetos en tu aplicación y detectar posibles ciclos de retención.
     - Si se usa el patrón de delegado, sí o sí, hay que controlar el retain cycle (por ejemplo, en la variable de "delegate").
     
     */
    weak var delegate: APIClientDelegate?
    
    func getPokemons() {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=151")! // Endpoint de la API que vamos a obtener
        
        // Ejecutamos la tarea para llamar a la API, recibir los datos JSON, y transformarlos (decode) en objetos Swift:
        let task = URLSession.shared.dataTask(with: url) { data, response, error in // Para no complicar el código, solo utilizaremos "data" (que son los propios datos JSON de la API)
            let dataModel = try! JSONDecoder().decode(PokemonResponseDataModel.self, from: data!)
            print("DataModel \(dataModel)")
            self.delegate?.updatePokemon(pokemons: dataModel) // Le pasamos los datos (ya transformados) a la función del delegate (la View)
        }
        task.resume()
    }
    
}
