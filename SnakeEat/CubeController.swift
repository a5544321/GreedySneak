//
//  CubeController.swift
//  SnakeEat
//
//  Created by CareTek on 2016/7/27.
//  Copyright © 2016年 Cheng. All rights reserved.
//

import Foundation
import UIKit

enum Direction {
    case up
    case down
    case left
    case right
}

class CubeController: NSObject {
    
    var cubesDict: Dictionary<String,CubeView>?
    override init() {
        super.init()
        cubesDict = Dictionary()
    }
    
    func createCubeIn(_ view:UIView) -> Void {
        let cubeSize = view.frame.width / 40.0
        for x in 0...39 {
            for y in 0...39 {
                let cube:CubeView = CubeView(frame: CGRect(x: CGFloat(x) * cubeSize,y: CGFloat(y) * cubeSize, width: cubeSize, height: cubeSize), point: CGPoint(x: CGFloat(x),y: CGFloat(y)))
                let key = String(describing: cube.point!.x) + String(describing: cube.point!.y)
//                print(key)
                view.addSubview(cube)
                cubesDict?.updateValue(cube, forKey: key)
            }
        }
        
        resetGame()
        
    }
    
    
    func resetGame() -> Void {
        for cube in cubesDict!.values {
            cube.backgroundColor = UIColor.white
            cube.isHidden = true
        }
        getCubeByPoint(CGPoint(x: 0, y: 0))?.isHidden = false
        getCubeByPoint(CGPoint(x: 1, y: 0))?.isHidden = false
        getCubeByPoint(CGPoint(x: 2, y: 0))?.isHidden = false
        
        createFoodCube()
        
    }
    
    
    func getCubeByPoint(_ point: CGPoint) -> CubeView? {
        
        let key = String(describing: point.x) + String(describing: point.y)
        
        if let resultCube = cubesDict![key] {
            return resultCube
        }
        print("No such fucking cube")
        return nil
    }
    
    
    func createFoodCube() {
        let ranX = CGFloat(arc4random_uniform(40))
        let ranY = CGFloat(arc4random_uniform(40))
        let key = String(describing: ranX) + String(describing: ranY)
        
        let cube = cubesDict![key]
        
        if cube!.isHidden {
            cube?.backgroundColor = UIColor.red
            cube?.isHidden = false
        }else{
            createFoodCube()
        }
        
    }
    
    
    
    
    
}
