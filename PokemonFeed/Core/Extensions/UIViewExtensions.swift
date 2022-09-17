//
//  UIViewExtensions.swift
//  PokemonFeed
//
//  Created by Valeriy L on 15.09.2022.
//

import UIKit

extension UIView {
  
  func addPinnedSubview(
    _ subview: UIView,
    side: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]) {
      
    subview.translatesAutoresizingMaskIntoConstraints = false
    addSubview(subview)
    subview.pinEdges(to: self, side: side)
  }
  
  func pinEdges(
    to other: UIView,
    side: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]) {
      
    let attributes: [NSLayoutConstraint.Attribute] = side
    NSLayoutConstraint.activate(attributes.map {
      NSLayoutConstraint(
        item: other,
        attribute: $0,
        relatedBy: .equal,
        toItem: self,
        attribute: $0,
        multiplier: 1,
        constant: .zero)
    })
  }
  
}