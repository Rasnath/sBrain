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
    var dataCriacao = Date()
    var dataEvento: String?
    var horaEvento: String?
}
