//
//  LottoScreenWireframe.swift
//  Lotto
//
//  Created by mhlee on 2020/10/15.
//

import UIKit
import Foundation

class LottoScreenWireframe: LottoScreenWireframeProtocol {
  static func createModule(params: LottoScreenParams, dismissHandler: ((LottoScreenResult?, Error?) -> Void)?) -> UIViewController {
    let interactor = LottoScreenInteractor()
    let wireframe = LottoScreenWireframe(params: params)
    let presenter = LottoScreenPresenter(interactor: interactor, wireframe: wireframe)
    let view = LottoScreenView(presenter: presenter)

    wireframe.vc = view
    wireframe.dismissHandler = dismissHandler
    
    return view
  }
  
  var params: LottoScreenParams
  weak var vc: UIViewController!
  var dismissHandler: ((LottoScreenResult?, Error?) -> Void)?
  
  init(params: LottoScreenParams) {
    self.params = params
  }
  
  func dismiss(result: LottoScreenResult?, error: LottoScreenError?) {
    vc.dismiss(animated: true) { [unowned self] in
      self.dismissHandler?(result, error)
    }
  }
}
