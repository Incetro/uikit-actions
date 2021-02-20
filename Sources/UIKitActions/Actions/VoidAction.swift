//
//  VoidAction.swift
//  UIKitActions IOS
//
//  Created by incetro on 2/19/18.
//

import Foundation

// MARK: - VoidAction

/// Action that takes zero parameters
class VoidAction: Action {

    // MARK: - Properties

    /// The key used to store the `Action`.
    /// Must be unique.
    @objc let key = ProcessInfo.processInfo.globallyUniqueString

    /// The selector provided by the action
    @objc let selector: Selector = #selector(perform)

    /// Current action represented as a Swift closure
    private let action: (() -> Void)

    // MARK: - Initializers

    /// Default initializer
    /// - Parameter action: current action represented as a Swift closure
    init(action: @escaping () -> Void) {
        self.action = action
    }

    // MARK: - Useful

    /// Performs currently stored action
    @objc func perform() {
        action()
    }
}
