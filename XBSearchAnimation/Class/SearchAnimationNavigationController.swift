//
//  SearchAnimationNavigationController.swift
//  XBSearchAnimation
//
//  Created by xiaobin liu on 2017/9/8.
//  Copyright © 2017年 Sky. All rights reserved.
//

import Foundation
import UIKit

/// MARK - 搜索导航控制器
public final class SearchAnimationNavigationController: UINavigationController, UIViewControllerTransitioningDelegate {
    
    public override func loadView() {
        super.loadView()
        self.extendedLayoutIncludesOpaqueBars = false
        self.view.clipsToBounds = true
        self.transitioningDelegate = self;
        self.modalPresentationStyle = .custom;
    }
    
    
    /// MARK - UIViewControllerTransitioningDelegate Methods
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transitionPresenting(true)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.view.endEditing(true)
        return self.transitionPresenting(false)
    }
    
    
    private func transitionPresenting(_ presenting: Bool) -> SearchModalTransition {
        let animator = SearchModalTransition()
        animator.presenting = presenting
        animator.animationSpeed = 0.30
        animator.backgroundShadeAlpha = 0.4
        return animator
    }
}



/// MARK - 搜索过渡动画
public final class SearchModalTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    /**
     一个开关来确定模态是一个presenter或dismisser
     */
    public var presenting: Bool = true
    
    /**
     半模态出现的速度
     */
    public var animationSpeed: TimeInterval = 0.0
    
    /**
     背景色
     */
    public var backgroundShadeColor: UIColor = .black
    
    /**
     半模态下视图的背景阴影
     */
    public var backgroundShadeAlpha: CGFloat = 0.4
    
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.animationSpeed
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: .from)!
        
        //来自要跳转的view
        let toViewController = (transitionContext.viewController(forKey: .to))!
        
        //模态视图最后一帧
        let modalViewFinalFrame = CGRect(x: 0, y: 0, width: transitionContext.containerView.frame.size.width, height: transitionContext.containerView.frame.size.height)
        
        //模态视图初始帧
        let modalViewInitialFrame = CGRect(x: 0, y: -transitionContext.containerView.frame.size.height, width: transitionContext.containerView.frame.size.width, height: transitionContext.containerView.frame.size.height)
        
        //背景View
        var backgroundView: UIView? = transitionContext.containerView.subviews.filter { $0.tag == 99 }.last
        
        if backgroundView == nil {
            
            backgroundView = UIView(frame: transitionContext.containerView.bounds)
            backgroundView?.alpha = 0
            backgroundView?.tag = 99
            backgroundView?.backgroundColor = backgroundShadeColor
        }
        
        fromViewController.view.isUserInteractionEnabled = false
        toViewController.view.isUserInteractionEnabled = false
        
        if self.presenting {
            
            fromViewController.view.backgroundColor = UIColor.clear
            transitionContext.containerView.insertSubview(backgroundView!, belowSubview: toViewController.view)
            toViewController.view.frame = modalViewInitialFrame
            transitionContext.containerView.addSubview(toViewController.view)
            let navBarFrame = (toViewController as! SearchAnimationNavigationController).navigationBar.frame
            (toViewController as! SearchAnimationNavigationController).navigationBar.frame = CGRect(x: navBarFrame.origin.x, y: 0, width: navBarFrame.size.width, height: navBarFrame.size.height)
            
            
            
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.88, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                backgroundView?.alpha = self.backgroundShadeAlpha
                toViewController.view.frame = modalViewFinalFrame
            }) { _ in
                fromViewController.view.isUserInteractionEnabled = true
                toViewController.view.isUserInteractionEnabled = true
                transitionContext.completeTransition(true)
            }
            
        } else {
            
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
                fromViewController.view.frame = modalViewInitialFrame
                backgroundView?.alpha = 0
            }, completion: { _ in
                fromViewController.view.isUserInteractionEnabled = true
                toViewController.view.isUserInteractionEnabled = true
                toViewController.view.isHidden = false
                transitionContext.completeTransition(true)
            })
        }
    }
}
