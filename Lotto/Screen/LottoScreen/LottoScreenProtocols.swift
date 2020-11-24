//
//  LottoScreenProtocols.swift
//  Lotto
//
//  Created by mhlee on 2020/10/15.
//

import UIKit
import RxCocoa

struct LottoScreenParams {
}

struct LottoScreenResult {
}

enum LottoScreenError: Error {
}

protocol LottoScreenViewProtocol {
  var presenter: LottoScreenPresenterProtocol { get set }
}

protocol LottoScreenPresenterProtocol {
  var interactor: LottoScreenInteractorProtocol { get }
  var wireframe: LottoScreenWireframeProtocol { get }
  
  func viewDidLoad()
  func viewWillAppear()
  func viewDidAppear()
  func viewWillDisappear()
  func viewDidDisappear()
    
  var numbersList: BehaviorRelay<[[Int]]> { get }
  
  func viewDidPressTry()
}

protocol LottoScreenInteractorProtocol {
  func getNumbersList() -> [[Int]]
}

protocol LottoScreenWireframeProtocol {
  static func createModule(params: LottoScreenParams, dismissHandler: ((LottoScreenResult?, Error?) -> Void)?) -> UIViewController
  var params: LottoScreenParams { get }
}

extension LottoScreenPresenterProtocol {
  func viewDidLoad() {}
  func viewWillAppear() {}
  func viewDidAppear() {}
  func viewWillDisappear() {}
  func viewDidDisappear() {}
}
