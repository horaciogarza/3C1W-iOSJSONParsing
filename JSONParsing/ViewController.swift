//
//  ViewController.swift
//  JSONParsing
//
//  Created by Horacio Garza on 13/05/16.
//  Copyright © 2016 Horacio Garza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tapGesture: UITapGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addGestureRecognizer(tapGesture)
    }

    @IBAction func DismissKeyboard(sender: UITapGestureRecognizer) {
        self.view.endEditing(true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

