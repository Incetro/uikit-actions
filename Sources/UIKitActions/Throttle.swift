//
//  Throttle.swift
//  UIKitActions IOS
//
//  Created by incetro on 2/19/18.
//

import Foundation

// MARK: - ThrottleProtocol

protocol ThrottleProtocol {
    func cancel()
}

// MARK: - Throttle

/// Object that allows scehduele actions to be called after a specific time interval,
/// and prevent it of being called more than once in that interval.
/// If the action is scheduled again before the time interval expires,
/// it cancels the previous call (if any) preventing the action to be called twice.
/// It contains a generic parameter `Argument` that indicates the type of parameter of the action.
public final class Throttle<Argument>: ThrottleProtocol {

    // MARK: - Properties

    /// The type of the action
    public typealias ThrottleAction = (Argument) -> Void

    /// The time interval that the Throttle will wait before call the actions
    private let interval: TimeInterval

    /// The action which will be called after the time interval
    private let action: ThrottleAction

    /// Current timer helper instance
    private var timer: Timer?

    // MARK: - Initializers

    /// Creates a new instance with the given time interval and action
    /// - parameter interval: The time interval
    /// - parameter action:   The action
    /// - returns: The new Throttle
    public init(
        interval: TimeInterval,
        action: @escaping ThrottleAction
    ) {
        self.interval = interval
        self.action = action
    }

    // MARK: - Public

    /// Schedule a new call of the action.
    /// If there is a pending action, it will be cancelled.
    /// - parameter value: The argument that will be sent as argument to the action closure
    public func schedule(with value: Argument) {
        cancel()
        timer = Timer.scheduledTimer(
            timeInterval: interval,
            target: self,
            selector: #selector(onTimer),
            userInfo: value,
            repeats: false
        )
    }

    /// Force the execution of the action, without waiting for the interval.
    /// If there is a pending action, it will be cancelled.
    /// - parameter value: The argument that will be sent as argument to the action closure
    public func fire(with value: Argument) {
        action(value)
    }

    // MARK: - ThrottleProtocol

    /// Cancel the pending action
    public func cancel() {
        timer?.invalidate()
        timer = nil
    }

    // MARK: - Private

    @objc private func onTimer(_ timer: Timer) {
        guard let value = timer.userInfo as? Argument else { return }
        fire(with: value)
    }
}
