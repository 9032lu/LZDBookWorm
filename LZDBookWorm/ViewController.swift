//
//  ViewController.swift
//  LZDBookWorm
//
//  Created by ZhangTu on 2018/3/30.
//  Copyright © 2018年 Test. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SnapKit
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

   lazy var tableView :UITableView = UITableView()
    
    var data_A :NSArray = NSArray.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "测试首页"


        self.tableView.frame = view.bounds;
        

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        self.postRequest()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        
        return   self.data_A.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier :String = "identifierCell"
        
        var cell  = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        
        
        if cell == nil{
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: identifier)
           
            
        }
        
        let dic = self.data_A[indexPath.row] as! NSDictionary
        
        var url = dic["cover"]!;
        
        if url is NSNull {

            url = "ssssssssssss"
        }else{

            url = dic["cover"] as! String
        }
        
        
        
        
        let urlstr = "http://t1.beijingzhangtu.com/upload/\(url)"
        
//        print(urlstr)
        
        
      let imgV:UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        
        cell?.contentView.addSubview(imgV)
        
        let ns_url : NSURL = NSURL.init(string: urlstr)!
        
        print(ns_url)
        
        
        imgV.kf.setImage(with: ImageResource.init(downloadURL: (URL.init(string: urlstr))!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        
        
        
        cell?.textLabel?.text = dic["title"] as? String;

        
        return cell!
        
    }
    func postRequest(){
        
        
        let paramer : [String : Any] = ["libraryId":"1","token":"ff1496cd6d0f24f0f46a7e9f2799b8b4","userId":"4741"]
        
        let main_url : String = "http://t1.beijingzhangtu.com/api/functions/getList.html"
        
        Alamofire.request(main_url, method: .post, parameters: paramer).responseJSON { (returnResult) in
            
            //            print("post====\(returnResult)")
            
//                        if let value = returnResult.result.value {
            
                            
                            
                            
            //               print("firstMethod ---> responseJson\(json)")
            
            //                print("request===\(returnResult.request!)")
//                            print("data===\(returnResult.data!)")
            //                print("result===\(returnResult.result)")
            
//                        }
            
            
             
            
            
                
//                self.data_A = json["data"];
                
//                self.tableView?.reloadData()
                
         
            switch returnResult.result.isSuccess{
                
            case true:
                if let items = returnResult.result.value as? NSDictionary{
                    
                    print(items["data"]!)
                    let data_A :NSArray = items["data"]! as! NSArray
                    self.data_A = data_A
                    
                    
//                    for dict in data_A{
//                        print(dict)
//                    }
                    
                    
                }
                
            case false: break
                
                
            }
            
        self.tableView.reloadData()

//            switch returnResult.result.isSuccess {
//            case true:
//                print("数据获取成功!")
//
//                if let items = returnResult.result.value as? NSDictionary{
//
//                    for dict it
//                }
//
//                if
//            case false:
//                print(returnResult.result.error ?? Error.self)
//
//
//            }
            
            
            
            
            
        }
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

