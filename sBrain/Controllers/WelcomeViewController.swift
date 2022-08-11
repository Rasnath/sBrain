//
//  ViewController.swift
//  sBrain
//
//  Created by Fábio Silva  on 07/08/2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var nomeApp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        nomeApp.text = ""
        var index = 0.0
        let tituloLabel = K.appName
        for letra in tituloLabel{
            Timer.scheduledTimer(withTimeInterval: 0.1 * index, repeats: false) { timer in
                self.nomeApp.text?.append(letra)
            }
            index += 1
        }
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            self.performSegue(withIdentifier: K.Segue.welcomeToBrain, sender: self)
        }
    }
}

