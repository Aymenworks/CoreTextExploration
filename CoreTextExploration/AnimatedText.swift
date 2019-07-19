//
//  MagazineView.swift
//  CoreTextExploration
//
//  Created by Rebouh Aymen on 17/07/2019.
//  Copyright © 2019 Rebouh Aymen. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
import CoreText

class AnimatedText: UIView {
    
    let textToDraw = "AYMEN"

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        drawLetters()
    }
    
    func drawLetters() {
        let font = UIFont.systemFont(ofSize: 80)
        var glyphs: [CGGlyph] = .init(repeating: 0, count: textToDraw.count)
        CTFontGetGlyphsForCharacters(font, Array(textToDraw.utf16), &glyphs, glyphs.count)

        print(glyphs)
        for (index, glyph) in glyphs.enumerated() {
            let path = CTFontCreatePathForGlyph(font, glyph, nil)
            drawLetter2(path: path!, forIndex: index)
        }
    }
    
    func drawLetter2(path: CGPath, forIndex index: Int) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.isGeometryFlipped = true
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.strokeEnd = 0
        shapeLayer.path = path
        
        let margin: CGFloat = 40
        let usableWidth = bounds.width - (margin*CGFloat(textToDraw.count+1))
        let letterWidth: CGFloat = usableWidth/CGFloat(textToDraw.count)
        let x = (CGFloat(index) * margin + margin/2.0) + (CGFloat(index) * letterWidth)
        shapeLayer.frame = CGRect(x: x, y: bounds.height/2.0 - path.boundingBox.height/2.0, width: letterWidth, height: path.boundingBox.height)
      
        self.layer.addSublayer(shapeLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1.5
        animation.beginTime = CACurrentMediaTime() + animation.duration * CFTimeInterval(index)
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        shapeLayer.add(animation, forKey: "\(index)")
    }
}
