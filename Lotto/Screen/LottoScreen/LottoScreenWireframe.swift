//
//  LottoScreenWireframe.swift
//  Lotto
//
//  Created by mhlee on 2020/10/15.
//

import UIKit
import Foundation

class LottoScreenWireframe: LottoScreenWireframeProtocol {
  static func createModule(params: LottoScreenParams) -> UIViewController {
    let interactor = LottoScreenInteractor()
    let wireframe = LottoScreenWireframe(params: params)
    let presenter = LottoScreenPresenter(interactor: interactor, wireframe: wireframe)
    let view = LottoScreenView(presenter: presenter)

    wireframe.vc = view
    
    return view
  }
  
  private unowned var vc: UIViewController!
  var params: LottoScreenParams
  
  init(params: LottoScreenParams) {
    self.params = params
  }
}
