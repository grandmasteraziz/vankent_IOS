//
//  EtkinlikPaginationDenemeViewController.swift
//  vankentrehberi
//
//  Created by Aziz on 29/07/2017.
//  Copyright © 2017 koddata. All rights reserved.
//

import UIKit
import SDWebImage


class EtkinlikPaginationDenemeViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource ,UIScrollViewDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    var pageCount = 1
    var adlar = [String]()
    var adresler = [String]()
    var kapakFoto = [String]()
    var pages = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlString = "http://vankent.net/van_kent/web/api/etkinlik/listele?page=" + String(pageCount)
        print(urlString)

        loadData(urlString: urlString)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func loadData(urlString: String)
    {
        
        var url = URL(string: urlString)
        
        print("**************")
        print(urlString)
        print("**************")
        
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
                                
                                if let adresArray = datas["adres"] as? String
                                {
                                    self.adresler.append(adresArray)
                                }
                                
                                if let kapakFotoArray = datas["kapak_foto"] as? String
                                {
                                    self.kapakFoto.append(kapakFotoArray)
                                }
                            }
                        }
                        print(self.adlar)
                    }
                    
                    
                    
                    if let counter = metaArr
                    {
                        
                        let pagecounter = metaArr?["pages"] as! NSInteger
                        self.pages = pagecounter
                    }
                    
                    
                    
                    
                    
                    DispatchQueue.main.async {
                        self.tblView.reloadData()
                    }
                    
                    
                }
                    
                catch
                {
                    print(error)
                }
            }
            
            
        }
        task.resume()
        
    }
    
    // Tableview methods
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       return adlar.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CampaingTableViewCell
        
        
            
            cell.adilLbl.text = adlar[indexPath.row]
            cell.adresLbl.text = adresler[indexPath.row]
        
            let imageView = cell.productImage as! UIImageView
        imageView.sd_setImage(with: URL(string: "http://vankent.net/van_kent/web/uploads/brochures/\( kapakFoto[indexPath.row])"
                                         ))
        
        //
        
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("seçildi")
    }
    
    
    //scroll parmak yukarı gittiğinde çalışır
   /* public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
       
    }
     */
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if pageCount < pages
        {
            pageCount += 1
            
            print("method çalıştı")
            print(pageCount)
            self.viewDidLoad()
        }
    }
 

}
