//
//  LandingScreenWireframe.swift
//  MagicWord
//
//  Created by mhlee on 2020/09/10.
//  Copyright © 2020 mhlee. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import WhatsNewKit

class LandingScreenWireframe: LandingScreenWireframeProtocol {
  static func createModule(params: LandingScreenParams, dismissHandler: ((LandingScreenResult?, Error?) -> Void)?) -> UIViewController {
    let interactor = LandingScreenInteractor()
    let wireframe = LandingScreenWireframe(params: params)
    let presenter = LandingScreenPresenter(interactor: interactor, wireframe: wireframe)
    let view = LandingScreenView(presenter: presenter)
    
    wireframe.vc = view
    wireframe.dismissHandler = dismissHandler
    return view
  }
  
  var params: LandingScreenParams
  weak var vc: UIViewController!
  var dismissHandler: ((LandingScreenResult?, Error?) -> Void)?
  
  init(params: LandingScreenParams) {
    self.params = params
  }
  
  func dismiss(result: LandingScreenResult?, error: LandingScreenError?) {
    vc.dismiss(animated: true) { [unowned self] in
      self.dismissHandler?(result, error)
    }
  }
  
  func presentMain() {
    let module = LottoScreenWireframe.createModule(params: LottoScreenParams(), dismissHandler: nil)
    WindowService.shared.replaceRootViewController(vc: module)
  }
  
  func presentIntro() -> Observable<Void> {
    return Observable<Void>.create { [unowned self] observer -> Disposable in
      self.presentIntro {
        observer.onNext(())
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
  
  func presentIntro(completion: (() -> Void)?) {
    enum Constant {
      static let titleFont: UIFont = .boldSystemFont(ofSize: 30)
      static let titleInsets = UIEdgeInsets(top: 45, left: 20, bottom: 20, right: 20)
      
      static let itemTitleFont: UIFont = .systemFont(ofSize: 18)
      static let itemSubtitleFont: UIFont = .systemFont(ofSize: 12)
      
      static let completionButtonInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
      static let completionButtonContentInsets = UIEdgeInsets(top: 16, left: 32, bottom: 16, right: 32)
      static let completionButtonCornerRadius: CGFloat = 25
    }
    
    typealias C = Constant
    
    // MARK: Step 1: Initialize the WhatsNew.Items
    
    let item1 = WhatsNew.Item(
      title: "행운의 번호들을 생성하세요\n",
      subtitle: "· 총 7장이 생성됩니다.\n\n· 선택된 42개의 숫자는 서로 겹치지 않습니다.",
      image: nil
    )
        
    // Initialize Items
    let items = [
      item1,
    ]
        
    // MARK: Step 2: Initialize WhatsNew with title and items
    
    // Initialize WhatsNew
    let whatsNew = WhatsNew(
      title: "시작하기",
      items: items
    )
    
    // MARK: Step 3: Initialize a WhatsNewViewController Configuration
    
    // Initialize Theme
    let theme = WhatsNewViewController.Theme { configuration in
      configuration.backgroundColor = .whatsNewKitWhite
      configuration.apply(textColor: .whatsNewKitBlack)
      configuration.tintColor = AppTheme.colorScheme.primaryColor
    }
        
    // Initialize WhatsNewViewController Configuration in order to customize the Layout and behaviour
    var configuration = WhatsNewViewController.Configuration(
      theme: theme,
      detailButton: .init(
        // Detail Button Title
        title: "홈페이지",
        // Detail Button Action
        action: .website(url: "https://www.wiwa.io")
      ),
      completionButton: .init(
        // Completion Button Title
        title: "확인",
        // Completion Button Action
        action: .custom(action: { vc in
          vc.dismiss(animated: true, completion: completion)
        })
      )
    )
    
    configuration.titleView.insets = C.titleInsets
    configuration.titleView.titleFont = C.titleFont
    
    configuration.itemsView.titleFont = C.itemTitleFont
    configuration.itemsView.subtitleFont = C.itemSubtitleFont
    
    configuration.completionButton.insets = C.completionButtonInsets
    configuration.completionButton.contentEdgeInsets = C.completionButtonContentInsets
    configuration.completionButton.cornerRadius = C.completionButtonCornerRadius
    
    configuration.itemsView.animation = .slideRight
    
    // MARK: Step 3: Initialize and present a WhatsNewViewController
    
    // Declare WhatsNewViewController
    let controller = WhatsNewViewController(whatsNew: whatsNew,
                                            configuration: configuration)
    
    controller.modalPresentationStyle = .fullScreen
    controller.modalTransitionStyle = .crossDissolve
    vc.present(controller, animated: true)
  }
}
