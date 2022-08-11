//
//  Tarefa.swift
//  sBrain
//
//  Created by Fábio Silva  on 08/08/2022.
//

import Foundation

struct Tarefa: Codable {
    
    var descricao: String
    var importancia: String
    var dataCriacao: TimeInterval
    var dataEvento: String?
    var horaEvento: String?
    
    static var tarefas: [Tarefa] = []
    static var tarefasC: [Tarefa] = []
}



