//
//  ControlAction.swift
//  UIKitActions IOS
//
//  Created by incetro on 2/19/18.
//

import UIKit

// MARK: - ControlAction

protocol ControlAction: Action {
    var controlEvent: UIControl.Event { get }
}
