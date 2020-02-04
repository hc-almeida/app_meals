//
//  RemoveRefeicaoViewController.swift
//  appMeal
//
//  Created by Hellen Caroline on 03/02/20.
//  Copyright © 2020 Hellen Caroline. All rights reserved.
//

import Foundation
import UIKit

class RemoveRefeicaoViewController {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func exibe(_ refeicao: Refeicao, handler: @escaping (UIAlertAction) -> Void) {
        
        let alerta = UIAlertController(title: refeicao.nome, message: refeicao.detalhes(), preferredStyle: .alert)
        let botaoCancelar = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alerta.addAction(botaoCancelar)
        let botaoRemover = UIAlertAction(title: "remover", style: .destructive, handler: handler)
        
        alerta.addAction(botaoRemover)
        
        controller.present(alerta, animated: true, completion: nil)
        
    }
}
