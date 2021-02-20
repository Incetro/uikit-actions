//
//  UIControl.swift
//  UIKitActions IOS
//
//  Created by incetro on 2/19/18.
//

import UIKit

// MARK: - Actions

/// Extension that provides methods to add actions to controls
public extension UIControl {

    /// Adds the given action as response to the given control event
    /// - Parameters:
    ///   - event: the event that the control must receive to trigger the closure
    ///   - action: the closure that will be called when the gesture is detected
    /// - Returns: the added action
    @discardableResult func add<T: UIControl>(
        event: UIControl.Event,
        action: @escaping (T, UIEvent?) -> Void
    ) -> Action {
        let action = EventAction(event: event, action: action)
        add(event: event, action: action)
        return action
    }

    /// Adds the given action as response to the given control event
    /// - Parameters:
    ///   - event: the event that the control must receive to trigger the closure
    ///   - action: the closure that will be called when the gesture is detected
    /// - Returns: the added action
    @discardableResult func add<T: UIControl>(
        event: UIControl.Event,
        action: @escaping (T) -> Void
    ) -> Action {
        let action = ControlParametizedAction(event: event, action: action)
        add(event: event, action: action)
        return action
    }

    /// Adds the given action as response to the given control event
    /// - Parameters:
    ///   - event: the event that the control must receive to trigger the closure
    ///   - action: the closure that will be called when the gesture is detected
    /// - Returns: the added action
    @discardableResult func add(
        event: UIControl.Event,
        action: @escaping () -> Void
    ) -> Action {
        let action = ControlVoidAction(event: event, action: action)
        add(event: event, action: action)
        return action
    }

    /// Adds the given action as response to the given control events
    /// - Parameters:
    ///   - events: the events that the control must receive to trigger the closure
    ///   - action: the closure that will be called when the gesture is detected
    /// - Returns: the added actions
    @discardableResult func add<T: UIControl>(
        events: [UIControl.Event],
        action: @escaping (T, UIEvent?) -> Void
    ) -> [Action] {
        events.map { add(event: $0, action: action) }
    }

    /// Adds the given action as response to the given control events
    /// - Parameters:
    ///   - events: the events that the control must receive to trigger the closure
    ///   - action: the closure that will be called when the gesture is detected
    /// - Returns: the added actions
    @discardableResult func addAction<T: UIControl>(
        events: [UIControl.Event],
        action: @escaping (T) -> Void
    ) -> [Action] {
        events.map { add(event: $0, action: action) }
    }

    /// Adds the given action as response to the given control events
    /// - Parameters:
    ///   - events: the events that the control must receive to trigger the closure
    ///   - action: the closure that will be called when the gesture is detected
    /// - Returns: the added actions
    @discardableResult func addAction(
        events: [UIControl.Event],
        action: @escaping () -> Void
    ) -> [Action] {
        events.map { add(event: $0, action: action) }
    }

    /// Disable the given action to be launched as response of the received event
    /// - Parameters:
    ///   - action: the action to disable
    ///   - events: the control events that you want to remove for the specified target object
    func remove(
        _ action: Action,
        for events: UIControl.Event
    ) {
        removeTarget(action, action: action.selector, for: events)
        releaseAction(action, self)
    }

    /// Disable all the actions for a given event to be launched as response of the received event
    /// - Parameter events: the control events that you want to remove for the specified target object
    func removeActions(for events: UIControl.Event) {
        for (_, value) in actions {
            guard let action = value as? ControlAction, (action.controlEvent.rawValue & events.rawValue) != 0 else {
                continue
            }
            remove(action, for: events)
        }
    }

    // MARK: - Private

    /// Add the given action for the given event
    /// - Parameters:
    ///   - event: some event
    ///   - action: some action block
    private func add(
        event: UIControl.Event,
        action: Action
    ) {
        retainAction(action, self)
        addTarget(
            action,
            action: action.selector,
            for: event
        )
    }
}

