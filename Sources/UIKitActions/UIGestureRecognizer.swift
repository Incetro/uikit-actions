//
//  UIGestureRecognizer.swift
//  UIKitActions IOS
//
//  Created by incetro on 2/19/18.
//

import UIKit

// MARK: - UIGestureRecognizer

public extension UIGestureRecognizer {

    /// Initializes a new item with the given action
    /// - Parameter action: the action to be called when the button is tapped
    convenience init<T: UIGestureRecognizer>(action: @escaping (T) -> Void) {
        let action = ParametizedAction(action: action)
        self.init(target: action, action: action.selector)
        retainAction(action, self)
    }

    /// Initializes a new item with the given action
    /// - Parameter action: the action to be called when the button is tapped
    convenience init(action: @escaping () -> Void) {
        let action = VoidAction(action: action)
        self.init(target: action, action: action.selector)
        retainAction(action, self)
    }
}
