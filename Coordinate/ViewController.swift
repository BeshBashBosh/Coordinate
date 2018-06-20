//
//  ViewController.swift
//  Coordinate
//
//  Created by Developer on 20/06/2018.
//  Copyright © 2018 beshbashbosh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var positionLabel: UILabel?
    var subviewPositionLabel: UILabel?
    var squareView: UIView?
    
    var text: String? = "" {
        willSet {
            positionLabel?.text = newValue
        }
    }
    
    var subviewText: String? = "" {
        willSet {
            subviewPositionLabel?.text = newValue ?? "Not in Square"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .red
        let screenFrame = UIScreen.main.bounds
        
        positionLabel = initLabel(frame: CGRect(x: screenFrame.width/2 - (200/2),
                                                y: screenFrame.height - 80,
                                                width: 200, height: 20),
                                  text: "x:, y:",
                                  alignment: .center,
                                  color: .clear)
        
        subviewPositionLabel = initLabel(frame: CGRect(x: screenFrame.width/2 - (200/2),
                                                       y: screenFrame.height - 50,
                                                       width: 200, height: 20),
                                         text: "x:, y:", alignment: .center,
                                         color: .clear)
        
        
        initSquareView(frame: CGRect(x: screenFrame.width/2 - (200/2),
                                     y: screenFrame.height/2 - (200/2),
                                     width: 200, height: 200))
        
        view.addSubview(positionLabel!)
        view.addSubview(subviewPositionLabel!)

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        parsePosition(position: touch.location(in: view))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        parsePosition(position: touch.location(in: view))
    }
    
    private func parsePosition(position: CGPoint) {
        var positionInSubview: CGPoint?
        
        if let square = squareView, square.frame.contains(position) {
            positionInSubview = square.convert(position, from: self.view)
        }
        
        text = "x: \(position.x.rounded()), y: \(position.y.rounded())"
        guard let squarePosition = positionInSubview else {
            subviewText = "Not in square"
            return
        }
        subviewText = "x: \(squarePosition.x.rounded()), y: \(squarePosition.y.rounded())"
    }

    private func initLabel(frame: CGRect, text: String?, alignment: NSTextAlignment, color: UIColor) -> UILabel? {
        var label: UILabel?
        label = UILabel(frame: frame)
        label?.text = text ?? ""
        label?.textAlignment = alignment
        label?.backgroundColor = color
        return label
    }
    
    private func initSquareView(frame: CGRect) {
        squareView = UIView(frame: frame)
        squareView?.backgroundColor = .green
        squareView?.layer.borderColor = UIColor.black.cgColor
        view.addSubview(squareView!)
    }
}

