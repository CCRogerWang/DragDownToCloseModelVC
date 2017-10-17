//
//  ModelViewController.swift
//  DragDownToCloseModelVC
//
//  Created by roger on 2017/10/13.
//  Copyright © 2017年 roger. All rights reserved.
//

import UIKit

class ModelViewController: UIViewController {


    var panGestureRecongnizer: UIPanGestureRecognizer!
    var interactor: Interactor? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.transitioningDelegate = self
        
        // 2
        panGestureRecongnizer = UIPanGestureRecognizer(target: self, action: #selector(ModelViewController.handlePanGesture(sender:)))
        self.view.addGestureRecognizer(panGestureRecongnizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        //1
        let percentThreshold:CGFloat = 0.3
        //2
        let translation = sender.translation(in: self.view)
        let verticalMovement = translation.y / self.view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        guard let interactor = interactor else { return }
        //3
        switch sender.state {
        case .began:
            interactor.hasStarted = true
            self.dismiss(animated: true, completion: nil)
        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish ? interactor.finish() : interactor.cancel()
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        default:
            break
        }
    }
    
}

extension ModelViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let interactor = self.interactor else {
            return nil
        }
        return interactor.hasStarted ? interactor : nil
    }
}
