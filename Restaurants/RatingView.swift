//
//  RatingView.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/12/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

class RatingView: UIControl {
    
    let solidImage = UIImage(named:"star-solid")!
    let strokedImage = UIImage(named:"star-stroked")!
    
    private var buttons: [UIButton] = []
    
    private var buttonSpacing: CGFloat {
        return buttonSize.width * 0.3
    }
    
    private var buttonSize: CGSize {
        return CGSize(width: bounds.height, height: bounds.height)
    }
    
    var rating: Rating? {
        didSet {
            for subview in subviews {
                subview.removeFromSuperview()
            }
            buttons = []
            
            guard let rating = rating else {
                return
            }
            for i in 0..<rating.total {
                let button = UIButton(type: .custom)
                let image: UIImage
                if i >= rating.current {
                    image = strokedImage
                } else {
                    image = solidImage
                }
                button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
                button.tintColor = Color.orange
                buttons.append(button)
                button.isUserInteractionEnabled = isUserInteractionEnabled
                addSubview(button)
            }
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }
    
    private func animateTo(index endIndex: Int) {
        for i in 0...endIndex {
            let button = buttons[i]
            let scale: CGFloat = 1.4
            button.transform = CGAffineTransform(scaleX: scale, y: scale)
            UIView.animate(
                withDuration: 0.65,
                delay: TimeInterval(i) * 0.05,
                usingSpringWithDamping: 0.4,
                initialSpringVelocity: 0.3,
                options: [],
                animations: {
                    button.transform = CGAffineTransform.identity
                },
                completion: nil
            )
        }
    }
    
    // MARK: - UIView
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for i in 0..<buttons.count {
            let button = buttons[i]
            let frame = CGRect(
                x: CGFloat(i) * (buttonSize.width + buttonSpacing),
                y: 0,
                width: buttonSize.width,
                height: buttonSize.height
            )
            button.frame = frame
        }
    }
    
    /// Defines the size needed for autolayout calculations.  This allows the view to be
    /// properly position with constraints in interface builder, but internally can
    /// use frames and bounds to precisely layout its subviews.
    override var intrinsicContentSize: CGSize {
        return CGSize(
            width: CGFloat(buttons.count) * (buttonSize.width) + buttonSpacing * CGFloat(buttons.count-1),
            height: buttonSize.height
        )
    }
}
