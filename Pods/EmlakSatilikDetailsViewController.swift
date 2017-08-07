//
//  EmlakSatilikDetailsViewController.swift
//  vankentrehberi
//
//  Created by Aziz on 31/07/2017.
//  Copyright © 2017 koddata. All rights reserved.
//

import UIKit
import SDWebImage
import EFInternetIndicator

class EmlakSatilikDetailsViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate ,InternetStatusIndicable {
    
    //Ef Internet control lib
    var internetConnectionIndicator: InternetViewIndicator?
    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var adiLbl: UILabel!
    
    
    @IBOutlet weak var aciklamaLbl: UILabel!
    
    @IBOutlet weak var fiyatLbl: UILabel!
    
    @IBOutlet weak var telefonLbl: UILabel!
    
    var getAdi = String()
    var getFiyat = String()
    var getAciklama = String()
    var getTelefon = String()
    var getPhotos = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //check internet connection
        self.startMonitoringInternet(backgroundColor:UIColor.black, style: .CardView , textColor:UIColor.white, message:"Oops...\nInternet Bağlantınızı Kontrol edin!", remoteHostName: "vankent.net")
        
        adiLbl.text! = getAdi
        fiyatLbl.text! = getFiyat
        aciklamaLbl.text! = getAciklama
        telefonLbl.text! = getTelefon
        
      /*  DispatchQueue.main.async {
            self.photo.image = self.getPhotos as? UIImage
        }
        */
        
       // print("********** Photos")
        
         print(getPhotos)
      //  print("**********")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   
      
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return getPhotos.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! EmlakSatilikDetailsCollectionViewCell
       
       
        
        cell.photo.image = UIImage(named: "http://vankent.net/van_kent/web/uploads/brochures/\(getPhotos[indexPath.row])")
        
            

        return cell
    }
    

}
