//
//  ViewController.swift
//  appMeal
//
//  Created by Hellen Caroline on 16/01/20.
//  Copyright © 2020 Hellen Caroline. All rights reserved.
//

import UIKit

protocol AdicionaRefeicaoDelegate {
    func add(_ refeicao: Refeicao)
}

class ViewController: UIViewController, AdicionarItemDelegate {
 
    @IBOutlet weak var nomeTextField: UITextField?
    @IBOutlet weak var felicidadeTextField: UITextField?
    @IBOutlet weak var itensTableView: UITableView!
    
    var delegate: AdicionaRefeicaoDelegate?
    var itensSelecionado: [Item] = []
    var itens: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let botaoAdicionarItem = UIBarButtonItem(
            title: "Adicionar", style: .plain, target: self, action: #selector(adicionarItem))
        navigationItem.rightBarButtonItem = botaoAdicionarItem
        recuperaItens()
    }
    
    func recuperaItens() {
        itens = ItemDao().recupera()
    }
    
    @objc func adicionarItem() {
        let adicionarItemViewController = AdicionarItemViewController(delegate: self)
        navigationController?.pushViewController(adicionarItemViewController, animated: true)
        
    }
    
    func add(_ item: Item) {
        itens.append(item)
         // itensTableView.reloadData()
        
        ItemDao().save(itens)
        if let tableView = itensTableView {
            tableView.reloadData()
        } else {
            Alerta(controller: self).exibi(mensagem: "Erro ao atualizar tabela")
        }
        
    }
    
    func recuperaRefeicaoFormulario() -> Refeicao? {
        
        guard let nome = nomeTextField?.text else {
            return nil
        }
        
        guard let felicidadeRefeicao = felicidadeTextField?.text, let felicidade = Int(felicidadeRefeicao) else {
            return nil
        }
        
        let refeicao = Refeicao(nome: nome, felicidade: felicidade, itens: itensSelecionado)
        
        return refeicao
        
    }

    @IBAction func adicionar(_ sender: Any) {
        if let refeicao = recuperaRefeicaoFormulario() {
            delegate?.add(refeicao)
            navigationController?.popViewController(animated: true)
        } else {
            Alerta(controller: self).exibi(mensagem: "Erro ao ler dados do formulário")
        }
    }
}

extension ViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let item = itens[indexPath.row]
        cell.textLabel?.text = item.nome
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        if cell.accessoryType == .none {
            cell.accessoryType = .checkmark
            
            let linhaSelecionadaTabela = indexPath.row
            itensSelecionado.append(itens[linhaSelecionadaTabela])
        } else {
            cell.accessoryType = .none
            
            let item = itens[indexPath.row]
            if let posicao = itensSelecionado.index(of: item) {
                itensSelecionado.remove(at: posicao)
            }
        }
    }
}

