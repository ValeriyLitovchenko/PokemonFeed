//
//  PokemonFeedController.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import UIKit

final class PokemonFeedController: BaseTableViewController<PokemonFeedControllerView, PokemonFeedViewModel> {
  
  // MARK: - Property
  
  override var content: [TableSectionModel] {
    viewModel.content
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    viewModel.loadData()
  }
  
  // MARK: - Private Functions
  
  private func setupUI() {
    
    let `view` = contentView
    
    title = viewModel.screenTitle
    
    viewModel.reloadContent = {
      DispatchQueue.main.async {
        view.tableView.reloadData()
      }
    }
  }
  
}
