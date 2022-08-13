//
//  MassaViewController.swift
//  sBrain
//
//  Created by Fábio Silva  on 07/08/2022.
//

import UIKit

class MassaViewController: UIViewController {
    
    let saveAndLoad = SaveAndLoad()
    
    @IBOutlet weak var tarefaLabel: UITextField!
    @IBOutlet weak var dataLabel: UITextField!
    @IBOutlet weak var horaLabel: UITextField!
    
    // para receber os dados do outro VC
    var tarefaM = ""
    var dataM = ""
    var horaM = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colocar os dados nos respetivos label
        tarefaLabel.text = tarefaM
        dataLabel.text = dataM
        horaLabel.text = horaM
        
        // Criar o picker para a data e hora
        let dataPicker = UIDatePicker()
        dataPicker.datePickerMode = .dateAndTime
        dataPicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        dataPicker.frame.size = CGSize(width: 0, height: 300)
        dataPicker.preferredDatePickerStyle = .wheels
        dataPicker.minimumDate = Date()
        dataLabel.inputView = dataPicker
        horaLabel.inputView = dataPicker
        
    }
    
    // func chamada sempre que o dataPicker criado for alterado e atualizar o campo de texto
    @objc func dateChange (datePicker: UIDatePicker){
        dataLabel.text = formatData(data: datePicker.date)
        horaLabel.text = formatHora(data: datePicker.date)
    }
    
    // formatar os dados recebidos para serem apresentados
    func formatData(data: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM"
        return formatter.string(from: data)
    }
    func formatHora(data: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: data)
    }
    
    @IBAction func upDate(_ sender: UIButton) {
        // Carregar data e hora para o array
        if let data = dataLabel.text, let hora = horaLabel.text{
                dataM = data
                horaM = hora
        }
        
        // carregar os dados alterados no array das tarefas
        if let row = Tarefa.tarefas.firstIndex(where: {$0.descricao == tarefaM}) {
            if tarefaLabel.text != ""{
                Tarefa.tarefas[row].descricao = tarefaLabel.text!
                Tarefa.tarefas[row].dataEvento = dataM
                Tarefa.tarefas[row].horaEvento = horaM
                saveAndLoad.saveItems()
                performSegue(withIdentifier: K.Segue.MassatoBrain, sender: self)
            }else{
                Tarefa.tarefas.remove(at: row)
                saveAndLoad.saveItems()
                performSegue(withIdentifier: K.Segue.MassatoBrain, sender: self)
            }
        }
    }
    
    // ir para traz sem fazer alteracoes
    @IBAction func backButtonP(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.Segue.MassatoBrain, sender: self)
    }
}
