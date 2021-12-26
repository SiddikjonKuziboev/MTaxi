//
//  HighlightButton.swift
//  Taxi
//
//  Created by Kuziboev Siddikjon on 12/16/21.
//

import UIKit

@IBDesignable
class HighlightButton: UIButton {

    @IBInspectable var normalBackgroundColor: UIColor? {
        didSet {
            backgroundColor = normalBackgroundColor
        }
    }

    @IBInspectable var highlightedBackgroundColor: UIColor?

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            if cornerRadius < 0 {
                layer.cornerRadius = frame.height / 2
            } else {
                layer.cornerRadius = cornerRadius
            }
        }
    }

    override var isHighlighted: Bool {
        didSet {
            if oldValue == false && isHighlighted {
                highlight()
            } else if oldValue == true && !isHighlighted {
                unHighlight()
            }
        }
    }

    var highlightDuration: TimeInterval = 0.25

    private func animateBackground(to color: UIColor?, duration: TimeInterval) {
        guard let color = color else { return }
        UIView.animate(withDuration: highlightDuration) {
            self.backgroundColor = color
        }
    }

    func highlight() {
        animateBackground(to: highlightedBackgroundColor, duration: highlightDuration)
    }

    func unHighlight() {
        animateBackground(to: normalBackgroundColor, duration: highlightDuration)
    }

}
