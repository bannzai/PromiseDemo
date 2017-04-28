//
//  ViewController.swift
//  PromiseDemo
//
//  Created by 廣瀬雄大 on 2017/04/28.
//  Copyright © 2017年 廣瀬雄大. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let promise = Promise<String, Error>()
        
//        promise
//            .success { value in
//                print("in promise success")
//                print(value)
//            }
//            .failure { error in
//                print("in promise failure")
//                print(error)
//            }
//            .then { (v, e) -> Promise<NSNull, Error> in
//                print("in promise then")
//                return Promise<NSNull, Error>().resolve(value: NSNull())
//            }.success { null in
//                
//            }.failure { error in
//                print("in promise failure")
//                print(error)
//        }
//        
//        promise.resolve(value: "valud")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

