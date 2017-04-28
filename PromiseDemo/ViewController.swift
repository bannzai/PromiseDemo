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
        
        promise
            .success { value in
                print("in promise success")
                print(value)
            }
            .failure { error in
                print("in promise failure")
                print(error)
            }
            .then { (v, e) -> Promise<NSNull, Error> in
                print("in promise then")
                return Promise<NSNull, Error>().resolve(value: NSNull())
            }
            .success { null in
                print("in promise success 2")
                print(null)
            }
            .failure { error in
                print("in promise failure 2")
                print(error)
            }
            .then { (hoge, fuga) -> Promise<Any, Any> in
                return Promise<Any, Any>()
            }
            .then { (hoge, fuga) -> Promise<Any, Any> in
                return Promise<Any, Any>()
        }
        
        promise.reject(error: NSError(domain: "domain.com", code: 0, userInfo: nil))
        
        request(with: "https://jsonplaceholder.typicode.com/users")
    }
    
    func request(with url: String) {
        let request = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(data)
            print(response)
        }
        task.resume()
    }
}

