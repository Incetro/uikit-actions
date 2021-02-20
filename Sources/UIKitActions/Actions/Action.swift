//
//  Action.swift
//  UIKitActions IOS
//
//  Created by incetro on 2/19/18.
//

import Foundation

/// Protocol that implements converting Swift closures into ObjC selectors
@objc public protocol Action {

    /// The key used to store the `Action`.
    /// Must be unique.
    var key: String { get }

    /// The selector provided by the action
    var selector: Selector { get }
}
