//
//  SaveAndLoad.swift
//  sBrain
//
//  Created by Fábio Silva  on 13/08/2022.
//

import Foundation

struct SaveAndLoad{
    
    var tarefas = [Tarefa]()
    var tarefasC = [Tarefa]()
    
    // criar um caminho para guardar e buscar os dados
    private let caminhoDoFicheiro = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(K.ficheiroGuardado)
    private let caminhoDoFicheiroC = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(K.ficheiroGuardadoC)
    
    func saveItems()  {
        // criar um encoder
        let encoder = PropertyListEncoder()
        // encode de item array
        do{
            let data = try encoder.encode(tarefas)
            let dataC = try encoder.encode(tarefasC)
            // colocar a data no caminho
            try data.write(to: self.caminhoDoFicheiro!)
            try dataC.write(to: self.caminhoDoFicheiroC!)
        }catch{
            print("error encoding\(error)")
        }
    }
    
    mutating func loadTarefas() {
        //verificar se tem daddos no caminho e guardar esses dados no data
        if let data =  try? Data(contentsOf: caminhoDoFicheiro!), let dataC = try? Data(contentsOf: caminhoDoFicheiroC!){
            // descodificar os dados
            let decoder = PropertyListDecoder()
            do{
                // colocalos no array
                tarefas = try decoder.decode([Tarefa].self, from: data)
                tarefasC = try decoder.decode([Tarefa].self, from: dataC)
            }catch{
                print("error decoding\(error)")
            }
        }
    }
}
