//
//  CircularView.swift
//  FitnessApp
//
//  Created by Булат Хатмуллин on 13.04.2022.
//

import Foundation
import UIKit

class CircularView: UIView{
    
    var percent: Double = 0.0
    var lineColor: UIColor?
    var lineWidth = 10.0
    var backgroundLineColor: UIColor?
    var backgroundLineWidth = 10.0
    let shapeLayer = CAShapeLayer()


    override init(frame: CGRect){

        super.init(frame: frame)

    }

    required init?(coder: NSCoder) {

        super.init(coder: coder)

    }

    override func draw(_ rect: CGRect) {
              drawBackRingFittingInsideView(lineWidth: CGFloat(backgroundLineWidth),
    lineColor: backgroundLineColor ?? .lightGray)
              if percent > 0 {
                  percent = min(100, percent)
                  drawRingFittingInsideView(lineWidth: CGFloat(lineWidth),
    lineColor: lineColor ?? .blue, percent: CGFloat(percent))
              }
        }
    
    func drawBackRingFittingInsideView(lineWidth: CGFloat, lineColor: UIColor) {
        let halfSize:CGFloat = min( bounds.size.width/2, bounds.size.height/2)
        let desiredLineWidth:CGFloat = lineWidth
        let circle = CGFloat(Double.pi * 2)
        let startAngle = CGFloat(circle * 0.1)
        let endAngle = circle - startAngle
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x:halfSize, y:halfSize),
            radius: CGFloat( halfSize - (desiredLineWidth/2) ),
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        let shapeBackLayer = CAShapeLayer()
            shapeBackLayer.path = circlePath.cgPath
            shapeBackLayer.fillColor = UIColor.clear.cgColor
            shapeBackLayer.strokeColor = lineColor.cgColor
            shapeBackLayer.lineWidth = desiredLineWidth
            shapeBackLayer.lineCap = .round
        layer.addSublayer(shapeBackLayer)
    }
    func drawRingFittingInsideView(lineWidth: CGFloat, lineColor: UIColor, percent: CGFloat) {
        let halfSize:CGFloat = min( bounds.size.width/2, bounds.size.height/2)
        let desiredLineWidth:CGFloat = lineWidth
        
        let circle = CGFloat(Double.pi * 2)
        let startAngle = CGFloat(circle * 0.1)
        let maxEndAngle = circle - (startAngle * 2)
        let endAngle = ((maxEndAngle * percent) / 100) + startAngle
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x:halfSize, y:halfSize),
            radius: CGFloat( halfSize - (desiredLineWidth/2) ),
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
            shapeLayer.path = circlePath.cgPath
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = lineColor.cgColor
            shapeLayer.lineWidth = desiredLineWidth
            shapeLayer.lineCap = .round
        layer.addSublayer(shapeLayer)
    }
    
    func animateCircle(duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        shapeLayer.strokeEnd = 1.0
        shapeLayer.add(animation, forKey: "animateCircle")
    }

}
