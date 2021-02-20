//
//  CustomParametizedAction.swift
//  UIKitActions IOS
//
//  Created by incetro on 2/19/18.
//

import Foundation

// MARK: - CustomParametizedAction

class CustomParametizedAction<T: NSObject>: Action {

    // MARK: - Properties

    /// The key used to store the `Action`.
    /// Must be unique.
    @objc let key = ProcessInfo.processInfo.globallyUniqueString

    /// The selector provided by the action
    @objc let selector: Selector = #selector(perform)

    /// Current action represented as a Swift closure
    private let action: (T) -> Void

    /// Current action parameter
    private(set) weak var parameter: T?

    // MARK: - Initializers

    /// Default initializer
    /// - Parameter parameter: current action parameter
    /// - Parameter action: current action represented as a Swift closure
    init(
        parameter: T?,
        action: @escaping (T) -> Void
    ) {
        self.action = action
        self.parameter = parameter
    }

    // MARK: - Internal

    /// Performs currently stored action
    @objc func perform() {
        guard let parameter = parameter else { return }
        action(parameter)
    }
}
