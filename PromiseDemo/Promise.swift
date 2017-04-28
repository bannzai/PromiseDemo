//
//  Promise.swift
//  PromiseDemo
//
//  Created by 廣瀬雄大 on 2017/04/28.
//  Copyright © 2017年 廣瀬雄大. All rights reserved.
//

import Foundation

class Promise<V, E> {
    
    enum State  {
        case none
        case resolved(V)
        case failed(E)
    }
    
    init() {
        
    }
    
    var handlers: [(() -> Void)] = []
    var state: State = .none
    
    func success(_ closure: @escaping ((V) -> Void)) -> Promise {
        handlers
            .append { [weak self] _ in
                guard let unwrappedSelf = self else {
                    return
                }
                
                switch unwrappedSelf.state {
                case .resolved(let value):
                    closure(value)
                default:
                    return
                }
                
        }
        return self
    }
    
    @discardableResult func failure(_ closure: @escaping ((E) -> Void)) -> Promise {
        handlers
            .append { [weak self] _ in
                guard let unwrappedSelf = self else {
                    return
                }
                
                switch unwrappedSelf.state {
                case .failed(let v):
                    closure(v)
                default:
                    return
                }
        }
        return self
    }
    
    @discardableResult func then<U, F>(_ closure: @escaping ((V?, E?) -> Promise<U, F>)) -> Promise<U, F> {
        let promise = Promise<U, F>()
        
        handlers.append { [weak self] _ in
            guard let unwrappedSelf = self else {
                return
            }
            let tuple: (value: V?, error: E?)
            switch unwrappedSelf.state {
            case .none:
                fatalError()
            case .resolved(let value):
                tuple = (value: value, error: nil)
            case .failed(let error):
                tuple = (value: nil, error: error)
            }
            
            let _promise = closure(tuple.value, tuple.error)
            
            _promise
                .success { value in
                    promise.resolve(value: value)
                }
                .failure { error in
                    promise.reject(error: error)
            }
            
            switch _promise.state {
            case .none:
                return
            default:
                _promise.done()
            }
        }
        
        return promise
    }
    
    @discardableResult func resolve(value: V) -> Promise {
        state = .resolved(value)
        done()
        return self
    }
    
    @discardableResult func reject(error: E) -> Promise {
        state = .failed(error)
        done()
        return self
    }
    
    private func done() {
        DispatchQueue.main.async {
            self.handlers.forEach { $0() }
            self.handlers.removeAll()
        }
    }
    
}


