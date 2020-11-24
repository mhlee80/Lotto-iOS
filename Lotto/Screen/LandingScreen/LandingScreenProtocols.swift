//
//  LandingScreenProtocols.swift
//  MagicWord
//
//  Created by mhlee on 2020/09/10.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation
import RxSwift

struct LandingScreenParams {
}

struct LandingScreenResult {
}

enum LandingScreenError: Error {
}

protocol LandingScreenViewProtocol {
  var presenter: LandingScreenPresenterProtocol { get }
}

protocol LandingScreenPresenterProtocol {
  var interactor: LandingScreenInteractorProtocol { get }
  var wireframe: LandingScreenWireframeProtocol { get }
  
  func viewDidLoad()
  func viewWillAppear()
  func viewDidAppear()
  func viewWillDisappear()
  func viewDidDisappear()
      
  var alertOkHandler: ((_ title: String?, _ message: String?, _ completion: (() -> Void)?) -> Void)? { get set }
}

protocol LandingScreenInteractorProtocol {
  var bypassIntro: Bool { get set }
}

protocol LandingScreenWireframeProtocol {
  static func createModule(params: LandingScreenParams, dismissHandler: ((LandingScreenResult?, Error?) -> Void)?) -> UIViewController
  
  var params: LandingScreenParams { get }
  
  func dismiss(result: LandingScreenResult?, error: LandingScreenError?)
    
  func presentMain()
  func presentIntro() -> Observable<Void>
  func presentIntro(completion: (() -> Void)?)
}

extension LandingScreenPresenterProtocol {
  func viewDidLoad() {}
  func viewWillAppear() {}
  func viewDidAppear() {}
  func viewWillDisappear() {}
  func viewDidDisappear() {}
}
