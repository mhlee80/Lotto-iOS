//
//  LandingScreenInteractor.swift
//  MagicWord
//
//  Created by mhlee on 2020/09/10.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation
import RxSwift

class LandingScreenInteractor: LandingScreenInteractorProtocol {
  var bypassIntro: Bool {
    get { return UserDefaultsService.shared.bypassIntro }
    set { UserDefaultsService.shared.bypassIntro = newValue }
  }
}
