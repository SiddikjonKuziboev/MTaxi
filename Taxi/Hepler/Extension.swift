//
//  Extension.swift
//  Taxi
//
//  Created by Kuziboev Siddikjon on 12/17/21.
//

import UIKit

//MARK: - AddShadow to View
extension UIView {
    
    func addShadow(offset: CGSize, color: CGColor, radius: CGFloat, opacity: Float){
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color
    }
}

//MARK: - UINavigation Bar
extension UINavigationBar {
    func shouldRemoveShadow(_ value: Bool) -> Void {
        self.setValue(value, forKey: "hidesShadow")
    }
}
