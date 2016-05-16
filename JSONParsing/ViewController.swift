//
//  ViewController.swift
//  JSONParsing
//
//  Created by Horacio Garza on 13/05/16.
//  Copyright © 2016 Horacio Garza. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addGestureRecognizer(tapGesture)
        textField.delegate = self
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.performSegueWithIdentifier("giveISBN", sender: self)
        
        return true;
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "giveISBN" {
            
            let isbn:String? = textField.text!
            print(isbn!)
            let destination = segue.destinationViewController as! JSONViewController
            destination.completeLink = isbn!;
            
        }
    }
    

    @IBAction func DismissKeyboard(sender: UITapGestureRecognizer) {
        self.view.endEditing(true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    

}

