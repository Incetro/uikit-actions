//
//  ParametizedAction.swift
//  UIKitActions IOS
//
//  Created by incetro on 2/19/18.
//

import Foundation

// MARK: - ParametizedAction

/// Action abstraction with some genreic parameter
class ParametizedAction<T: Any>: Action {

    // MARK: - Properties

    /// The key used to store the `Action`.
    /// Must be unique.
    @objc let key = ProcessInfo.processInfo.globallyUniqueString

    /// The selector provided by the action
    @objc let selector: Selector = #selector(perform)

    /// Current action represented as a Swift closure
    private let action: (T) -> Void

    // MARK: - Initializers

    /// Default initializer
    /// - Parameter action: current action represented as a Swift closure
    init(action: @escaping (T) -> Void) {
        self.action = action
    }

    // MARK: - Internal

    /// Performs currently stored action
    @objc func perform(parameter: AnyObject) {
        guard let parameter = parameter as? T else {
            preconditionFailure("Parametrized action parameter must be the \(T.self) type")
        }
        action(parameter)
    }
}
