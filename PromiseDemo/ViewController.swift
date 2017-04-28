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
        
//        let promise = Promise<String, Error>()
//        
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
//            }
//            .success { null in
//                print("in promise success 2")
//                print(null)
//            }
//            .failure { error in
//                print("in promise failure 2")
//                print(error)
//            }
//            .then { (hoge, fuga) -> Promise<Any, Any> in
//                return Promise<Any, Any>()
//            }
//            .then { (hoge, fuga) -> Promise<Any, Any> in
//                return Promise<Any, Any>()
//        }
//        
//        promise.reject(error: NSError(domain: "domain.com", code: 0, userInfo: nil))
        
        request(with: "https://jsonplaceholder.typicode.com/users")
            .success { response in
                print("1: response: \(response)")
            }
            .failure { error in
                print("1: error: \(error)")
            }
            .then { (response, error) -> Promise<URLResponse, Error> in
                print("in promise then")
                return self.request(with: "https://jsonplaceholder.typicode.com/todos")
            }
            .success { response in
                print("2: response: \(response)")
            }
            .failure { error in
                print("2: error: \(error)")
        }
    }
    
    func request(with url: String) -> Promise<URLResponse, Error> {
        let promise = Promise<URLResponse, Error>()
        let request = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                promise.resolve(value: response)
                return
            }
            
            if let error = error {
                promise.reject(error: error)
                return
            }
        }
        task.resume()
        return promise
    }
}

