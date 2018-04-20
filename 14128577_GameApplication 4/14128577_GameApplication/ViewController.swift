//
//  ViewController.swift
//  14128577_GameApplication
//
//  Created by MahaboobRaihan on 16/04/2018.
//  Copyright © 2018 MahaboobRaihan. All rights reserved.
//

import UIKit
import AVFoundation
    protocol subviewDelegate {
        func createSomething()
        }

class ViewController: UIViewController, subviewDelegate {
    var gameAnimator: UIDynamicAnimator!
    var dynamicObjectBehaviour : UIDynamicItemBehavior!
    var gravityBehaviour: UIGravityBehavior!
    var collisionBehaviour: UICollisionBehavior!
    var addCars: [UIImageView] = []
    
    @IBOutlet weak var stop: UIButton!
    @IBOutlet weak var start: UIButton!
    @IBAction func stop(_ sender: UIButton) {
        music.stop()
    }
    @IBAction func start(_ sender: UIButton) {
        music.play()
    }
    var music: AVAudioPlayer = AVAudioPlayer ()
    let W = UIScreen.main.bounds.width
    let H = UIScreen.main.bounds.height
    
    @IBAction func restart(_ sender: UIButton) {
        finishView.removeFromSuperview()
        for subview in addCars {
            subview.removeFromSuperview()
        }
        viewDidLoad()
    }
    
    
    @IBOutlet weak var restart: UIButton!
    
    @IBOutlet weak var scoreGenerator: UILabel!
    
    @IBOutlet weak var dragcar: dragcar!

    func createSomething() {
        collisionBehaviour.removeAllBoundaries()
        collisionBehaviour.addBoundary(withIdentifier: "dragcar" as NSCopying, for: UIBezierPath(rect: dragcar.frame))
        
        for subview in addCars {
            if (dragcar.frame.intersects(subview.frame)){
                do {
                    i = i - 1
                    print (subview)
                    scoreGenerator.text = String (i)
                }
//        for dragcar in pointArray {
//            if(dragcar.frame.intersects(dragcar.frame)){
//                point = point - 1
//                self.scoreGenerator.text = String (self.point)
            }
        }
        
    }
    
    
    
    
    
   // var gameTimer = 0
    var i = 0
    var point = 0;
    var start_it = 20
    @objc var startTimer = Timer()
     let finishView = UIImageView(image: nil)

    var pointArray: [UIImageView] = []
    
    
  //  @IBOutlet weak var playerCar: UIImageView!
    @IBOutlet weak var roadimage: UIImageView!
    
    
        
    
    let carsArray = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    
   // let gameTimer = DispatchTime.now() + 20
//    override func perform(_ aSelector: Selector, on thr: Thread, with arg: Any?, waitUntilDone wait: Bool, modes array: [String]?) {
    
    
    


    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dragcar.myDelegate = self
        i = 0
        
//        for dragcar in pointArray {
//            if(dragcar.frame.intersects(dragcar.frame)){
//                point = point - 1
//                self.scoreGenerator.text = String (self.point)
//            }
//        }
        
        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector (getter: ViewController.startTimer), userInfo: nil, repeats: true)
        start_it = 20
     
        let musicfile = Bundle.main.path(forResource: "mymusic", ofType: "mp3")
        do{
            try music = AVAudioPlayer (contentsOf : URL (fileURLWithPath: musicfile!))
            
        }
        catch
        {
            print (error)
        }
        
        restart.isHidden = true
        
        //self.start.isHidden = true
        //self.stop.isHidden = true
        
        gameAnimator = UIDynamicAnimator(referenceView: self.view)
        dynamicObjectBehaviour = UIDynamicItemBehavior(items:[])
        collisionBehaviour = UICollisionBehavior(items:[])
        
        for index in 0...19{
            
            let carsDelay = Double(self.carsArray[index])
            
            let when = DispatchTime.now() + carsDelay
            
            DispatchQueue.main.asyncAfter(deadline: when) {
                
                let barrier = arc4random_uniform(10)
                let barrierView = UIImageView (image: nil)
                //let displayWidth = UIScreen.main.bounds.width
                
                
                switch barrier{
                    
                case 1: barrierView.image = UIImage(named: "car1.png")
                case 2: barrierView.image = UIImage(named: "car2.png")
                case 3: barrierView.image = UIImage(named: "car3.png")
                case 4: barrierView.image = UIImage(named: "car4.png")
                case 5: barrierView.image = UIImage(named: "car5.png")
                case 6: barrierView.image = UIImage(named: "car6.png")
                default: barrierView.image = UIImage(named: "car1.png")
                    
                }
                let RandomXVar = Int(arc4random_uniform(250) + 50)
                barrierView.frame = CGRect(x: RandomXVar, y: 0, width: 30, height:50 )
                
                self.view.addSubview(barrierView)
                self.view.bringSubview(toFront: barrierView)
                self.addCars.append(barrierView)
                
                
                self.dynamicObjectBehaviour.addItem(barrierView)
                self.dynamicObjectBehaviour.addLinearVelocity(CGPoint(x: 0, y: 250), for: barrierView)
                self.collisionBehaviour.addItem(barrierView)
                self.pointArray.append((barrierView))
                //self.scoreGenerator.text = String(self.point)
                //self.point += 1
                let _ = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.i = self.i + 1
                    self.scoreGenerator.text = String(self.i)
                }
                
                
//                self.gameAnimator.addBehavior(self.dynamicObjectBehaviour)
//                self.collisionBehaviour = UICollisionBehavior(items:[barrierView])
                self.collisionBehaviour.translatesReferenceBoundsIntoBoundary = false
//                self.gameAnimator.addBehavior(self.collisionBehaviour)
            }
        }
        
        gameAnimator.addBehavior(dynamicObjectBehaviour)
        //self.collisionBehaviour = UICollisionBehavior(items: [])
        self.collisionBehaviour.translatesReferenceBoundsIntoBoundary = false
       // self.collisionBehaviour.collisionMode = UICollisionBehaviorMode = false
        gameAnimator.addBehavior(collisionBehaviour)
        

        
       
        finishView.image = UIImage(named: "gameover.png")
        finishView.frame = UIScreen.main.bounds
        
        let currentwhen = DispatchTime.now() + 20
        DispatchQueue.main.asyncAfter(deadline: currentwhen){
            self.view.addSubview(self.finishView)
            self.view.addSubview(self.restart)
            
            self.restart.isHidden = false
        }
        
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



