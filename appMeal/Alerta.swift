//
//  Alerta.swift
//  appMeal
//
//  Created by Hellen Caroline on 29/01/20.
//  Copyright © 2020 Hellen Caroline. All rights reserved.
//

import Foundation
import UIKit


class Alerta {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func exibi(titulo: String = "Atenção", mensagem: String) {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alerta.addAction(ok)
        controller.present(alerta, animated: true, completion: nil)
    }
    
}
