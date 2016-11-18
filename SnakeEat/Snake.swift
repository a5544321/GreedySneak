//
//  Snake.swift
//  SnakeEat
//
//  Created by CareTek on 2016/7/27.
//  Copyright © 2016年 Cheng. All rights reserved.
//

import Foundation
import UIKit

protocol SnakeProtocol {
    func snakeHeadWillEnter(_ point: CGPoint)
    func snakeHeadDidEnter(_ point: CGPoint)
    func snakeTailDidEnter(_ point: CGPoint)
    func snakeTailDidLeave(_ point: CGPoint)
    func snakeGGGGG()
}
class Snake: NSObject {
    var delegate: SnakeProtocol?
    
    var head = CGPoint(x: 2, y: 0)
    var headDirection = Direction.right
    var tail = CGPoint(x: 0, y: 0)
    var tailDirection = Direction.right
    var tailStayCount:Int = 0
    
    
    override init() {
        super.init()
    }
    
    func move() -> Void {
        
        switch headDirection {
        case .up:
            head.y -= 1
        case .down:
            head.y += 1
        case .left:
            head.x -= 1
        case .right:
            head.x += 1
        }
        delegate?.snakeHeadWillEnter(head)
        delegate?.snakeHeadDidEnter(self.head)
        
        print("head \(head)")
        
        if tailStayCount > 0 {
            tailStayCount -= 1
        }else{
            let oldTail = self.tail
            
            switch tailDirection {
            case .up:
                tail.y -= 1
            case .down:
                tail.y += 1
            case .left:
                tail.x -= 1
            case .right:
                tail.x += 1
            }
            
            delegate?.snakeTailDidEnter(self.tail)
            delegate?.snakeTailDidLeave(oldTail)
        }
        
    }
    
    
    func reset()  {
        head = CGPoint(x: 2, y: 0)
        tail = CGPoint(x: 0, y: 0)
        headDirection = Direction.right
        tailDirection = .right
    }
    
    
    
    
}
