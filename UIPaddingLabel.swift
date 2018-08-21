//
//  UIPaddingLabel.swift
//
//  Created by bibek timalsina on 8/21/18.
//  Copyright © 2018 bibek. All rights reserved.
//

import UIKit

@IBDesignable
class UIPaddingLabel: UIView {
    
    private let label: UILabel = UILabel()
    
    var inset: UIEdgeInsets = .zero
    {
        didSet {
            topConstraintOfLabel.constant = inset.top
            bottomConstraintOfLabel.constant = -inset.bottom
            rightConstraintOfLabel.constant = -inset.right
            leftConstraintOfLabel.constant = inset.left
            label.layoutIfNeeded()
        }
    }
    
    private lazy var topConstraintOfLabel: NSLayoutConstraint = {
        return label.topAnchor.constraint(equalTo: topAnchor, constant: inset.top)
    }()
    private lazy var bottomConstraintOfLabel: NSLayoutConstraint = {
        return label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset.bottom)
    }()
    private lazy var rightConstraintOfLabel: NSLayoutConstraint = {
        return label.rightAnchor.constraint(equalTo: rightAnchor, constant: -inset.right)
    }()
    private lazy var leftConstraintOfLabel: NSLayoutConstraint = {
        return label.leftAnchor.constraint(equalTo: leftAnchor, constant: inset.left)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addLabel()
    }
    
    private func addLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        addLabelConstraint()
    }
    
    private func addLabelConstraint() {
        NSLayoutConstraint.activate([
            leftConstraintOfLabel, rightConstraintOfLabel, topConstraintOfLabel, bottomConstraintOfLabel
            ])
    }
    
    @IBInspectable var text: String? // default is nil
     {
        get {
            return label.text
        }
        set {
           label.text = newValue
        }
    }
    
    @IBInspectable var font: UIFont! // default is nil (system font 17 plain)
        {
        get {
            return label.font
        }
        set {
            label.font = newValue
        }
    }
    
    @IBInspectable var textColor: UIColor! // default is nil (text draws black)
        {
        get {
            return label.textColor
        }
        set {
            label.textColor = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor? // default is nil (no shadow)
        {
        get {
            return label.shadowColor
        }
        set {
            label.shadowColor = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize // default is CGSizeMake(0, -1) -- a top shadow
        {
        get {
            return label.shadowOffset
        }
        set {
            label.shadowOffset = newValue
        }
    }
    
    @IBInspectable var textAlignment: NSTextAlignment // default is NSTextAlignmentNatural (before iOS 9, the default was NSTextAlignmentLeft)
        {
        get {
            return label.textAlignment
        }
        set {
            label.textAlignment = newValue
        }
    }
    
    @IBInspectable var lineBreakMode: NSLineBreakMode // default is NSLineBreakByTruncatingTail. used for single and multiple lines of text
        {
        get {
            return label.lineBreakMode
        }
        set {
            label.lineBreakMode = newValue
        }
    }
    
    
    // the underlying attributed string drawn by the label, if set, the label ignores the properties above.
    var attributedText: NSAttributedString? // default is nil
        {
        get {
            return label.attributedText
        }
        set {
            label.attributedText = newValue
        }
    }
    
    // the 'highlight' property is used by subclasses for such things as pressed states. it's useful to make it part of the base class as a user property
    
    @IBInspectable var highlightedTextColor: UIColor? // default is nil
        {
        get {
            return label.highlightedTextColor
        }
        set {
            label.highlightedTextColor = newValue
        }
    }
    
   @IBInspectable var isHighlighted: Bool // default is NO
        {
        get {
            return label.isHighlighted
        }
        set {
            label.isHighlighted = newValue
        }
    }
    
   @IBInspectable var isEnabled: Bool // default is YES. changes how the label is drawn
        {
        get {
            return label.isEnabled
        }
        set {
            label.isEnabled = newValue
        }
    }
    
    // this determines the number of lines to draw and what to do when sizeToFit is called. default value is 1 (single line). A value of 0 means no limit
    // if the height of the text reaches the # of lines or the height of the view is less than the # of lines allowed, the text will be
    // truncated using the line break mode.
    
    @IBInspectable var numberOfLines: Int
        {
        get {
            return label.numberOfLines
        }
        set {
            label.numberOfLines = newValue
        }
    }
    
    // these next 3 properties allow the label to be autosized to fit a certain width by scaling the font size(s) by a scaling factor >= the minimum scaling factor
    // and to specify how the text baseline moves when it needs to shrink the font.
    
    @IBInspectable var adjustsFontSizeToFitWidth: Bool // default is NO
        {
        get {
            return label.adjustsFontSizeToFitWidth
        }
        set {
            label.adjustsFontSizeToFitWidth = newValue
        }
    }
    
    @IBInspectable var baselineAdjustment: UIBaselineAdjustment // default is UIBaselineAdjustmentAlignBaselines
        {
        get {
            return label.baselineAdjustment
        }
        set {
            label.baselineAdjustment = newValue
        }
    }
    
    @IBInspectable var minimumScaleFactor: CGFloat // default is 0.0
        {
        get {
            return label.minimumScaleFactor
        }
        set {
            label.minimumScaleFactor = newValue
        }
    }
    
    // Tightens inter-character spacing in attempt to fit lines wider than the available space if the line break mode is one of the truncation modes before starting to truncate.
    // The maximum amount of tightening performed is determined by the system based on contexts such as font, line width, etc.
    @IBInspectable var allowsDefaultTighteningForTruncation: Bool // default is NO
    {
        get {
            return label.allowsDefaultTighteningForTruncation
        }
        set {
            label.allowsDefaultTighteningForTruncation = newValue
        }
    }
    
    // override points. can adjust rect before calling super.
    // label has default content mode of UIViewContentModeRedraw
    
    func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        return label.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
    }
    
    // Support for constraint-based layout (auto layout)
    // If nonzero, this is used when determining -intrinsicContentSize for multiline labels
    var preferredMaxLayoutWidth: CGFloat
    {
        get {
            return label.preferredMaxLayoutWidth
        }
        set {
            label.preferredMaxLayoutWidth = newValue
        }
    }
    
    override var intrinsicContentSize: CGSize {
        var labelSize = label.intrinsicContentSize
        labelSize.height += (inset.top + inset.bottom)
        labelSize.width += (inset.left + inset.right)
        return labelSize
    }
    
    @IBInspectable var bottomInset: CGFloat
        {
        get {
            return inset.bottom
        }
        set {
            inset.bottom = newValue
        }
    }
    
    @IBInspectable var topInset: CGFloat
        {
        get {
            return inset.top
        }
        set {
            inset.top = newValue
        }
    }
    
    @IBInspectable var leftInset: CGFloat
        {
        get {
            return inset.left
        }
        set {
            inset.left = newValue
        }
    }
    
    @IBInspectable var rightInset: CGFloat
        {
        get {
            return inset.right
        }
        set {
            inset.right = newValue
        }
    }
}
