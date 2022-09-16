//
//  BaseViewController.swift
//  PokemonFeed
//
//  Created by Valeriy L on 15.09.2022.
//

import UIKit

/**
 Base class for all view controllers which are part of scene.
 Simple screen can be implemented using just UIViewController.
 */
class BaseViewController<View: BaseView, ViewModel>: UIViewController {
  
  // MARK: - Properties
  
  let viewModel: ViewModel
  let contentView: View
  
  // MARK: - Constructor
  
  init(viewModel: ViewModel) {
    self.viewModel = viewModel
    contentView = View.init()
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    debugPrint("Did deinit \(String(describing: type(of: self)))")
  }
  
  // MARK: - Lifecycle
  
  override func loadView() {
    self.view = contentView
  }
}
