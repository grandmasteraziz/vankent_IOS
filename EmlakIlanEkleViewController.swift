//
//  EmlakIlanEkleViewController.swift
//  vankentrehberi
//
//  Created by Aziz on 16/08/2017.
//  Copyright © 2017 koddata. All rights reserved.
//

import UIKit
import CoreData
import Photos
import BSImagePicker
import Alamofire

class EmlakIlanEkleViewController: UIViewController , UINavigationControllerDelegate , UIImagePickerControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate  {

    // çoklu foto
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var kategoriTxt: UITextField!
    
    @IBOutlet weak var dropDown: UIPickerView!
    
    @IBOutlet weak var fotoSecBtn: UIButton!
    
    //kapakFoto
    @IBOutlet weak var kapakFotoBtn: UIButton!
    
    @IBOutlet weak var kapakFotoImg: UIImageView!
    
    
    @IBOutlet weak var kaydetBtn: UIButton!
    
    
    @IBOutlet weak var ilanAdiTxt: UITextField!
    
    @IBOutlet weak var ilanAciklamaTxt: UITextField!
    
    @IBOutlet weak var ilanFiyatTxt: UITextField!
    
    @IBOutlet weak var ilanTelefonTxt: UITextField!
    
    
    
    var kategoriID :Int?
    
    
    var selectedAssets = [PHAsset]()
    var photoArray = [UIImage]()
    
    
    // this is my categories
    var categories = [
        7 : "Kiralık",
        8 : "Satılık",
        9 : "Apart"
    ]
    
    
    
    //picker View 
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
        self.dropDown.isHidden = true
        
