//
//  LandingScreenPresenter.swift
//  MagicWord
//
//  Created by mhlee on 2020/09/10.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation
import RxSwift
import ReSwift

class LandingScreenPresenter: LandingScreenPresenterProtocol, StoreSubscriber {
  typealias StoreSubscriberStateType = State
  
  struct State: StateType {
    enum Stage {
      case Initial
      case Initialization
      case UpdateCheck
      case Intro
      case Finish
    }
        
    var stage: Stage = .Initial
  }
  
  enum Actions {
    struct Start: Action {}
    struct InitializationFinished: Action {}
    struct NoUpdateNeeded: Action {}
    struct IntroFinished: Action {}
  }
  
  private var disposeBag = DisposeBag()
  
  private var store: Store<State>!
  
  var interactor: LandingScreenInteractorProtocol
  var wireframe: LandingScreenWireframeProtocol
  
  var alertOkHandler: ((String?, String?, (() -> Void)?) -> Void)?
  
  init(interactor: LandingScreenInteractorProtocol, wireframe: LandingScreenWireframeProtocol) {
    self.interactor = interactor
    self.wireframe = wireframe
  }
  
  func runStateMachine() {
    guard let _ = store else {
      log.info("-- initialize Store")
      store = Store<State>(reducer: reducer, state: nil)
      log.info("-- subscribe Store")
      store.subscribe(self)
      store.dispatch(Actions.Start())
      return
    }
  }
  
  func reducer(action: Action, state: State?) -> State {
    log.info(action)
    var state = state ?? State()
    
    switch action {
      case _ as ReSwiftInit:
        ()
      case _ as Actions.Start:
        state.stage = .Initialization
      case _ as Actions.InitializationFinished:
        state.stage = .UpdateCheck
      case _ as Actions.NoUpdateNeeded:
        state.stage = .Intro
      case _ as Actions.IntroFinished:
        state.stage = .Finish
      default:
        ()
    }
    
    return state
  }
    
  func newState(state: StoreSubscriberStateType) {
    log.info(state.stage)
    switch state.stage {
      case .Initial:
        ()
      case .Initialization:
        initializationStream
          .subscribe(
            onNext: { [unowned self] in
              self.store.dispatch(Actions.InitializationFinished()) })
          .disposed(by: disposeBag)
      case .UpdateCheck:
        updateCheckStream
          .subscribe(
            onNext: { [unowned self] in
              self.store.dispatch(Actions.NoUpdateNeeded()) })
          .disposed(by: disposeBag)
      case .Intro:
        introStream
          .subscribe(
            onNext: { [unowned self] in
              self.store.dispatch(Actions.IntroFinished()) })
          .disposed(by: disposeBag)
      case .Finish:
        finishStream
          .subscribe(
            onNext: { [unowned self] in
              self.wireframe.presentMain() })
          .disposed(by: disposeBag)
    }
  }
  
  var doNothing: Observable<Void> {
    return Observable<Void>.just(())
  }
  
  var initializationStream: Observable<Void> {
    return doNothing
  }
  
  var updateCheckStream: Observable<Void> {
    return doNothing
  }
  
  var introStream: Observable<Void> {
    if interactor.bypassIntro {
      return doNothing
    }
//    interactor.bypassIntro = true
    return wireframe.presentIntro()
  }
    
  var finishStream: Observable<Void> {
    log.info("finish")
    return Observable<Void>.just(())
  }
    
  private func alert(title: String?, message: String?, completion: (() -> Void)? = nil) -> Observable<Void> {
    return Observable<Void>.create { [unowned self] observer -> Disposable in
      if let handler = self.alertOkHandler {
        handler(title, message) {
          completion?()
          observer.onNext(())
          observer.onCompleted()
        }
      } else {
        observer.onNext(())
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
    
  func viewDidLoad() {
  }
  
  func viewWillAppear() {
  }

  func viewDidAppear() {
    runStateMachine()
  }
}
