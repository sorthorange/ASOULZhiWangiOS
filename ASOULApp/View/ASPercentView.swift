//

//
//  ASPercentView.swift
//  ASOULApp
//
//  Created by southorange on 2021/9/9.
//  
//
    

import UIKit

class ASPercentView: UIView {
    
    /// 百分比 0-1
    var percent: CGFloat = 0 {
        didSet {
            circleLayer.strokeEnd = percent
        }
    }
    
    private lazy var circleLayer = CAShapeLayer().then { layer in
        layer.lineWidth = 3
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = #colorLiteral(red: 0.01430185419, green: 0.7025176883, blue: 0.5647537112, alpha: 1).cgColor
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.addSublayer(circleLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 绘制百分比
    override func layoutSubviews() {
        super.layoutSubviews()
        circleLayer.frame = bounds
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: frame.width / 2, y: frame.height / 2), radius: frame.width * 0.4, startAngle: CGFloat.pi * (-90 / 180), endAngle: CGFloat.pi * (270 / 180), clockwise: true)
        circleLayer.path = path.cgPath
        circleLayer.strokeEnd = percent
    }
}
