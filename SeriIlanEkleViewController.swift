//
//  SeriIlanEkleViewController.swift
//  vankentrehberi
//
//  Created by Aziz on 03/08/2017.
//  Copyright © 2017 koddata. All rights reserved.
//

import UIKit
import CoreData

class SeriIlanEkleViewController: UIViewController , UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate {
    

    @IBOutlet weak var ilanTelefonTxt: UITextField!
    @IBOutlet weak var ilanAdiLbl: UITextField!
    //dropdown textfield
    @IBOutlet weak var ilanAciklamaLbl: UITextField!
    @IBOutlet weak var kategoriTxt: UITextField!
    
    
    @IBOutlet weak var ekleBtn: UIButton!
    //pickerView
    @IBOutlet weak var dropdown: UIPickerView!
  
    var kategoriID :String?
    var uuid = getUserId
    
    
    
    var categories = [
            10 : "İş Arıyorum",
            11 : "İş Veriyorum",
            12 : "Ev Arkadaşı Arıyorum"
        ]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
       return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        //
        return Array(categories.values)[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
                self.kategoriTxt.text = Array(categories.values)[row]
                self.dropdown.isHidden = true
        
                let ckey = Array(categories.keys)[row]
              //  print("key : \(ckey)")
               // self.kategoriID = ckey
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            if textField == self.kategoriTxt
            {
               self.dropdown.isHidden = false
            }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //ekleBtn.layer.cornerRadius = 10

        
        
        ilanAdiLbl.layer.cornerRadius = 10
    
     /*   print("************View Did Load*****")
            print(getUserId())
        print("************View Did Load*****") */
        
      
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Buton
    @IBAction func ilanEkle(_ sender: Any) {
        
     
        
        
        let urlString : String = "http://vankent.net/van_kent/web/api/seri/iosekle"
        
        
        addClassFiedAds(urlString : urlString)
        
    }
    



    
    
    
    func addClassFiedAds(urlString : String)
    {
   
        let urlRequest = URL(string : urlString)
        var myRequest = URLRequest(url: urlRequest! as URL)
        
        myRequest.httpMethod = "POST"
        
        
        let kategoriId = self.kategoriID
        let adi = ilanAdiLbl.text
        let aciklama = ilanAciklamaLbl.text
        let telefon = ilanTelefonTxt.text
        let uyeID = self.uuid
        let deneme = 2
      
        let parameters = "adi=\(adi!)&aciklama=\(aciklama!)&kategori=\(kategoriId))&usrtel=\(telefon!)&uyeID=\(uyeID)"
        myRequest.httpBody = parameters.data(using :String.Encoding.utf8)
        
  
        
 
        //Boş alan varsa
        if( (adi?.isEmpty)! || (aciklama?.isEmpty)! )
        {
            
            print("boş alan bırakmayınız")
            self.createAlert(titleText: "Boş Alan Bırakmayınız", messageText: "Tüm alanları eksiksiz ve doğru şekilde doldurunuz!")
            
        }
        
        let task = URLSession.shared.dataTask(with: myRequest as URLRequest) { (data, response, error) in
           
                if error != nil
                {
                    print(error!)
                    
                }else{
                    
                    do{
                    
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                       //	 print(json!)
                        
                    }
                    catch{
                        print(error)
                        
                    }
                    
                }
            
            
        }
        task.resume()
        
    }//
    
    
    func getUserId() ->Int
    {
        
        var userID : Int?
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        request.fetchLimit = 1
        
        do{
            
            let results = try context.fetch(request)
            
            if results.count > 0
            {
                for result in results as! [NSManagedObject]
                {
                    if let userid = result.value(forKey: "uid") as? Int
                    {
                       // print(userid)
                        userID = userid
                    }
                }
            }
            
            
            
        }catch{
            
            print(error)
        }
       
      
        
        return userID!;
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