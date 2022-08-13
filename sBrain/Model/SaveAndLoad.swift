//
//  SaveAndLoad.swift
//  sBrain
//
//  Created by Fábio Silva  on 13/08/2022.
//

import Foundation

struct SaveAndLoad{
    // criar um caminho para guardar e buscar os dados
    let caminhoDoFicheiro = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(K.ficheiroGuardado)
    let caminhoDoFicheiroC = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(K.ficheiroGuardadoC)
    
    func saveItems()  {
        // criar um encoder
        let encoder = PropertyListEncoder()
        // encode de item array
        do{
            let data = try encoder.encode(Tarefa.tarefas)
            // colocar a data no caminho
            try data.write(to: self.caminhoDoFicheiro!)
        }catch{
            print("error encoding\(error)")
        }
    }
    
    func saveItemsC()  {
        // criar um encoder
        let encoder = PropertyListEncoder()
        // encode de item array
        do{
            let data = try encoder.encode(Tarefa.tarefasC)
            // colocar a data no caminho
            try data.write(to: self.caminhoDoFicheiroC!)
        }catch{
            print("error encoding\(error)")
        }
    }
    

    func loadTarefas() {
        //verificar se tem daddos no caminho e guardar esses dados no data
        if let data =  try? Data(contentsOf: caminhoDoFicheiro!){
            // descodificar os dados
            let decoder = PropertyListDecoder()
            do{
                // colocalos no array
                Tarefa.tarefas = try decoder.decode([Tarefa].self, from: data)
            }catch{
                print("error decoding\(error)")
            }
        }
    }
    
    func loadTarefasC() {
        //verificar se tem daddos no caminho e guardar esses dados no data
        if let data =  try? Data(contentsOf: caminhoDoFicheiroC!){
            // descodificar os dados
            let decoder = PropertyListDecoder()
            do{
                // colocalos no array
                Tarefa.tarefasC = try decoder.decode([Tarefa].self, from: data)
            }catch{
                print("error decoding\(error)")
            }
        }
    }
}
