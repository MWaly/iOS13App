//
//  LocalStorage.swift
//  EventsVIPER
//
//  Created by Mokhles on 12.03.19.
//  Copyright © 2019 iostldr. All rights reserved.
//

import Foundation

enum StoreKey: String {
    case SimpleStore
}

protocol LocalStorable {
    var store: UserDefaults { get }
    func retrieveStore(key: StoreKey) -> [String: String]
    func get(value: String, store: StoreKey)
}

final class LocalStore: LocalStorable {
    
    let store = UserDefaults.standard
    
    func retrieveStore(key: StoreKey) -> [String: String] {
        guard let store = UserDefaults.standard.value(forKey: key.rawValue) as? [String: String] else
        {
            UserDefaults.standard.set([:], forKey: key.rawValue)
            return UserDefaults.standard.value(forKey: key.rawValue) as! [String: String]
        }        
        return store
    }
    
    func get(value: String, store: StoreKey) {
        
    }
    
}
