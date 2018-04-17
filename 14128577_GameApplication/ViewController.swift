//
//  ViewController.swift
//  14128577_GameApplication
//
//  Created by MahaboobRaihan on 16/04/2018.
//  Copyright © 2018 MahaboobRaihan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gameAnimator: UIDynamicAnimator!
    var dynamicObjectBehaviour : UIDynamicItemBehavior!
    var gravityBehaviour: UIGravityBehavior!
    var collisionBehaviour: UICollisionBehavior!
    
    @IBOutlet weak var playerCar: UIImageView!
    @IBOutlet weak var roadimage: UIImageView!
    @IBAction func recognizer(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        if let view = sender.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        collisionBehaviour.addBoundary(withIdentifier: "playerCar" as NSCopying, for: UIBezierPath(rect: playerCar.frame))
        
    }
    
    let carsArray = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        gameAnimator = UIDynamicAnimator(referenceView: self.view)
        dynamicObjectBehaviour = UIDynamicItemBehavior(items:[])
        collisionBehaviour = UICollisionBehavior(items:[])
        
        for index in 0...19{
            
            let carsDelay = Double(self.carsArray[index])
            
            let when = DispatchTime.now() + carsDelay
            
            DispatchQueue.main.asyncAfter(deadline: when) {
                
                let barrier = arc4random_uniform(10)
                let barrierView = UIImageView (image: nil)
                let displayWidth = UIScreen.main.bounds.width
                
                
                switch barrier{
                    
                case 1: barrierView.image = UIImage(named: "car1.png")
                case 2: barrierView.image = UIImage(named: "car2.png")
                case 3: barrierView.image = UIImage(named: "car3.png")
                case 4: barrierView.image = UIImage(named: "car4.png")
                case 5: barrierView.image = UIImage(named: "car5.png")
                case 6: barrierView.image = UIImage(named: "car6.png")
                default:
                    
                    barrierView.image = UIImage(named: "car1.png")
                    
                }
                barrierView.frame = CGRect(x: Int(arc4random_uniform(UInt32(displayWidth))), y: 0, width: 40, height:80 )
                
                self.view.addSubview(barrierView)
                self.view.bringSubview(toFront: barrierView)
                
                
                self.dynamicObjectBehaviour.addItem(barrierView)
                self.dynamicObjectBehaviour.addLinearVelocity(CGPoint(x: 0, y: 250), for: barrierView)
                self.collisionBehaviour.addItem(barrierView)
            }
        }
        
        gameAnimator.addBehavior(dynamicObjectBehaviour)
        collisionBehaviour = UICollisionBehavior(items:[])
        collisionBehaviour.translatesReferenceBoundsIntoBoundary = false
        gameAnimator.addBehavior(collisionBehaviour)
        
        var pictureArray: [UIImage]!
        
        pictureArray = [UIImage(named: "road1.png")!,
                        UIImage(named: "road2.png")!,
                        UIImage(named: "road3.png")!,
                        UIImage(named: "road4.png")!,
                        UIImage(named: "road5.png")!,
                        UIImage(named: "road6.png")!,
                        UIImage(named: "road7.png")!,
                        UIImage(named: "road8.png")!,
                        UIImage(named: "road9.png")!,
                        UIImage(named: "road10.png")!,
                        UIImage(named: "road11.png")!,
                        UIImage(named: "road12.png")!,
                        UIImage(named: "road13.png")!,
                        UIImage(named: "road14.png")!,
                        UIImage(named: "road15.png")!,
                        UIImage(named: "road16.png")!,
                        UIImage(named: "road17.png")!,
                        UIImage(named: "road18.png")!,
                        UIImage(named: "road19.png")!,
                        UIImage(named: "road20.png")!]
        
        roadimage.image = UIImage.animatedImage(with: pictureArray, duration: 0.5)
        roadimage.frame = UIScreen.main.bounds
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



