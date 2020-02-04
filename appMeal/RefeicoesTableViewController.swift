//
//  TableTableViewController.swift
//  appMeal
//
//  Created by Hellen Caroline on 16/01/20.
//  Copyright © 2020 Hellen Caroline. All rights reserved.
//

import UIKit

class RefeicoesTableViewController: UITableViewController, AdicionaRefeicaoDelegate {
    
    var refeicoes: [Refeicao] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refeicoes = RefeicaoDao().recupera()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let refeicao = refeicoes[indexPath.row]
        cell.textLabel?.text = refeicao.nome
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(exibeDetalhes))
        cell.addGestureRecognizer(longPress)

        return cell
    }
    
    @objc func exibeDetalhes(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let celula = gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: celula) else {
                return
            }
            
            let refeicao = refeicoes[indexPath.row]
            RemoveRefeicaoViewController(controller: self).exibe(refeicao) { (alerta) in
                self.refeicoes.remove(at: indexPath.row)
                self.tableView.reloadData()
            }
        }
    }
    
    func add(_ refeicao: Refeicao) {
        refeicoes.append(refeicao)
        tableView.reloadData()
        RefeicaoDao().save(refeicoes)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adicionar" {
            if let viewController = segue.destination as? ViewController {
                viewController.delegate = self
            }
        }
    }
}
