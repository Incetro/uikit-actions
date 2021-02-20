//
//  Gesture.swift
//  UIKitActions IOS
//
//  Created by incetro on 2/19/18.
//

import UIKit

// MARK: - Gesture

/// The gestures that can be used to trigger actions in `UIView`
public enum Gesture {

    /// A tap gesture with a single finger
    /// and the given number of touches
    case tap(Int)

    /// A swipe gesture with a single finger
    /// and the given direction
    case swipe(UISwipeGestureRecognizer.Direction)

    /// A tap gesture with the given
    /// number of touches and fingers
    case multiTap(taps: Int, fingers: Int)

    /// A swipe gesture with the given
    /// direction and number of fingers
    case multiSwipe(direction: UISwipeGestureRecognizer.Direction, fingers: Int)

    /// Return gesture recognzier for the given action
    /// - Parameter action: some action
    /// - Returns: UIGestureRecognizer instance
    func recognizer(action: Action) -> UIGestureRecognizer {
        switch self {
        case let .tap(taps):
            let recognizer = UITapGestureRecognizer(target: action, action: action.selector)
            recognizer.numberOfTapsRequired = taps
            return recognizer
        case let .swipe(direction):
            let recognizer = UISwipeGestureRecognizer(target: action, action: action.selector)
            recognizer.direction = direction
            return recognizer
        case let .multiTap(taps, fingers):
            let recognizer = UITapGestureRecognizer(target: action, action: action.selector)
            recognizer.numberOfTapsRequired = taps
            recognizer.numberOfTouchesRequired = fingers
            return recognizer
        case let .multiSwipe(direction, fingers):
            let recognizer = UISwipeGestureRecognizer(target: action, action: action.selector)
            recognizer.direction = direction
            recognizer.numberOfTouchesRequired = fingers
            return recognizer
        }
    }
}
