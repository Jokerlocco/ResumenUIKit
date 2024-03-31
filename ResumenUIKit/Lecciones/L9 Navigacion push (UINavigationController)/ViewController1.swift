//
//  ViewController1.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 29/3/24.
//

import UIKit

/*
 EXPLICACIÓN IMPORTANTE:
 En la lección anterior (número 8), vimos como presentar (present) ViewControllers por
 encima de otros (y desecharlos (dismiss)). Pero en UIKit hay otras formas de navegación
 entre pantallas. En esta lección, utilizaremos un UINavigationController para ello.
 Este elemento es un gestor de ViewControllers. Se encarga de ir almacenando ViewControllers
 de forma jerarquía. En primer lugar, se le indicará un ViewController raíz (lo que se conoce como: RootViewController),
 y a partir de él, podremos ir cargando el resto.
 Su aspecto visual es una barra de navegación (que por esto, se le suele llamar NavBar) que se coloca en la parte
 superior del ViewController (no de forma integrada, sino como un elemento exterior del ViewController),
 a la cual, se le pueden incluir botones en sus lados (generalmente (y recomendable) para navegar entre las pantallas).
 De hecho, al haber navegado a una pantalla posterior a la root, por defecto, aparece un botón
 de "Back" en la parte izquierda del UINavigationController, que nos permitirá volver al ViewController anterior. A esta
 acción se le conoce como "pop" (que es similar al dismiss de los ViewControllers presentados).
 En este tipo de navegación, los ViewControllers no se presentan unos por
 encima de los otros, sino que se van empujando ("pusheando") entre sí con el orden jerárquico en los que se han incluido.
 En conclusión:
 
 (Lección 8) Navegación modal (Presents):
 Los ViewControllers se presentan unos por encima de otros.
 Present -> Presenta el ViewController por encima del actual.
 Dismiss -> Desecha el ViewController presentado.
 Se puede hacer a través de un gesto (arrastrando la vista hacía abajo) o (por ejemplo)
 incluyendo un UIButton que ejecute la función de dismiss.
 
 (Lección actual, 9) Navegación push (UINavigationController):
 Se crea una barra de navegación que gestiona un índice de ViewControllers de forma jerárquica (según el orden en los que
 se han incluido). Se pueden incluir botones en la barra para la navegación deseada.
 Push -> Empuja un nuevo ViewController en la jerarquía de la barra de navegación.
 Pop -> Se elimina el ViewController actual de la jerarquía de la barra de navegación, y vuelve al anterior.
 Se pueden añadir los botones deseados en la barra de navegación, pero por defecto, se puede hacer un "pop" a través de un gesto
 (arrastrar horizontalmente la vista de un lado de la pantalla al otro) o con el botón de "Back" que aparece en la parte izquierda de la barra
 (al haber navegado a una pantalla posterior del root)
 
 Hasta ahora, hemos hecho todas las lecciones de forma programática (todo a través de código) para desarrollar mejor nuestras
 habilidades, y para tener una app más flexible, pero en este caso, tenemos que forzarnos a crear un Storyboard. Esto es debido
 a que si quisiéramos crear un UINavigationController a través de código, habría que tocar la clase SceneDelegate (que afecta a
 toda la app) y más rollos complejos. Por lo tanto, si necesitamos incluir un UINavigationController, tendremos que hacerlo a través de
 Storyboard sí o sí. Entonces, ahí incluiremos el UINavigationController (que debe de tener marcada la opción de "Is initial View Controller",
 para que sea lo primero que se cargue al iniciar el storyboard), y su ViewController raíz (root).
 Nota: Para incluir el UINavigationController, debemos de seleccionar el ViewController raíz en el Storyboard, y en la barra superior de
 Xcode, seleccionar la opción de "Editor" -> "Embed in" -> "Navigation Controller".
 Con tan solo tener el UINavigationController incluido junto al ViewController raíz (vinculado a su controller .swift), no es necesario
 hacer nada más de diseño en el storyboard, ni incluir los otros ViewControllers, ni nada. Ya nos podemos centrar en el código.
 El storyboard debe de quedar así:
 
 [Flecha de "Is initial View Controller"] ->
 UINavigationViewController
 [Flecha de unión (Segue) entre el NavigationController y el ViewController raíz (root)] -->
 ViewController root (con una clase controladora .swift asociada)
 
 En el caso de esta lección, hemos creado un storyboard llamado "UINavigationControllerLesson", en el que hemos incluido un
 UINavigationController (le he puesto "Is initial View Controller") junto a la unión de su ViewController raíz (root),
 que tiene vinculada esta misma clase controladora (ViewController1).
 En la clase de "MainViewController", se puede ver como inicializamos todo esto.
 
 Bueno, una vez expicada la teoría, y los preliminares, vamos a ver como funciona (como con todas las lecciones,
 veremos lo básico para saber como funciona, pero en el fondo, tiene más chicha):
 */

class ViewController1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "View Controller 1" // Añadimos un título a la barra de navegación del Navigation Controller
        /*
         Añadimos un botón en la parte derecha de la barra de navegación del Navigation Controller.
         Nota:
         - Podemos añadir varios botones (array) con rightBarButtonItems.
         - Podemos añadir uno o varios botones en la parte izquierda con leftBarButtonItem o leftBarButtonItems
         */
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Next", // Título del botón
            style: .done, // Estilo visual del botón
            target: self, // Pantalla en la que se debe de detectar el tapeo del botón (en este caso, esta misma pantalla)
            action: #selector(nextViewController)) // Función que debe de hacer el botón al ser pulsado. Como se aprecia, requerimos de elementos de Objective-C.
    }
    
    @objc
    private func nextViewController() {
        // Hacemos un push para añadir el ViewController2 a la pila de la jerarquía del Navigation Controller:
        self.navigationController?.pushViewController(ViewController2(), animated: true)
    }
    
}


