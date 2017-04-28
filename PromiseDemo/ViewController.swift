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
        
        request(with: "https://jsonplaceholder.typicode.com/posts")
            .success { response in
                print("1: response: \(response)")
            }
            .failure{ error in
                print("1: error: \(error)")
            }
            .then { (response, error) -> Promise<String, Error> in
                return self.requestForResponseAsString(with: "https://jsonplaceholder.typicode.com/users")
            }
            .success { response in
                print("2: response: \(response)")
            }
            .failure{ error in
                print("2: error: \(error)")
            }
            .then { (response, error) -> Promise<URLResponse, Error> in
                return self.request(with: "https://jsonplaceholder.typicode.com/albums")
            }
            .success { response in
                print("3: response: \(response)")
            }
            .failure{ error in
                print("3: error: \(error)")
            }
    }
    
    enum Result<V> {
        case success(V)
        case failure(Error)
    }
    
    func requestForResponseAsString(with url: String) -> Promise<String, Error> {
        let promise = Promise<String, Error>()
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                promise.resolve(value: "\(response)")
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

