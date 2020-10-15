//
//  LottoScreenProtocols.swift
//  Lotto
//
//  Created by mhlee on 2020/10/15.
//

import UIKit

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
  
  var numbersList: [[Int]] { get }
  
  var onNumbersListReloaded: (() -> Void)? { get set }
  
  func viewDidPressTry()
}

protocol LottoScreenInteractorProtocol {
  func getNumbersList() -> [[Int]]
}

protocol LottoScreenWireframeProtocol {
  static func createModule(params: LottoScreenParams) -> UIViewController
  var params: LottoScreenParams { get }
}

extension LottoScreenPresenterProtocol {
  func viewDidLoad() {}
  func viewWillAppear() {}
  func viewDidAppear() {}
  func viewWillDisappear() {}
  func viewDidDisappear() {}
}