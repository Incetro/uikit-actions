//
//  ControlVoidAction.swift
//  UIKitActions IOS
//
//  Created by incetro on 2/19/18.
//

import UIKit

// MARK: - ControlVoidAction

class ControlVoidAction: VoidAction, ControlAction {

    // MARK: - Properties

    /// Current control trigger event
    let controlEvent: UIControl.Event

    // MARK: - Initializers

    /// Default initializer
    /// - Parameters:
    ///   - event: current control trigger event
    ///   - action: current action represented as a Swift closure
    init(event: UIControl.Event, action: @escaping () -> Void) {
        controlEvent = event
        super.init(action: action)
    }
}
