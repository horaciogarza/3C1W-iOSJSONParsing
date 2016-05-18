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
    let link:String = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
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
        
        if completeLink != nil && Reacheability.isConnectedToNetwork(){
            
            
            let url:NSURL = NSURL(string: "\(link)\(completeLink!)")!
            let urlSession:NSURLSession = NSURLSession.sharedSession()
            
            
            let bloque = { (datos : NSData?, resp: NSURLResponse?,error:NSError?)-> Void in _ = NSString(data: datos!, encoding: NSUTF8StringEncoding)
                
                
                /*if error?.code>=400 && error?.code<500 {
                 
                 self.jsonText.text = "Error, bad connection"
                 
                 }else if error?.code == nil
                 {*/
                
                if error == nil {
                    do{
                        let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                        let dict = json as! NSDictionary
                        let infoDict: NSDictionary? = dict["ISBN:\(self.completeLink!)"] as? NSDictionary
                        
                        if infoDict != nil {
                            let bookName = infoDict!["title"] as! NSString as String
                            let authors = infoDict!["authors"] as! NSArray
                            var authorsNames = ""
                            for author in authors{
                                if(!authorsNames.isEmpty){
                                    authorsNames += ", "
                                }
                                authorsNames += author["name"] as! NSString as String
                            }
                            
                            
                            var imageData : NSData? = nil
                            let coverDict : NSDictionary? = infoDict!["cover"] as? NSDictionary
                            if((coverDict) != nil){
                                let imgURL : String? = coverDict!["medium"] as! NSString as String
                                if((imgURL) != nil){
                                    let urlImage : NSURL? = NSURL(string: imgURL!)
                                    imageData = NSData(contentsOfURL: urlImage!)
                                }
                            }
                            
                            dispatch_async(dispatch_get_main_queue()){
                                self.jsonText.text = bookName
                                self.author.text = authorsNames
                                if (imageData != nil) {
                                    self.cover.image = UIImage(data: imageData!)
                                }
                            }
                        }
                        
                    }
                    catch _ {
                        
                    }
                    
                }else{
                    if Reacheability.isConnectedToNetwork() {
                        self.showError(NSLocalizedString("Verifica los datos que ingresaste anteriormente", comment: "Hubo un error inesperado"))
                    }else{
                        self.showError(NSLocalizedString("Verifica tu conexión", comment: "Hubo un error inesperado"))
                        
                    }
                }
                
            }
            let dt = urlSession.dataTaskWithURL(url, completionHandler: bloque)
            dt.resume()
            
        }else{
            self.showError(NSLocalizedString("", comment: "Hubo un error con la conexión, asegúrate de estar conectado a Internet"))
        }
        
        
    }
    
    func showError(errorMessage:String){
        
        let alertController = UIAlertController(title: NSLocalizedString("Error de Conexión", comment: "Error"), message:errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("error_close", comment: "Cerrar"), style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
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
