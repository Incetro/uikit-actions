//
//  UIView.swift
//  UIKitActions IOS
//
//  Created by incetro on 2/19/18.
//

import UIKit

// MARK: - UIView

public extension UIView {

    /// Adds the given action as response to the gesture
    /// - Parameters:
    ///   - gesture: the gesture that the view must receive to trigger the closure
    ///   - action: the closure that will be called when the gesture is detected
    /// - Returns: the gesture recognizer that has been added
    @discardableResult func add<T: UIView>(
        gesture: Gesture,
        action: @escaping (T) -> Void
    ) -> UIGestureRecognizer {
        let action = CustomParametizedAction(parameter: (self as! T), action: action)
        return add(gesture: gesture, action: action)
    }

    /// Adds the given action as response to the gesture
    /// - Parameters:
    ///   - gesture: the gesture that the view must receive to trigger the closure
    ///   - action: the closure that will be called when the gesture is detected
    /// - Returns: the gesture recognizer that has been added
    @discardableResult func add(
        gesture: Gesture,
        action: @escaping () -> Void
    ) -> UIGestureRecognizer {
        let action = VoidAction(action: action)
        return add(gesture: gesture, action: action)
    }

    /// Adds the given action as response to a single tap gesture
    /// - Parameter action: the closure that will be called when the gesture is detected
    /// - Returns: the gesture recognizer that has been added
    @discardableResult func addTap<T: UIView>(
        action: @escaping (T) -> Void
    ) -> UIGestureRecognizer {
        let action = CustomParametizedAction(parameter: (self as! T), action: action)
        return add(gesture: .tap(1), action: action)
    }

    /// Adds the given action as response to a single tap gesture
    /// - Parameter action: the closure that will be called when the gesture is detected
    /// - Returns: the gesture recognizer that has been added
    @discardableResult func addAction(
        action: @escaping () -> Void
    ) -> UIGestureRecognizer {
        let action = VoidAction(action: action)
        return add(gesture: .tap(1), action: action)
    }

    // MARK: - Private

    /// Combine the given gesture with the given action
    /// - Parameters:
    ///   - gesture: the gesture that the view must receive to trigger the closure
    ///   - action: the closure that will be called when the gesture is detected
    /// - Returns: the gesture recognizer that has been added
    @discardableResult private func add(
        gesture: Gesture,
        action: Action
    ) -> UIGestureRecognizer{
        retainAction(action, self)
        let gesture = gesture.recognizer(action: action)
        isUserInteractionEnabled = true
        addGestureRecognizer(gesture)
        return gesture
    }
}
