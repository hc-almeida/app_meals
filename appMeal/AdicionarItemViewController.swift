//
//  AdicionarItemViewController.swift
//  appMeal
//
//  Created by Hellen Caroline on 20/01/20.
//  Copyright © 2020 Hellen Caroline. All rights reserved.
//

import UIKit

protocol AdicionarItemDelegate {
    func add(_ item: Item)
}

class AdicionarItemViewController: UIViewController {
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var caloriasTextField: UITextField!
    
    var delegate: AdicionarItemDelegate?
    
    init(delegate: AdicionarItemDelegate) {
        super.init(nibName: "AdicionarItemViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func adicionarItem(_ sender: Any) {
        guard let nome = nomeTextField.text, let caloriasRefeicao = caloriasTextField.text else {
            return
        }
        
        if let calorias = Double(caloriasRefeicao) {
            let item = Item(nome: nome, calorias: calorias)
            delegate?.add(item)
            
            navigationController?.popViewController(animated: true)
        }
    }
}


