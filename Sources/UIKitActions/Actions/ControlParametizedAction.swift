//
//  ControlParametizedAction.swift
//  UIKitActions IOS
//
//  Created by incetro on 2/19/18.
//

import UIKit

// MARK: - ControlParametizedAction

class ControlParametizedAction<T: UIControl>: ParametizedAction<T>, ControlAction {

    // MARK: - Properties

    /// Current control trigger event
    let controlEvent: UIControl.Event

    // MARK: - Initializers

    /// Default initializer
    /// - Parameters:
    ///   - event: current control trigger event
    ///   - action: current action represented as a Swift closure
    init(event: UIControl.Event, action: @escaping (T) -> Void) {
        controlEvent = event
        super.init(action: action)
    }
}