// MARK: - Throttle

/// Throttle and action tuple
private typealias ThrottleAndAction = (throttle: ThrottleProtocol, action: Action)

/// Associated value helper
private var throttlesKey: UInt8 = 0

/// Extension which provides a set of methods
/// to Throttle actions triggered by control events.
extension UIControl {

    /// Add an action for the given control event.
    /// The action is not performed immediately, instead it is scheduled to be executed after the given time interval.
    /// If the control event is triggered again before the time interval expires, the previous call is canceled.
    /// It prevents the action of being triggered more than once in the given time interval.
    ///
    /// - parameter event:    The event which triggers the action
    /// - parameter interval: The time interval to wait before performing the action
    /// - parameter handler:  The action which will be executed when the time itnerval expires.
    public func throttle<T: UIControl>(
        _ event: UIControl.Event,
        interval: TimeInterval,
        handler: @escaping (T, UIEvent?) -> Void
    ) {
        let throttle = Throttle(interval: interval) { (sender, event) in
            handler(sender, event)
        }
        let action = add(event: event) { (control: T, event: UIEvent?) in
            throttle.schedule(with: (control, event))
        }
        add(throttle: throttle, action: action, for: event)
    }

    /// Add an action for the given control evetn.
    /// The action is not performed immediately, instead it is scheduled to be executed after the given time interval.
    /// If the control event is triggered again before the time interval expires, the previous call is canceled.
    /// It prevents the action of being triggered more than once in the given time interval.
    ///
    /// - parameter event:    The event which triggers the action
    /// - parameter interval: The time interval to wait before performing the action
    /// - parameter handler:  The action which will be executed when the time itnerval expires.
    public func throttle<T: UIControl>(
        _ event: UIControl.Event,
        interval: TimeInterval,
        handler: @escaping (T) -> Void
    ) {
        let throttle = Throttle(interval: interval, action: handler)
        let action = add(event: event) { (control: T) in
            throttle.schedule(with: control)
        }
        add(throttle: throttle, action: action, for: event)
    }

    /// Add an action for the given control evetn.
    /// The action is not performed immediately, instead it is scheduled to be executed after the given time interval.
    /// If the control event is triggered again before the time interval expires, the previous call is canceled.
    /// It prevents the action of being triggered more than once in the given time interval.
    ///
    /// - parameter event:    The event which triggers the action
    /// - parameter interval: The time interval to wait before performing the action
    /// - parameter handler:  The action which will be executed when the time itnerval expires.
    public func throttle(
        _ event: UIControl.Event,
        interval: TimeInterval,
        handler: @escaping () -> Void
    ) {
        let throttle = Throttle(interval: interval, action: handler)
        let action = add(event: event) {
            throttle.schedule(with: ())
        }
        add(throttle: throttle, action: action, for: event)
    }

    /// Remove the current Throttle (if any) for the given control event
    ///
    /// - parameter event: The event whose Throttle will be removed
    public func removeThrottle(for event: UIControl.Event) {
        if let currentThrottle = self.throttles[event.rawValue] {
            currentThrottle.throttle.cancel()
            remove(currentThrottle.action, for: event)
        }
    }

    // MARK: - Private

    /// Add throttle action to the given event
    /// - Parameters:
    ///   - throttle: target throttle
    ///   - action: some action
    ///   - event: some event
    private func add<T>(
        throttle: Throttle<T>,
        action: Action,
        for event: UIControl.Event
    ) {
        removeThrottle(for: event)
        self.throttles[event.rawValue] = (throttle, action)
    }

    /// All currently stored throttles
    private var throttles: [UInt: ThrottleAndAction] {
        get {
            objc_getAssociatedObject(self, &throttlesKey) as? [UInt: ThrottleAndAction] ?? [:]
        }
        set(newValue) {
            objc_setAssociatedObject(self, &throttlesKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
