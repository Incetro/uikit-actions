//
//  EventAction.swift
//  UIKitActions IOS
//
//  Created by incetro on 2/19/18.
//

import UIKit

// MARK: - EventAction

/// Action to manage the two parameters selector allowed in controls
class EventAction<T: UIControl>: ControlAction {

    // MARK: - Properties

    /// Current control trigger event
    let controlEvent: UIControl.Event

    /// The key used to store the `Action`.
    /// Must be unique.
    @objc let key = ProcessInfo.processInfo.globallyUniqueString

    /// The selector provided by the action
    @objc let selector: Selector = #selector(perform)

    /// Current action represented as a Swift closure
    let action: (T, UIEvent?) -> Void

    // MARK: - Initializers

    /// Default initializer
    /// - Parameters:
    ///   - event: current control trigger action
    ///   - action: current action represented as a Swift closure
    init(event: UIControl.Event, action: @escaping (T, UIEvent?) -> Void) {
        self.action = action
        controlEvent = event
    }

    /// Performs currently stored action
    @objc func perform(parameter: AnyObject, event: UIEvent?) {
        guard let parameter = parameter as? T else {
            preconditionFailure("Parametrized action parameter must be the \(T.self) type")
        }
        action(parameter, event)
    }
}
