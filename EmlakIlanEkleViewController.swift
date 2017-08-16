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

class EmlakIlanEkleViewController: UIViewController , UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate  {

    // çoklu foto
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var kategoriTxt: UITextField!
    
    @IBOutlet weak var dropDown: UIPickerView!
    
    @IBOutlet weak var fotoSecBtn: UIButton!
    
    var kategoriID :Int?
    var uuid = getUserId
    
    var selectedAssets = [PHAsset]()
    var photoArray = [UIImage]()
    
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
 
    
    
    
    // Fotoğraf Seç
    @IBAction func addImageClicked(_ sender: Any) {
        
        let vc = BSImagePickerViewController()
        
        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                            // User selected an asset.
                                            // Do something with it, start upload perhaps?
        }, deselect: { (asset: PHAsset) -> Void in
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
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fotoSecBtn.layer.cornerRadius = 5
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

}