        let ckey = Array(categories.keys)[row]
        //  print("key : \(ckey)")
        self.kategoriID = ckey
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.kategoriTxt
        {
            self.dropDown.isHidden = false
        }
    }
 
    
    
    
    // Fotoğraf Seç multiple photo
    @IBAction func addImageClicked(_ sender: Any) {
        
        self.photoArray.removeAll()
        self.selectedAssets.removeAll()
        
        let vc = BSImagePickerViewController()
        
        bs_presentImagePickerController(vc, animated: true,
                                        select: { (assets: PHAsset) -> Void in
                                            // User selected an asset.
                                            // Do something with it, start upload perhaps?
        }, deselect: { (assets: PHAsset) -> Void in
            // User deselected an assets.
            // Do something, cancel upload?
        }, cancel: { (assets: [PHAsset]) -> Void in
            // User cancelled. And this where the assets currently selected.
        }, finish: { (assets: [PHAsset]) -> Void in
            // User finished with these assets
            
            for i in 0..<assets.count
            {
                    self.selectedAssets.append(assets[i])
            }
            
            self.convertAssetToImages()
            
            
        }, completion: nil)
    }
    
    
     // this one multiple
    
    func convertAssetToImages() -> Void {
        
        if selectedAssets.count != 0 {
            
                for  z in 0..<selectedAssets.count
                {
                    let manager = PHImageManager.default()
                    let option = PHImageRequestOptions()
                    var thumbnail = UIImage()
                    option.isSynchronous = true
                    
                    
                    
                    
                    manager.requestImage(for: selectedAssets[z], targetSize: CGSize(width: 200, height: 200) , contentMode: .aspectFill, options: option, resultHandler: { (result, info)->Void in
                        thumbnail = result!
                    })
                    
                    
                    let data = UIImageJPEGRepresentation(thumbnail, 0.7)
                    let newImage = UIImage(data: data!)
                    
                    self.photoArray.append(newImage! as UIImage)
                    
                    
                }
            
            
                self.imgView.animationImages = self.photoArray
                self.imgView.animationDuration = 3.0
                self.imgView.startAnimating()
        }
        
        print("complete photo array \(self.photoArray)")
        
        
        
    }
    
    
    
    
    
    //Kapak Foto Ekle  this one : single photo
    
    @IBAction func kapakFotoEkle(_ sender: Any) {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = .photoLibrary
        
        
        self.present(myPickerController, animated: true, completion: nil )
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
      
        kapakFotoImg.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fotoSecBtn.layer.cornerRadius = 12
        fotoSecBtn.layer.borderWidth = 1
        fotoSecBtn.layer.borderColor = UIColor.blue.cgColor
        
        
        kapakFotoBtn.layer.cornerRadius = 2
        
        kaydetBtn.layer.cornerRadius = 2
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated. bi dk
    }
    
    
    //Kaydet Butonu
    @IBAction func kaydet(_ sender: Any) {
        
        print("sunucuya gönderildi")
    
       
        let url = "http://vankent.net/van_kent/web/api/emlak/ekleIos"
        
        let parameters =  [
            "adi" : self.ilanAdiTxt.text!,
            "aciklama" : self.ilanAciklamaTxt.text!,
            "fiyat" : self.ilanFiyatTxt.text!,
            "kategori" :  String(kategoriID!) ,
            "usrtel" : self.ilanTelefonTxt.text!,
            "uye_id" :   String(getUserId())
           
        ] as [String : String]
        
        
       Alamofire.upload(multipartFormData: { (multipartFormData) in
            
         // album
         for (image) in  self.photoArray
         {
              if  let imageData = UIImageJPEGRepresentation(image, 0.2)
              {
                   // TODO: Change format to "ilanId_foto_fotoNo_timestamp.jpeg"
                  // unique name format: userId_foto_timestamp.jpeg
                  let timestamp = NSDate().timeIntervalSince1970
                  let foto_name = String(self.getUserId())
                                  + "_foto_"
                                  + String(timestamp).replacingOccurrences(of: ".", with: "")
                  // append
                multipartFormData.append(imageData, withName: "foto[]",  fileName: "\(foto_name).jpeg", mimeType: "image/jpeg")
         
               }
         
           }
        
        // kapak
        //unique name format: userId_kapak_timestamp.jpeg
        let timestamp = NSDate().timeIntervalSince1970
        let kapak_name = String(self.getUserId())
            + "_kapak_"
            + String(timestamp).replacingOccurrences(of: ".", with: "")
        //append
        multipartFormData.append(UIImageJPEGRepresentation(self.kapakFotoImg.image!, 1)!, withName: "kapakFoto", fileName: "\(kapak_name).jpeg", mimeType: "image/jpeg")
        
        // parameters
         for (key, value) in parameters {
                 if value is String || value is Int {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }}
        },
                         to:"http://vankent.net/van_kent/web/api/emlak/ekleIos",
                         encodingCompletion: { (result) in
                            switch result {
                            case .success(let upload, _, _):
                                
                                upload.uploadProgress(closure: { (progress) in
                                    //Print progress
                                })
                                
                                upload.responseJSON { response in
                                    print( response.result)
                                    print(response.value)
                                }
                                
                            case .failure(let encodingError):
                                 print(encodingError)
                            }
        })
        
    }
    
 
    
    
    
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

    /*
     
     func sendData()
     {
     
     let myUrl = URL(string: "http://vankent.net/van_kent/web/api/emlak/ekle")
     
     var request = URLRequest(url: myUrl!)
     
     request.httpMethod = "POST"
     
     
     let parameter = [
     "adi" : self.ilanAdiTxt.text!,
     "aciklama" : self.ilanAciklamaTxt.text!,
     "fiyat" : self.ilanFiyatTxt.text!,
     "kategori" : kategoriID!,
     "usrtel" : self.ilanTelefonTxt.text!,
     "uye_id" : getUserId()
     
     
     ] as [String : Any]
     
     
     
     //boundary gelecek
     
     let boundary = generateBoundaryString()
     
     
     request.setValue("multipart/form-data; bounday = \(boundary)" ,forHTTPHeaderField: "Content-Type")
     
     let imageData = UIImageJPEGRepresentation(kapakFotoImg.image!,1)
     
     if  imageData==nil{
     
     createAlert(titleText: "Boş Alan", messageText: "Kapak Fotoğrafını Seçiniz")
     
     return;
     }
     
     
     //  request.httpBody =
     
     
     
     
     
     
     }
     */
    
}
