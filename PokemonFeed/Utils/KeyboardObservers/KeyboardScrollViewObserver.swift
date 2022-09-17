//
//  KeyboardScrollViewObserver.swift
//  KeyboardObserver
//
//  Created by Gleb Cherkashyn on 26.08.2020.
//

import UIKit

final class KeyboardScrollViewObserver {
  
  // MARK: - Properties
  
  private let keyboardObserver: KeyboardObserver
  private unowned var scrollView: UIScrollView
  private let additionalSpacing: Double
  
  // MARK: - Constructor
  
  init(
    scrollView: UIScrollView,
    additionalSpacing: Double = .zero
  ) {
    self.scrollView = scrollView
    self.additionalSpacing = additionalSpacing
    keyboardObserver = KeyboardObserver()
  }
  
  // MARK: - Methods
  
  func startObservation() {
    keyboardObserver.observe { [weak self] event in
      guard let `self` = self else { return }
      let scrollView = self.scrollView
      let keyboardFrameEnd = event.keyboardFrameEnd(to: scrollView)
      let animFrame = scrollView.frame
      var additionalSpacing: CGFloat = .zero
      
      switch event.type {
      case .willShow,
          .didShow:
        additionalSpacing = CGFloat(self.additionalSpacing)
      default:
        break
      }
      
      let bottom = animFrame.height - keyboardFrameEnd.minY + 10 + additionalSpacing + self.scrollView.contentOffset.y
      var contentInset = scrollView.contentInset
      contentInset.bottom = max(bottom, .zero)
      
      UIView.animate(
        withDuration: event.duration,
        delay: .zero,
        options: [event.options],
        animations: { () -> Void in
          scrollView.contentInset = contentInset
        },
        completion: nil
      )
    }
  }
}
