//
//  FetchingDataErrorMessageAlertModel.swift
//  PokemonFeed
//
//  Created by Valeriy L on 19.09.2022.
//

import Foundation

/// Specific fetch data error message alert model
struct FetchingDataErrorMessageAlertModel: MessageAlertModel {
  
  // MARK: - Properties
  
  let title: String?
  let message: String?
  let actions: [MessageAlertAction]
  
  // MARK: - Constructor
  
  private init(
    title: String?,
    message: String?,
    actions: [MessageAlertAction]
  ) {
    self.title = title
    self.message = message
    self.actions = actions
  }
  
  static func modelWithActions(
    onRetry: @escaping VoidCallback,
    onCancel: VoidCallback? = nil
  ) -> FetchingDataErrorMessageAlertModel {
    let actions = [
      MessageAlertAction(
        type: .confirming,
        title: NSLocalizedString("Retry", comment: ""),
        handler: onRetry),
      
      MessageAlertAction(
        type: .confirming,
        title: NSLocalizedString("Cancel", comment: ""),
        handler: onCancel)
    ]
    
    return FetchingDataErrorMessageAlertModel(
      title: NSLocalizedString("Operation Error", comment: ""),
      // swiftlint:disable line_length
      message: NSLocalizedString("An error occurred while fetching data from server. Would you like to retry?", comment: ""),
      actions: actions)
  }
}
