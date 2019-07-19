//
//  ShapeView.swift
//  CoreTextExploration
//
//  Created by Rebouh Aymen on 15/07/2019.
//  Copyright © 2019 Rebouh Aymen. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
import CoreText

class ShapeView: UIView {
    

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let text = "Hi there! I am a ShapeView! I am a big text which wants to be displayed into a giant circle at the top of the screen for this presentation because.. I don't know. Just do it. Say hi to everyone in the room by the way."
        
        let attributedString: NSAttributedString = .init(string: text, attributes: [
            .font: UIFont.boldSystemFont(ofSize: 22),
            .foregroundColor: UIColor.orange
        ])
        
        if let context =  UIGraphicsGetCurrentContext() {
            context.translateBy(x: 0, y: bounds.height)
            context.scaleBy(x: 1, y: -1)
            let circleShape = UIBezierPath(ovalIn: .init(x: bounds.width/2 - 150, y: bounds.height/2 - 150, width: 300, height: 300)).cgPath
            let frameSetter: CTFramesetter = CTFramesetterCreateWithAttributedString(attributedString)
            let frame = CTFramesetterCreateFrame(frameSetter, .init(location: 0, length: attributedString.length), circleShape, nil)
            CTFrameDraw(frame, context)
        }
    }
}
