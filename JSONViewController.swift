//
//  JSONViewController.swift
//  JSONParsing
//
//  Created by Horacio Garza on 14/05/16.
//  Copyright © 2016 Horacio Garza. All rights reserved.
//

import UIKit

class JSONViewController: UIViewController {

    var completeLink:String? = ""
    
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var jsonText: UILabel!
    @IBOutlet weak var cover: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Link: \(completeLink!)")
        asincrono()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func asincrono(){
        
        if completeLink != nil{
            
            
            let url:NSURL = NSURL(string: "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(completeLink!)")!
            let urlSession:NSURLSession = NSURLSession.sharedSession()

            
            let bloque = { (datos : NSData?, resp: NSURLResponse?,error:NSError?)-> Void in let texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)
                
                
                if error?.code>=400 && error?.code<500 {
                    
                    self.jsonText.text = "Error, bad connection"
                    
                }else if error?.code == nil{
                    
                    do{
                        let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                        
                        if json.count != 0 {
                            
                            let dico1 = json["ISBN:\(self.completeLink!)"] as! NSDictionary
                            let dico2 = dico1["authors"] as! Array<NSDictionary>
                            
                            
                            var authorsToPrint = ""
                            var i:Int = 0
                            
                            for dictionarioAutor in dico2{
                                if i != 0 {
                                    authorsToPrint += ", "
                                }
                                authorsToPrint += dictionarioAutor["name"] as! NSString as String
                                i += 1
                            }
                            
                            
                            if let val = json["cover"] {
                                if let x = val {
                                    print(x)
                                } else {
                                    print("value is nil")
                                }
                            } else {
                                print("key is not present in dict")
                            }
                            
                            
                            dispatch_sync (dispatch_get_main_queue(), {
                                self.jsonText.text = dico1["title"] as! NSString as String
                                self.author.text = authorsToPrint
                            })
                        }
                        else{
                            self.jsonText.text = "Libro no existe"
                            self.author.text = "Libro no existe"
                        }
                        
                        
                        
                    }
                    catch _ {
                        
                        
                    }
                    
                    print("Datos obtenidos: \n\n\(self.jsonText.text!)")
                    
                    
                }
                
                
                print(texto!)
            }
            let dt = urlSession.dataTaskWithURL(url, completionHandler: bloque)
                
                
                
            dt.resume()
            
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
