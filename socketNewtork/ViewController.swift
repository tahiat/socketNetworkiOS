//
//  ViewController.swift
//  socketNewtork
//
//  Created by Tahiatul Islam on 11/8/24.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func sendData(_ sender: Any) {
        ConnectionManager.shared.emitData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ConnectionManager.shared.setupSocket()
    }


}

