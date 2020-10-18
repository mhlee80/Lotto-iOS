//
//  LottoScreenPresenter.swift
//  Lotto
//
//  Created by mhlee on 2020/10/15.
//

import Foundation
//import RxCocoa

class LottoScreenPresenter: LottoScreenPresenterProtocol {
  var interactor: LottoScreenInteractorProtocol
  var wireframe: LottoScreenWireframeProtocol
  
  var numbersList: [[Int]] = [[Int]()] {
    didSet {
      listenerForNumbersList?(numbersList)
    }
  }
  
  var listenerForNumbersList: (([[Int]]) -> Void)? = nil
  
//  var numbersList: BehaviorRelay<[[Int]]> = .init(value: [[Int]]())
  
  init(interactor: LottoScreenInteractorProtocol, wireframe: LottoScreenWireframeProtocol) {
    self.interactor = interactor
    self.wireframe = wireframe
  }

  func viewDidLoad() {
//    print("!!!")
  }
  
  func viewDidPressTry() {
    let list = interactor.getNumbersList()
    self.numbersList = list
//    numbersList.accept(list)
  }
}
