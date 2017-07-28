//
//  GirisYapViewController.swift
//  vankentrehberi
//
//  Created by Aziz on 24/07/2017.
//  Copyright © 2017 koddata. All rights reserved.
//

import UIKit
import EFInternetIndicator
import CoreData


class GirisYapViewController: UIViewController , InternetStatusIndicable{

    //EFInternetIndicator Lib
    var internetConnectionIndicator:InternetViewIndicator?
    
   
    @IBOutlet weak var mailField: UITextField!
    
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var girisYapBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        
        //check internet connection
        self.startMonitoringInternet(backgroundColor:UIColor.black, style: .CardView , textColor:UIColor.white, message:"Oops...\nInternet Bağlantınızı Kontrol edin!", remoteHostName: "vankent.net")
        
        girisYapBtn.layer.cornerRadius = 10
        
        
  

    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
 
    @IBAction func girisYapBtn(_ sender: Any) {
        
        print("Giris yapa basıldı")
        
        loginUser(urlString: "http://vankent.net/van_kent/web/api/user/loginios")
        
     
        
    }
    
    func loginUser(urlString : String){
        let urlRequest = URL(string: urlString)
        var request = URLRequest(url: urlRequest! as URL)
        
        request.httpMethod = "POST"
        
        
        let mail : String = mailField.text!
        let pass : String = passwordField.text!
      
        
        
        // boş alan yoksa
        if (!mail.isEmpty && !pass.isEmpty) {
            
            if mail.isValidEmail()
            {
                //maili gönder
                
                    //gönderme işlemini buradan yap
                    
                    //kadi mail sifre
                    let parameters = "password="+pass+"&mail="+mail
                    
                    request.httpBody = parameters.data(using: String.Encoding.utf8)
                    
                    let task = URLSession.shared.dataTask(with: request as URLRequest){ (data, response, error) in
                        
                        if error != nil{ //hata varsa
                            print(error!)
                        }else{
                            do{
                                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                                
                                //  print(json!)
                                
                                if let parseJson = json
                                {
                                    var userId : Int!
                                    var status : String!
                                    var userMail : String!
                                    var userName : String!
                                    
                                    userId = parseJson["id"] as! Int?
                                    userMail = parseJson["mail"] as! String?
                                    userName = parseJson["name"] as! String?
                                    status = parseJson["durum"] as! String?
                                    
                                    if status == "Basarili"
                                    {
                                        print(userMail)
                                        
                                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                        let context = appDelegate.persistentContainer.viewContext
                                        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
                                        
                                        // user instance
                                        newUser.setValue(userMail, forKey: "mail")
                                        newUser.setValue(userName, forKey: "name")
                                        newUser.setValue(userId, forKey: "uid")
                                        
                                        do{
                                            try context.save()
                                            print("local db ye kaydedildi")
                                            
                                            
                                            
                                            DispatchQueue.main.async {
                                                
                                                
                                                self.mailField.text = nil
                                                self.passwordField.text = nil
                                                
                                                
                                                // Anasayfaya yönlendir
                                                let storyboard : UIStoryboard = UIStoryboard(name : "Main" , bundle : nil )
                                                let anasayfaVC = storyboard.instantiateViewController(withIdentifier: "Anasayfa") as! AnasayfaViewController
                                                
                                                self.present(anasayfaVC, animated: true, completion: nil)
                                                
                                                
                                            }
                                            
                                            
                                        }catch{
                                            print(error)
                                        }
                                        
                                        
                                        
                                    }else{
                                        print("başarısız")
                                        self.createAlert(titleText: "Hatalı istek", messageText: "Kullanıcı adı veya mail başkası tarafından kullanılıyor olabilir ")
                                    }
                                }
                                
                            }catch{
                                print(error)
                            }
                        }
                    }
                    
                    task.resume()
                    
            
            }else{
                
                print("mail formatı düzgün değil")
                self.createAlert(titleText: "Geçersiz Mail Adresi", messageText: "Lütfen geçerli bir mail adresi girin!")
            }
            
            
            
        }else{
            print("boş alan bırakmayınız")
            self.createAlert(titleText: "Boş Alan Bırakmayınız", messageText: "Tüm alanları eksiksiz ve doğru şekilde doldurunuz!")
        }
        

        
    }
    //
    
    func createAlert(titleText : String , messageText : String)
    {
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Kapat" , style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        self.present(alert, animated: true, completion: nil)
    }

   

}
