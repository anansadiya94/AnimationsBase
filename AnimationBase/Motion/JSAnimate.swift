/**
 *  Animate
 *  Copyright (c) John Sundell 2017
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

// MARK: - Public
public struct JSAnimation {
    public let duration: TimeInterval
    public let closure: (UIView) -> Void
    
    public init(duration: TimeInterval, closure: @escaping (UIView) -> Void) {
        self.duration = duration
        self.closure = closure
    }
}

public extension JSAnimation {
    // TODO: Add custom methods here.
    static func fadeIn(duration: TimeInterval = 0.3) -> JSAnimation {
        return JSAnimation(duration: duration) { $0.alpha = 1 }
    }
    
    static func fadeOut(duration: TimeInterval = 0.3) -> JSAnimation {
        return JSAnimation(duration: duration) { $0.alpha = 0 }
    }
    
    static func resize(to size: CGSize, duration: TimeInterval = 0.3) -> JSAnimation {
        return JSAnimation(duration: duration) { $0.bounds.size = size }
    }
    
    static func scale(x: CGFloat, y: CGFloat, duration: TimeInterval) -> JSAnimation {
        return JSAnimation(duration: duration, closure: {
            $0.transform = CGAffineTransform(scaleX: x, y: y)
        })
    }
    
    static func move(toX x: CGFloat, toY y: CGFloat, duration: TimeInterval = 0.3) -> JSAnimation {
        return JSAnimation(duration: duration) {
            $0.center.x = x
            $0.center.y = y
        }
    }
    
    static func move(byX x: CGFloat, byY y: CGFloat, duration: TimeInterval = 0.3) -> JSAnimation {
        return JSAnimation(duration: duration) {
            $0.center.x += x
            $0.center.y += y
        }
    }
}

public final class AnimationToken {
    private let view: UIView
    private let animations: [JSAnimation]
    private let mode: AnimationMode
    private var isValid = true
    
    internal init(view: UIView, animations: [JSAnimation], mode: AnimationMode) {
        self.view = view
        self.animations = animations
        self.mode = mode
    }
    
    deinit {
        perform {}
    }
    
    internal func perform(completionHandler: @escaping () -> Void) {
        guard isValid else {
            return
        }
        
        isValid = false
        
        switch mode {
        case .inSequence:
            view.performAnimations(animations, completionHandler: completionHandler)
        case .inParallel:
            view.performAnimationsInParallel(animations, completionHandler: completionHandler)
        }
    }
}

public func animate(_ tokens: [AnimationToken]) {
    guard !tokens.isEmpty else {
        return
    }
    
    var tokens = tokens
    let token = tokens.removeFirst()
    
    token.perform {
        animate(tokens)
    }
}

public func animate(_ tokens: AnimationToken...) {
    animate(tokens)
}

public extension UIView {
    @discardableResult func animate(_ animations: [JSAnimation]) -> AnimationToken {
        return AnimationToken(
            view: self,
            animations: animations,
            mode: .inSequence
        )
    }
    
    @discardableResult func animate(_ animations: JSAnimation...) -> AnimationToken {
        return animate(animations)
    }
    
    @discardableResult func animate(inParallel animations: [JSAnimation]) -> AnimationToken {
        return AnimationToken(
            view: self,
            animations: animations,
            mode: .inParallel
        )
    }
    
    @discardableResult func animate(inParallel animations: JSAnimation...) -> AnimationToken {
        return animate(inParallel: animations)
    }
}

// MARK: - Internal

internal enum AnimationMode {
    case inSequence
    case inParallel
}

internal extension UIView {
    func performAnimations(_ animations: [JSAnimation], completionHandler: @escaping () -> Void) {
        guard !animations.isEmpty else {
            return completionHandler()
        }
        
        var animations = animations
        let animation = animations.removeFirst()
        
        UIView.animate(withDuration: animation.duration, animations: {
            animation.closure(self)
        }, completion: { _ in
            self.performAnimations(animations, completionHandler: completionHandler)
        })
    }
    
    func performAnimationsInParallel(_ animations: [JSAnimation], completionHandler: @escaping () -> Void) {
        guard !animations.isEmpty else {
            return completionHandler()
        }
        
        let animationCount = animations.count
        var completionCount = 0
        
        let animationCompletionHandler = {
            completionCount += 1
            
            if completionCount == animationCount {
                completionHandler()
            }
        }
        
        for animation in animations {
            UIView.animate(withDuration: animation.duration, animations: {
                animation.closure(self)
            }, completion: { _ in
                animationCompletionHandler()
            })
        }
    }
}
