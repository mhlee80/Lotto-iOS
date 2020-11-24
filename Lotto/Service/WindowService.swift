//
//  WindowService.swift
//  MagicWord
//
//  Created by mhlee on 2020/09/10.
//  Copyright © 2020 mhlee. All rights reserved.
//

import UIKit

class WindowService: NSObject {
  enum Constant {
  }
  
  typealias C = Constant
  
  static let shared = WindowService()
    
  var window: UIWindow?
  
  private override init() {
    super.init()
  }
  
  func replaceRootViewController(vc: UIViewController) {
    window?.rootViewController = vc
  }
}
