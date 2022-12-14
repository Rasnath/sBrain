//
//  SBrainViewController.swift
//  sBrain
//
//  Created by Fábio Silva  on 07/08/2022.
//

import UIKit
import IQKeyboardManagerSwift

class SBrainViewController: UIViewController {
    
    @IBOutlet weak var novaTarefaTF: UITextField!
    @IBOutlet weak var tarefasTableView: UITableView!
    
    private var saveAndLoad = SaveAndLoad()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveAndLoad.loadTarefas()
        tarefasTableView.dataSource = self
        tarefasTableView.delegate = self
        tarefasTableView.dragDelegate = self
        tarefasTableView.dragInteractionEnabled = true
        novaTarefaTF.delegate = self
        // registar a custom table view
        tarefasTableView.register(UINib(nibName: K.cellNib, bundle: nil), forCellReuseIdentifier: K.nomeCelula)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        saveAndLoad.loadTarefas()
        tarefasTableView.reloadData()
    }
    
    @IBAction func adicionarP(_ sender: UIButton) {
        // Quando o butao e precionado dicionar nova tarefa ao array se nao tiver vazio, colocar o campo vazio e atualizar a tabela
        if novaTarefaTF.text == ""{
            novaTarefaTF.placeholder = "Qual é a nova tarefa?"
        }
        novaTarefaTF.endEditing(true)
    }
    
}

//MARK: - UITableViewDataSource Config da tabela

extension SBrainViewController: UITableViewDataSource{
    // numero de linhas, igual ao numero de elementos no array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saveAndLoad.tarefas.count
    }
    
    // chamdo para cada linha da tabela para criar uma nova celula onde o indexPath e a celula a ser criada no momento
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // carregar a constante com a tarefa que é para utilizar naquela celula
        let tarefa = saveAndLoad.tarefas[indexPath.row]
        
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
        
        // criar um tag para o buttao com a linha onde o butao foi tocado e chamar a funcao a baixo
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
        sender.setImage((UIImage(systemName: "circle")), for: .normal)
        saveAndLoad.tarefasC.insert(saveAndLoad.tarefas[indexPathRow], at: 0)
        saveAndLoad.tarefas.remove(at: indexPathRow)
        saveAndLoad.saveItems()
        tarefasTableView.reloadData()
    }
}

//MARK: - UITableViewDelegate Quando as celulas sao editadas

extension SBrainViewController: UITableViewDelegate{
    
    // As celulas podem ser editadas
    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Apagar a celula quando swipe left
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            saveAndLoad.tarefas.remove(at: indexPath.row)
            saveAndLoad.saveItems()
            tarefasTableView.reloadData()
        }
    }
    
    // Quando a celulla e selecionada efectuar o segueway para a edicao dos dados
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tarefasTableView.cellForRow(at: indexPath)
        tarefasTableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: K.Segue.brainToMassa, sender: cell)
    }
    
    // enviar os dados necessarios para a view controller de edicao
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.brainToMassa {
            if let cell = sender as? TarefaTableViewCell {
                let destinationVC = segue.destination as! MassaViewController
                destinationVC.tarefaM = cell.tarefaLabel.text ?? "nada"
                if let data = cell.dataEventoLabel.text, let hora = cell.horaEventoLabel.text{
                    destinationVC.dataM = data
                    destinationVC.horaM = hora
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movido = saveAndLoad.tarefas[sourceIndexPath.row]
        saveAndLoad.tarefas.remove(at: sourceIndexPath.row)
        saveAndLoad.tarefas.insert(movido, at: destinationIndexPath.row)
        self.tarefasTableView.reloadData()
    }
}

//MARK: - UITableViewDragDelegate

extension SBrainViewController: UITableViewDragDelegate{
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = saveAndLoad.tarefas[indexPath.row]
        saveAndLoad.saveItems()
        return [ dragItem ]
    }
}

//MARK: - UITextFieldDelegate

extension SBrainViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        novaTarefaTF.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if novaTarefaTF.text == ""{
            novaTarefaTF.placeholder = "Qual é a nova tarefa?"
            
        }else if let novaTarefa = novaTarefaTF.text{
            saveAndLoad.tarefas.append(Tarefa(descricao: novaTarefa, importancia: "Normal"))
        }
        novaTarefaTF.text = ""
        saveAndLoad.saveItems()
        tarefasTableView.reloadData()
    }
}



