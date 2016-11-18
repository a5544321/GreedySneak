//
//  ViewController.swift
//  SnakeEat
//
//  Created by CareTek on 2016/7/27.
//  Copyright © 2016年 Cheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,SnakeProtocol {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var gameView:UIView?
    var mCubeController = CubeController()
    var timer = Timer()
    var mSnake = Snake()
    var turnPointDict:Dictionary<String,Direction>= Dictionary()
    var eatenPoints:[CGPoint] = []
    var currentScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameView = UIView.init(frame: CGRect(x: 0, y: (screenHeight - screenWidth)*0.5, width: screenWidth, height: screenWidth))
        gameView?.backgroundColor = UIColor.black
        self.view.addSubview(gameView!)
        
        mCubeController.createCubeIn(gameView!)
        
        mSnake.delegate = self
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.changeDirection(_:)))
        upSwipe.direction = .up
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.changeDirection(_:)))
        downSwipe.direction = .down
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.changeDirection(_:)))
        leftSwipe.direction = .left
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.changeDirection(_:)))
        rightSwipe.direction = .right
        
        self.view.addGestureRecognizer(upSwipe)
        self.view.addGestureRecognizer(downSwipe)
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
        
        gameReadyStart()
        
    }
    
    func snakeMove(_ sender :Timer) -> Void {
        mSnake.move()
    }

    
    
    func gameReadyStart(){
        let seconds = 1.0
        let delay = seconds * Double(NSEC_PER_SEC)
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector:#selector(ViewController.snakeMove(_:)) , userInfo: nil, repeats: true)
        }
    }
    
    
// MARK: IBAction
    
    @IBAction func restartBtnPress(_ sender: UIButton) {
        mSnake.reset()
        mCubeController.resetGame()
        timer.invalidate()
        gameReadyStart()
    }
    
    
// MARK: SnakeDelegate
    
    func snakeHeadWillEnter(_ point: CGPoint) {
        if point.x > 39 || point.x < 0 || point.y > 39 || point.y < 0{
            
            let alert = UIAlertController(title: "You Lose", message: "You piece of shit", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            timer.invalidate()
            
        }
        else if (mCubeController.getCubeByPoint(point)?.backgroundColor)! == UIColor.white &&
            !(mCubeController.getCubeByPoint(point)?.isHidden)! {
            
            let alert = UIAlertController(title: "You eat yourself", message: "You fucking pig", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            timer.invalidate()
            
        }
    }
    

    func snakeHeadDidEnter(_ point: CGPoint) {
        if mCubeController.getCubeByPoint(point)?.backgroundColor == UIColor.red {
            print("EAT")
            eatenPoints.append(point)
            mCubeController.createFoodCube()
        }
        mCubeController.getCubeByPoint(point)?.isHidden = false
        mCubeController.getCubeByPoint(point)?.backgroundColor = UIColor.white
        
    }
    
    
    func snakeTailDidEnter(_ point: CGPoint) {
        
        let key = String(describing: point.x) + String(describing: point.y)
        
        if let direction = turnPointDict[key] {
            mSnake.tailDirection = direction
            turnPointDict.removeValue(forKey: key)
        }
        
        if eatenPoints.contains(point) {
            mSnake.tailStayCount += 1
            eatenPoints.remove(at: eatenPoints.index(of: point)!)
        }
    }
    
    
    func snakeTailDidLeave(_ point: CGPoint) {
        mCubeController.getCubeByPoint(point)?.isHidden = true
    }
    
    
    func snakeGGGGG() {
        
    }
    
    // MARK: Swipe
    func changeDirection(_ gesture: UISwipeGestureRecognizer) -> Void {
        
        switch gesture.direction {
            
        case UISwipeGestureRecognizerDirection.up:
            
            if mSnake.headDirection == Direction.down {
                return
            }
            mSnake.headDirection = Direction.up
            
            
        case UISwipeGestureRecognizerDirection.down:
            
            if mSnake.headDirection == Direction.up {
                return
            }
            mSnake.headDirection = Direction.down
            
        case UISwipeGestureRecognizerDirection.left:
            
            if mSnake.headDirection == Direction.right {
                return
            }
            mSnake.headDirection = Direction.left
            
        case UISwipeGestureRecognizerDirection.right:
            
            if mSnake.headDirection == Direction.left {
                return
            }
            mSnake.headDirection = Direction.right
            
        default : break
        
        }
        
        let key = String(describing: mSnake.head.x) + String(describing: mSnake.head.y)
        turnPointDict.updateValue(mSnake.headDirection, forKey: key)
    }

}

