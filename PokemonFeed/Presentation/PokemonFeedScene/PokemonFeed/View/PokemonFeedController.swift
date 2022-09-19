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
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    view.endEditing(true)
  }
  
  // MARK: - Private Functions
  
  private func setupUI() {
    
    let `view` = contentView
    
    title = viewModel.screenTitle
    
    addSearchButton()
    
    viewModel.onStateChange = { state in
      view.activityIndicator.setIsAnimating(state == .loading)
    }
    
    view.tableView.separatorStyle = .none
    
    viewModel.reloadContent = {
      DispatchQueue.main.async {
        view.tableView.reloadData()
      }
    }
    
    keyboardObserver.startObservation()
  }
  
  private func hideSearchBar() {
    UIView.animate(withDuration: 0.2, animations: {
      self.navigationItem.titleView = nil
    }, completion: { [weak self] _ in
      self?.addSearchButton()
    })
  }
  
  private func addSearchButton() {
    let searchButton = UIBarButtonItem(
      barButtonSystemItem: .search,
      target: self,
      action: #selector(showSearchBar))
    
    navigationItem.setRightBarButton(searchButton, animated: true)
  }
  
  @objc
  private func showSearchBar() {
    let searchBar = UISearchBar(frame: .zero)
    searchBar.delegate = self
    searchBar.placeholder = viewModel.searchBarPlaceholder
    searchBar.alpha = .zero
    navigationItem.setRightBarButton(nil, animated: true)
    
    UIView.animate(withDuration: 0.2, animations: {
      self.navigationItem.titleView = searchBar
      searchBar.alpha = 1.0
    }, completion: { [weak searchBar] _ in
      searchBar?.becomeFirstResponder()
    })
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
    if searchBar.text?.nilIfEmpty != nil {
      viewModel.loadData()
    }
    searchBar.text = nil
    searchBar.resignFirstResponder()
    hideSearchBar()
  }
}
