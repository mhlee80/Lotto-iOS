//
//  UserDefaultsService.swift
//  MemPass
//
//  Created by mhlee on 2020/10/01.
//

import Foundation

class UserDefaultsService: NSObject {
  enum Key: String {
    case showIntro
  }
  
  static let shared = UserDefaultsService()
  
  private override init() {
    super.init()
  }
  
  var bypassIntro: Bool {
    get {
      UserDefaults.standard.bool(forKey: Key.showIntro.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: Key.showIntro.rawValue)
    }
  }
}
