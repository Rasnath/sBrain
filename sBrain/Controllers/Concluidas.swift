//
//  SBrainViewController.swift
//  sBrain
//
//  Created by Fábio Silva  on 07/08/2022.
//

import UIKit

class Concluidas: UIViewController {

  
    @IBOutlet weak var tarefasTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tarefasTableView.dataSource = self
        tarefasTableView.delegate = self
        // registar a custom table view
        tarefasTableView.register(UINib(nibName: K.cellNib, bundle: nil), forCellReuseIdentifier: K.nomeCelula)
    }
}

//MARK: - UITableViewDataSource Config da tabela

extension Concluidas: UITableViewDataSource{
    // numero de linhas, igual ao numero de elementos no array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Tarefa.tarefasC.count
    }
    
    // chamdo para cada linha da tabela para criar uma nova celula onde o indexPath e a celula a ser criada no momento
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // carregar a constante com a tarefa que é para utilizar naquela celula
        let tarefa = Tarefa.tarefasC[indexPath.row]
        
        // carregar na constante cell a celula costumizada
        let cell = tarefasTableView.dequeueReusableCell(withIdentifier: K.nomeCelula, for: indexPath) as! TarefaTableViewCell
        
        // escolher o que fica no conteudo da celula, data e hora se existir e a descricao
        cell.tarefaLabel.text = tarefa.descricao
        if let hora = tarefa.horaEvento{
            cell.horaEventoLabel.text = String(hora)
        }
        if let data = tarefa.dataEvento{
            cell.dataEventoLabel.text = String(data)
        }
        
        // colocar o botao com a imagem correta de concluida
        cell.butaoConcluida.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        
        // criar um tag para o botao com a linha onde o butao foi tocado e chamar a funcao a baixo
        cell.butaoConcluida.tag = indexPath.row
        cell.butaoConcluida.addTarget(self, action: #selector(SBrainViewController.tarefaConcluida(sender:)), for: UIControl.Event.touchUpInside)
        
        // verificar se tem data e hora do evento caso contrario esconder o label
        if tarefa.dataEvento == nil && tarefa.horaEvento == nil{
            cell.dataEventoLabel.isHidden = true
            cell.horaEventoLabel.isHidden = true
            return cell
        }else if tarefa.dataEvento != nil && tarefa.horaEvento == nil{
            cell.dataEventoLabel.isHidden = false
            cell.horaEventoLabel.isHidden = true
            return cell
        }else{
            cell.dataEventoLabel.isHidden = false
            cell.horaEventoLabel.isHidden = false
            return cell
        }
    }
    
    // funcao chamada quando o botao de tarefa concluida e precionado usando o tag
    @objc func tarefaConcluida(sender: UIButton) {
        let indexPathRow = sender.tag
        sender.isSelected = true
        sender.setImage((UIImage(systemName: "circle")), for: .normal)
        Tarefa.tarefas.append(Tarefa.tarefasC[indexPathRow])
        Tarefa.tarefasC.remove(at: indexPathRow)
        tarefasTableView.reloadData()
    }
}

//MARK: - UITableViewDelegate Quando as celulas sao editadas

extension Concluidas: UITableViewDelegate{

    // As celulas podem ser editadas
    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Apagar a celula quando swipe left
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          Tarefa.tarefasC.remove(at: indexPath.row)
          tarefasTableView.reloadData()
      }
    }
}

