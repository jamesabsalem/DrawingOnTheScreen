//
//  ViewController.swift
//  Drawing
//
//  Created by LIN2 on 7/5/19.
//  Copyright © 2019 LIN2. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var lastPoint = CGPoint.zero
    var swiped = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first as UITouch? {
            lastPoint = touch.location(in: self.view)
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first as UITouch? {
           let currentPoint = touch.location(in: view)
            drawLine(lastPoint, toPoint: currentPoint)
            lastPoint = currentPoint
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLine(lastPoint, toPoint: lastPoint)
        }
    }
    func drawLine(_ fromPoint: CGPoint, toPoint: CGPoint){
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(10)
        context?.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1)
        context?.setBlendMode(CGBlendMode.normal)
        context?.strokePath()
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext() 	
    }

}

