//
//  ViewController.swift
//  AnimationBase
//
//  Created by Marcos Molero on 25/04/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let content: [String] = ["Ilustraciones Estáticas",
                             "Ilustraciones Dinámicas",
                             "Transiciones entre pantallas",
                             "Transiciones elementos de navegación",
                             "Transiciones en la misma pantalla (Shared elements)",
                             "Transiciones en la misma pantalla (Motion layout)"]
    
    let descriptions: [String] = ["Imagen que explican un concepto o una acción de forma estática.",
                                  "Imagen que explican un concepto o una acción. La ilustracción será animada.",
                                  "Efecto que se aplica en el pasar de una pantalla a otra. La transición tedrá que ser siempre nativa.",
                                  "Conversión de un elemento, en una misma pantalla. Los iconos cambian de estado transformandose en otros iconos.",
                                  "Cambiar de vista, visualizar información adicional o expandir una descripción.",
                                  "Aplicar efectos a elementos, para dar un feedback al usuario a la hora de interactuar con la app."]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: LabelCell = tableView.dequeueReusableCell(withIdentifier: "labelCell") as? LabelCell {
            cell.setup(text: content[indexPath.row], description: descriptions[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            break
        case 1:
            performSegue(withIdentifier: "showPages", sender: nil)
        case 2:
            performSegue(withIdentifier: "showTransitions", sender: nil)
        case 3:
            performSegue(withIdentifier: "showBetweenElements", sender: nil)
        case 4:
            performSegue(withIdentifier: "showBetweenScreens", sender: nil)
        case 5:
            performSegue(withIdentifier: "showInScreens", sender: nil)
        default:
            return
        }
    }
}
