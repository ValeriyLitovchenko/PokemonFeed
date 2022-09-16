//
//  BaseTableViewController.swift
//  PokemonFeed
//
//  Created by Valeriy L on 15.09.2022.
//

import UIKit

class BaseTableViewController<View: BaseTableViewControllerView, ViewModel>:
  BaseViewController<View, ViewModel>, UITableViewDelegate, UITableViewDataSource {
  
  // MARK: - Properties
  
  var content: [TableSectionModel] {
    fatalError("Should be overriden by subclass")
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  // MARK: - UITableViewDataSource
  
  final func numberOfSections(in tableView: UITableView) -> Int {
    content.count
  }
  
  final func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    content[section].items.count
  }
  
  final func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let model = cellModel(for: indexPath)
    guard let cell = tableView.dequeueReusableCell(withIdentifier: model.type.identifier) as? BaseTableCell else {
      fatalError("Unable to create cell. Nib might be not registered")
    }
    
    cell.configure(with: model)
    
    return cell
  }
  
  // MARK: - UITableViewDelegate
    
  dynamic func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    guard let applicableActionModel = cellModel(for: indexPath) as? ApplicableActionModel else {
      return
    }
    
    applicableActionModel.onAction()
  }
  
  final func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    cellModel(for: indexPath).cellHeight
  }
  
  final func tableView(
    _ tableView: UITableView,
    heightForHeaderInSection section: Int
  ) -> CGFloat {
    .leastNormalMagnitude
  }

  final func tableView(
    _ tableView: UITableView,
    heightForFooterInSection section: Int
  ) -> CGFloat {
    .leastNormalMagnitude
  }
  
  // MARK: - Helpers
  
  final func cellModel(for indexPath: IndexPath) -> BaseTableCellModel {
    content[indexPath.section]
      .items[indexPath.row]
  }
  
  // MARK: - Private functions
  
  private func setupUI() {
    let `view` = contentView
    let tableView = view.tableView
    
    for cell in view.usedCells {
      tableView?.register(cell.nib, forCellReuseIdentifier: cell.identifier)
    }
    
    tableView?.delegate = self
    tableView?.dataSource = self
  }
}
