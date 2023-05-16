//
//  PersistInt.swift
//  iDebug
//
//  Created by Nail Sharipov on 14.05.2023.
//

import Foundation

public final class PersistInt {
    
    private let key: String
    private let nilValue: Int
    
    public var value: Int {
        get {
            guard UserDefaults.standard.value(forKey: key) != nil else {
                return nilValue
            }
            return UserDefaults.standard.integer(forKey: key)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    public init(key: String, nilValue: Int = 0) {
        self.key = key
        self.nilValue = nilValue
    }
    
}
