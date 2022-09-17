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
  
  private lazy var keyboardObserver = KeyboardScrollViewObserver(scrollView: contentView.tableView)
  
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
    
    view.searchBar.delegate = self
    view.searchBar.placeholder = viewModel.searchBarPlaceholder
    
    viewModel.onStateChange = { state in
      view.activityIndicator.setIsAnimating(state == .loading)
    }
    
    viewModel.reloadContent = {
      DispatchQueue.main.async {
        view.tableView.reloadData()
      }
    }
    
    keyboardObserver.startObservation()
  }
}

// MARK: - UISearchBarDelegate

extension PokemonFeedController: UISearchBarDelegate {
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.setShowsCancelButton(true, animated: true)
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    searchBar.setShowsCancelButton(false, animated: true)
  }
  
  func searchBar(
    _ searchBar: UISearchBar,
    textDidChange searchText: String
  ) {
    viewModel.performSearch(with: searchText.nilIfEmpty)
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = nil
    viewModel.loadData()
    searchBar.resignFirstResponder()
  }
}
