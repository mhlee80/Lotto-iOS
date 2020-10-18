//
//  LottoScreenPresenter.swift
//  Lotto
//
//  Created by mhlee on 2020/10/15.
//

import Foundation
import RxCocoa

class LottoScreenPresenter: LottoScreenPresenterProtocol {
  var interactor: LottoScreenInteractorProtocol
  var wireframe: LottoScreenWireframeProtocol
    
  var numbersList: BehaviorRelay<[[Int]]> = .init(value: [[Int]]())
  
  init(interactor: LottoScreenInteractorProtocol, wireframe: LottoScreenWireframeProtocol) {
    self.interactor = interactor
    self.wireframe = wireframe
  }

  func viewDidLoad() {
  }
  
  func viewDidPressTry() {
    let list = interactor.getNumbersList()
    numbersList.accept(list)
  }
}
