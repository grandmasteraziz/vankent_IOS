//
//  OtoKiralikListeleViewController.swift
//  vankentrehberi
//
//  Created by Aziz on 03/08/2017.
//  Copyright © 2017 koddata. All rights reserved.
//

import UIKit
import EFInternetIndicator

class OtoKiralikListeleViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , InternetStatusIndicable {
  
    @IBOutlet weak var tblView: UITableView!

    //EFInternetIndicator Lib
    var internetConnectionIndicator:InternetViewIndicator?
    
    
    var pageCount = 1
    var adlar = [String]()
    var telefonlar = [String]()
    
    
    var fotolar : [String] = []
    
    
    var aciklamalar = [String]()
    var fiyatlar = [String]()
    var kapakFoto = [String]()
    var pages = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //check internet connection
        self.startMonitoringInternet(backgroundColor:UIColor.black, style: .CardView , textColor:UIColor.white, message:"Oops...\nInternet Bağlantınızı Kontrol edin!", remoteHostName: "vankent.net")
        
        
        var urlString = "http://vankent.net/van_kent/web/api/oto/kiralik?page=" + String(pageCount)
        
        loadData(urlString: urlString)
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    public func loadData(urlString: String)
    {
        
        var url = URL(string: urlString)
        
        
        
        let task = URLSession.shared.dataTask(with: url!) {
            (data , response , error) in
            
            
            if error != nil
            {
                print(error!)
                
            }else{
                
                do{
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                    let arr = json["data"] as? NSArray
                    let metaArr = json["meta"] as? NSDictionary
                    
                    
                    if let jsonDic = arr
                    {
                        for i in 0..<jsonDic.count
                        {
                            if let datas = jsonDic[i] as? NSDictionary
                            {
                                //   self.adlar.append(datas["adi"] as? NSString as! String)
                                
                                if let baslikArray = datas["adi"] as? String
                                {
                                    self.adlar.append(baslikArray)
                                }
                                
                                if let fiyatArray = datas["fiyat"] as? String
                                {
                                    self.fiyatlar.append(fiyatArray)
                                }
                                
                                if let aciklamaArray = datas["aciklama"] as? String
                                {
                                    self.aciklamalar.append(aciklamaArray)
                                }
                                
                                if let telefonArray = datas["telefon"] as? String
                                {
                                    self.telefonlar.append(telefonArray)
                                }
                                
                                if let kapakFotoArray = datas["kapak_foto"] as? String
                                {
                                    self.kapakFoto.append(kapakFotoArray)
                                }
                                
                                
                                if let photoArray = datas["fotolar"] as? NSArray
                                {
                                    for x in 0 ..< photoArray.count
                                    {
                                        if let photos = photoArray[x] as? NSDictionary
                                        {
                                            
                                            //    self.fotolar.append(photos["adi"] as! [String])
                                            //   print(photos["adi"]!)
                                            
                                            
                                            //print("fotolar : \(photos)")
                                            if let fotoAdi = photos["adi"] as? String
                                            {
                                                
                                                print(fotoAdi)
                                                
                                                self.fotolar.append(fotoAdi )
                                                
                                                
                                                
                                                
                                                
                                                //  print("**************************")
                                                // print("Foto Adları : \(fotoAdi)")
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                            }
                        }
                        //   print(self.adlar)
                    }
                    
                    
                    
                    if let counter = metaArr
                    {
                        
                        let pagecounter = metaArr?["pages"] as! NSInteger
                        self.pages = pagecounter
                    }
                    
                    
                    //     print("foto sayısı : \(self.fotolar.count)")
                    //   print("foto boş mu? : \(self.fotolar.isEmpty)")
                    
                    
                    
                    DispatchQueue.main.async {
                        self.tblView.reloadData()
                        
                    }
                    
                    
                }
                    
                catch
                {
                    print(error)
                    // Alert Ekle
                }
            }
            
            
        }
        task.resume()
        
    }//
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return adlar.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! OtoKiralikTableViewCell
        
        cell.adiLbl.text  = adlar[indexPath.row]
        cell.fiyatLbl.text = fiyatlar[indexPath.row]
        
        //kapak foto
        let imageView = cell.kapakFoto!
        imageView.sd_setImage(with: URL(string: "http://vankent.net/van_kent/web/uploads/brochures/\( kapakFoto[indexPath.row])"
        ))
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if pageCount < pages
        {
            pageCount += 1
            
            print("method çalıştı")
            print(pageCount)
            self.viewDidLoad()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

  

}
