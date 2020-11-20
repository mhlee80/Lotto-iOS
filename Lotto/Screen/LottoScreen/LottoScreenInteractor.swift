//
//  LottoScreenInteractor.swift
//  Lotto
//
//  Created by mhlee on 2020/10/15.
//

import Foundation

class LottoScreenInteractor: LottoScreenInteractorProtocol {
  // 번호가 겹치지 않는 5장의 로또 번호를 생성한다.
  func getNumbersList() -> [[Int]] {
    var numbersList = [[Int]]()
    var candidates = Array(1...45)
    for _ in 0..<7 { // 5장
      var numbers = [Int]()
      
      for _ in 0..<6 { // 6개 숫자
        let pickIndex = Int.random(in: 0..<candidates.count)
        numbers.append(candidates[pickIndex])
        candidates.remove(at: pickIndex)
      }
      
      numbersList.append(numbers.sorted())
    }
    
    return numbersList
  }
}
