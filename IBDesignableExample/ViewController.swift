//
//  ViewController.swift
//  IBDesignableExample
//
//  Created by Sai Venkata Pranay Boggarapu on 1/15/20.
//  Copyright © 2020 Sai Venkata Pranay Boggarapu. All rights reserved.
// Example Courtesy: https://www.hackingwithswift.com/example-code/uikit/how-to-draw-custom-views-in-interface-builder-using-ibdesignable

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}


@IBDesignable class ColoredLabel: UILabel {
    
    @IBInspectable var strokeWidth: CGFloat = 0
    @IBInspectable var fillColor: UIColor = UIColor.black
    @IBInspectable var strokeColor: UIColor = UIColor.clear
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let rectangle = bounds.insetBy(dx: strokeWidth / 2, dy: strokeWidth / 2)
        
        context.setFillColor(fillColor.cgColor)
        context.setStrokeColor(strokeColor.cgColor)
        context.setLineWidth(strokeWidth)
        
        context.addEllipse(in: rectangle)
        context.drawPath(using: .fillStroke)
    }
}

public final class GenericTextField: NSObject, UITextFieldDelegate {
    @IBOutlet public var textField: UITextField? {
        didSet {
            textField?.delegate = self
            textField?.addTarget(self, action: #selector(textFieldValueEntered), for: .editingChanged)
        }
    }
    
    public var text: String? {
        get {
            return textField?.text
        }
        set {
            textField?.text = newValue
            // To get the validation executed.
            if let textField = textField {
                textFieldValueEntered(textField: textField)
            }
        }
    }
    
    @objc func textFieldValueEntered(textField: UITextField) {
        let maxIndex = text!.index(text!.startIndex, offsetBy: 30)
        let substring = text![..<maxIndex]
        textField.text = String(substring)
    }
}
