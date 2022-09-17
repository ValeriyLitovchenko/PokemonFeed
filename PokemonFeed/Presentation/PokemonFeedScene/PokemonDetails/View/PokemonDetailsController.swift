//
//  PokemonDetailsController.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import UIKit

final class PokemonDetailsController: BaseTableViewController<PokemonDetailsControllerView, PokemonDetailsViewModel> {
  
  // MARK: - Properties
  
  override var content: [TableSectionModel] {
    viewModel.content
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    viewModel.loadData()
  }
  
  // MARK: - Private functions
  
  private func setupUI() {
    let `view` = contentView
    
    title = viewModel.screenTitle
    
    view.tableView.allowsSelection = false
    
    viewModel.reloadContent = {
      DispatchQueue.main.async(execute: view.tableView.reloadData)
    }
  }
}
