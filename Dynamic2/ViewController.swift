//
//  ViewController.swift
//  Dynamic2
//
//  Created by Citizen on 9/16/18.
//  Copyright © 2018 Citizen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var squareView = UIView()
    var animator = UIDynamicAnimator()
    var snapBehavior: UISnapBehavior?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        createGestureRecognizer()
        createSmallSquareView()
        createAnimatorAndBehaviors()
    }

    func createGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(paramTap:)))
        self.view.addGestureRecognizer(tap)
    }
    
    func createSmallSquareView() {
        squareView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        squareView.backgroundColor = UIColor.green
        squareView.center = self.view.center
        self.view.addSubview(squareView)
    }
    
    func createAnimatorAndBehaviors() {
        animator = UIDynamicAnimator(referenceView: self.view)
        let collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        snapBehavior = UISnapBehavior(item: squareView, snapTo: squareView.center)
        snapBehavior?.damping = 0.5
        animator.addBehavior(snapBehavior!)
    }
    
    @objc func handleTap(paramTap: UITapGestureRecognizer) {
        let tapPoint = paramTap.location(in: self.view)
        if snapBehavior != nil {
            animator.removeBehavior(snapBehavior!)
        }
        snapBehavior = UISnapBehavior(item: squareView, snapTo: tapPoint)
        snapBehavior?.damping = 1.5
        animator.addBehavior(snapBehavior!)
        
    }
    
  
}

