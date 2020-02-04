//
//  RefeicaoDao.swift
//  appMeal
//
//  Created by Hellen Caroline on 03/02/20.
//  Copyright © 2020 Hellen Caroline. All rights reserved.
//

import Foundation

class RefeicaoDao {
    
    func save(_ refeicoes: [Refeicao]) {
        guard let caminho = recuperaCaminhoURL() else {
            return
        }
        
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: refeicoes, requiringSecureCoding: false)
            try dados.write(to: caminho)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recupera() -> [Refeicao] {
        guard let caminho = recuperaCaminhoURL() else {
            return []
        }
        
        do {
            let dadosRetorno = try Data(contentsOf: caminho)
            guard let refeicoesSalvas = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dadosRetorno) as? Array<Refeicao> else {
                return []
            }
        
            return refeicoesSalvas
            } catch {
                print(error.localizedDescription)
                return []
        }
    }
    
    func recuperaCaminhoURL() -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let caminho = diretorio.appendingPathComponent("refeicao")
        return caminho
    }
}
