//
//  CubeView.swift
//  SnakeEat
//
//  Created by CareTek on 2016/7/27.
//  Copyright © 2016年 Cheng. All rights reserved.
//

import UIKit

class CubeView: UIView {
    var point:CGPoint?
    
    init(frame: CGRect , point: CGPoint) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.isHidden = true
        self.point = point
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
