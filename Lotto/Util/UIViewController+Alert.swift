//
//  UIViewController+Alert.swift
//  MagicWord
//
//  Created by mhlee on 2020/06/18.
//  Copyright © 2020 mhlee. All rights reserved.
//

import UIKit
import PMAlertController

extension UIViewController {
  enum Alert {
    enum Kind {
      case ok(
        okTitle: String? = nil,
        completion: (() -> Void)? = nil)
      case okWithCancel(
        okTitle: String? = nil,
        cancelTitle: String? = nil,
        okCompletion: (() -> Void)? = nil,
        cancelCompletion: (() -> Void)? = nil)
    }
    
    enum Constant {
      static let titleFont: UIFont = .systemFont(ofSize: 14)
      static let titleColor: UIColor = .black
      static let messageFont: UIFont = .systemFont(ofSize: 14)
      static let messageColor: UIColor = .black
      static let buttonTitleFont: UIFont = .systemFont(ofSize: 14)
      static let okTitleColor: UIColor = AppTheme.colorScheme.primaryColor
      static let okTitle: String = "확인"
      static let cancelTitleColor: UIColor = AppTheme.colorScheme.onBackgroundColor
      static let cancelTitle: String = "취소"
    }
  }

  func showAlert(title: String?, message: String?, kind: Alert.Kind) {
    let alertVC = PMAlertController(title: title, description: message, image: nil, style: .alert)
    alertVC.alertTitle.font = Alert.Constant.titleFont
    alertVC.alertTitle.textColor = Alert.Constant.titleColor
    alertVC.alertDescription.font = Alert.Constant.messageFont
    alertVC.alertDescription.textColor = Alert.Constant.messageColor
    
    switch kind {
    case .ok(let okTitle, let completion):
      let okButton = PMAlertAction(title: okTitle ?? Alert.Constant.okTitle, style: .default, action: {
        completion?()
      })
      okButton.setTitleColor(Alert.Constant.okTitleColor, for: .normal)
      okButton.titleLabel?.font = Alert.Constant.buttonTitleFont
      
      alertVC.addAction(okButton)
      
      alertVC.gravityDismissAnimation = false
      present(alertVC, animated: true, completion: nil)
    case .okWithCancel(let okTitle, let cancelTitle, let okCompletion, let cancelCompletion):
      let cancelButton = PMAlertAction(title: cancelTitle ?? Alert.Constant.cancelTitle, style: .default, action: { () -> Void in
        cancelCompletion?()
      })
      cancelButton.setTitleColor(Alert.Constant.cancelTitleColor, for: .normal)
      cancelButton.titleLabel?.font = Alert.Constant.buttonTitleFont
      
      let okButton = PMAlertAction(title: okTitle ?? Alert.Constant.okTitle, style: .default, action: { () in
        okCompletion?()
      })
      okButton.setTitleColor(Alert.Constant.okTitleColor, for: .normal)
      okButton.titleLabel?.font = Alert.Constant.buttonTitleFont
      
      alertVC.addAction(cancelButton)
      alertVC.addAction(okButton)
      
      alertVC.gravityDismissAnimation = false
      present(alertVC, animated: true, completion: nil)
    }
  }
  
  func showOk(title: String?, message: String?, completion: (() -> Void)?) {
    showAlert(title: title, message: message, kind: .ok(okTitle: nil, completion: completion))
  }
  
  func showError(error: Error, completion: (() -> Void)?) {
    showAlert(title: nil, message: error.localizedDescription, kind: .ok(okTitle: nil, completion: completion))
  }
}
