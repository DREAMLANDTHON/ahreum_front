//
//  UserDefaultManager.swift
//  Ahreum
//
//  Created by Gaeun Lee on 2023/07/28.
//

import SwiftUI

struct UserDefaultManager {
    static let shared = UserDefaultManager()
    
    enum UserDefaultKey: String, CaseIterable {
        case todayBallCount
    }
    
    func saveTodayBallCount(num: Int) {
        let key = UserDefaultKey.todayBallCount.rawValue
        UserDefaults.standard.set(num, forKey: key)
    }
    
    func getTodayBallCount() -> Int? {
        let key = UserDefaultKey.todayBallCount.rawValue
        if let count = UserDefaults.standard.object(forKey: key) as? Int {
            return count
        } else {
            return nil
        }
    }
}
