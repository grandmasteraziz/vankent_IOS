//
//  KaydolViewController.swift
//  vankentrehberi
//
//  Created by Aziz on 25/07/2017.
//  Copyright © 2017 koddata. All rights reserved.
//

import UIKit
import EFInternetIndicator
import CoreData

class KaydolViewController: UIViewController , InternetStatusIndicable {

    //EFInternetIndicator Lib
    var internetConnectionIndicator:InternetViewIndicator?
    
    
    @IBOutlet weak var userNameField: UITextField!
 
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passField: UITextField!
    
    @IBOutlet weak var passAgainField: UITextField!
    
    @IBOutlet weak var kaydolBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            //check internet connection
            self.startMonitoringInternet(backgroundColor:UIColor.black, style: .CardView , textColor:UIColor.white, message:"Oops...\nInternet Bağlantınızı Kontrol edin!", remoteHostName: "vankent.net")
        
        
            //Radius button
            kaydolBtn.layer.cornerRadius = 10
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func kaydolBtn(_ sender: Any) {
        registerUser(urlString: "http://vankent.net/van_kent/web/api/user/createios")
    }
    
    
    //Üye Kayıt
    func registerUser(urlString : String)
    {
        let urlRequest = URL(string: urlString)
        var request = URLRequest(url: urlRequest! as URL)
        
         request.httpMethod = "POST"
        
        
        let name : String = userNameField.text!
        let mail : String = emailField.text!
        let pass : String = passField.text!
        let passAgain : String = passAgainField.text!
        
        
        // boş alan yoksa
        if ((!name.isEmpty) || (!mail.isEmpty) || (!pass.isEmpty) || (!passAgain.isEmpty) ) {
            
                if mail.isValidEmail()
                {
                    //maili gönder
                    if pass == passAgain {
                        //gönderme işlemini buradan yap
                        
                        //kadi mail sifre
                        let parameters = "kadi="+name+"&mail="+mail+"&sifre="+pass
                        
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
                                        var message : Int!
                                        var status : String!
                                        
                                        message = parseJson["mesaj"] as! Int?
                                        status = parseJson["durum"] as! String?
                                        
                                        if status == "Basarili"
                                        {
                                            print(message)
                                            
                                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                            let context = appDelegate.persistentContainer.viewContext
                                            let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
                                            
                                            // user instance
                                            newUser.setValue(mail, forKey: "mail")
                                            newUser.setValue(name, forKey: "name")
                                            newUser.setValue(message, forKey: "uid")
                                            
                                            do{
                                                try context.save()
                                                print("local db ye kaydedildi")
                                                
                                            
                                                
                                                DispatchQueue.main.async {
                                                    
                                                    self.userNameField.text = nil
                                                    self.emailField.text = nil
                                                    self.passField.text = nil
                                                    self.passAgainField.text = nil
                                                    
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
                        if pass == nil || passAgain == nil {
                                         self.createAlert(titleText: "Şifreler Boş Geçilmez", messageText: "Lüfen şifre ve şifre tekrar alanlarını boş bırakmayınız!")
                        }
                        print("şifreler eşleşmiyor")
                        self.createAlert(titleText: "Şifreler Eşleşmiyor", messageText: "Lüfen şifre ve şifre tekrar alanlarına aynı değerleri giriniz!")
                    }
                }else{
                    
                   print("mail formatı düzgün değil")
                    self.createAlert(titleText: "Geçersiz Mail Adresi", messageText: "Lütfen geçerli bir mail adresi girin!")
            }
        
            
            
        }else{
            print("boş alan bırakmayınız")
            self.createAlert(titleText: "Boş Alan Bırakmayınız", messageText: "Tüm alanları eksiksiz ve doğru şekilde doldurunuz!")
        }
        
        
    }
    
    func createAlert(titleText : String , messageText : String)
    {
            let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Kapat" , style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    


}
