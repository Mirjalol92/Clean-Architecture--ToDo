//
//  Dynamic.swift
//  ToDo
//
//  Created by Ali on 2022/11/17.
//

import Foundation

// MARK: - class for detecting and processing data changes
class Dynamic<T>{
    typealias Listener = (T) -> ()
    typealias NVListener = () -> ()
    //    var listener: Listener?
    var listeners: [Listener?]  = [Listener?]()
    var nvlisteners: [NVListener?]  = [NVListener?]()
    
    // MARK: - connect to data listiner
    func bind(_ listener: Listener?) {
        //        self.listener = listener
        if let appendListener = listener {
            listeners.append(appendListener)
        }
    }
    
    // MARK: - connect to data listiner
    func bind(_ listener: NVListener?) {
        //        self.listener = listener
        if let appendListener = listener {
            nvlisteners.append(appendListener)
        }
    }
    
    // MARK: - connect to data listener and set data value
    func bindAndFire(_ listener: Listener?) {
        //        self.listener = listener
        //        listener?(value)
        if let appendListener = listener {
            listeners.append(appendListener)
        }
        setValueToListener(value)
    }
    
    
    // MARK: - connect to data listener and set data value
    func bindAndFire(_ listener: NVListener?) {
        if let appendListener = listener {
            nvlisteners.append(appendListener)
        }
        
        setValueToListener(value)
    }
    
    // MARK: - data value
    var value: T {
        didSet {
            setValueToListener(value)
        }
    }
    
    /**
     Initialization and value setting
     */
    init(_ v: T) {
        value = v
    }
    
    // MARK: - set value make all listeners detect the change
    private func setValueToListener(_ value: T){
        if listeners.count > 0 {
            for appendedListener in listeners {
                appendedListener?(value)
            }
        }
        
        if nvlisteners.count > 0 {
            for appendedListener in nvlisteners {
                appendedListener?()
            }
        }
    }
    
    // MARK: - Clear all listeners
    func clearBind(){
        if listeners.count > 0 {
            listeners.removeAll()
        }
        
        
        if nvlisteners.count > 0 {
            nvlisteners.removeAll()
        }
    }
}
