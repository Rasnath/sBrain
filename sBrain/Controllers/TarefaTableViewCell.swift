//
//  TarefaTableViewCell.swift
//  sBrain
//
//  Created by Fábio Silva  on 08/08/2022.
//

import UIKit

class TarefaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tarefaLabel: UILabel!
    @IBOutlet weak var horaEventoLabel: UILabel!
    @IBOutlet weak var butaoConcluida: UIButton!
    @IBOutlet weak var tarefaBuble: UIView!
    @IBOutlet weak var dataEventoLabel: UILabel!
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // colocar os cantos redondos dependendo da altura
        tarefaBuble.layer.cornerRadius = tarefaBuble.frame.height / 5
        
        dataEventoLabel.text = ""
        horaEventoLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

