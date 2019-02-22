//
//  ViewController.swift
//  Chat
//
//  Created by Masato Hayakawa on 2019/02/18.
//  Copyright © 2019 masappe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var IDTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let value = IDTextField.text{
            let chatViewController = segue.destination as! ChatViewController
            chatViewController.id = value
        }
    }


}

