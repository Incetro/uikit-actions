//
//  Actionable.swift
//  UIKitActions IOS
//
//  Created by incetro on 2/19/18.
//

import Foundation

// MARK: - Actionable

/// The protocol stores `Action` instances.
/// The main goal of it is avoid them to be deallocated.
protocol Actionable: AnyObject {
    var actions: [String: Action] { get }
}

private var actionsKey: UInt8 = 0

extension Actionable {

    fileprivate(set) var actions: [String: Action] {
        get {
            let actions = objc_getAssociatedObject(self, &actionsKey) as? [String: Action] ?? [:]
            self.actions = actions
            return actions
        }
        set(newValue) {
            objc_setAssociatedObject(self, &actionsKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

func retainAction(_ action: Action, _ object: NSObject) {
    object.actions[action.key] = action
}

func releaseAction(_ action: Action, _ object: NSObject) {
    object.actions[action.key] = nil
}

extension NSObject: Actionable {}
