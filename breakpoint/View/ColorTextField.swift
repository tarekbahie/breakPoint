//
//  ColorTextField.swift
//  breakpoint
//
//  Created by tarek bahie on 12/27/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

@IBDesignable class ColorTextField: UITextField {
    
    private var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    
    
    override func awakeFromNib() {
        if let p = placeholder  {
            let place = NSAttributedString(string: p, attributes: [.foregroundColor : UIColor.white])
            attributedPlaceholder = place
        super.awakeFromNib()
    }
    
    
}
}
