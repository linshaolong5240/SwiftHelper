//
//  SHValueStepper.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/10/18.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

open class SHValueStepper: UIView {
    typealias ValueStringProvider = (Double) -> String

    private var valueStringProvider: ValueStringProvider

//    open var contentInsets: UIEdgeInsets = UIEdgeInsets.zero

    open var value: Double = 0 {    // default is 0. sends UIControlEventValueChanged. clamped to min/max
        didSet {
            updateView()
        }
    }
    open var minimumValue: Double = 0   // default 0. must be less than maximumValue
    open var maximumValue: Double = 100 // default 100. must be greater than minimumValue
    open var stepValue: Double = 1  // default 1. must be greater than 0
    
    open private(set) var valueField = UITextField()
    open private(set) var subButton = UIButton()
    open private(set) var addButton = UIButton()
    open private(set) var container = UIStackView()

//    // a background image which will be 3-way stretched over the whole of the control. Each half of the stepper will paint the image appropriate for its state
//    @available(iOS 6.0, *)
//    open func setBackgroundImage(_ image: UIImage?, for state: UIControl.State)
//
//    @available(iOS 6.0, *)
//    open func backgroundImage(for state: UIControl.State) -> UIImage?
//
//
//    // an image which will be painted in between the two stepper segments. The image is selected depending both segments' state
//    @available(iOS 6.0, *)
//    open func setDividerImage(_ image: UIImage?, forLeftSegmentState leftState: UIControl.State, rightSegmentState rightState: UIControl.State)
//
//    @available(iOS 6.0, *)
//    open func dividerImage(forLeftSegmentState state: UIControl.State, rightSegmentState state: UIControl.State) -> UIImage?
//
//
//    // the glyph image for the plus/increase button
//    @available(iOS 6.0, *)
//    open func setIncrementImage(_ image: UIImage?, for state: UIControl.State)
//
//    @available(iOS 6.0, *)
//    open func incrementImage(for state: UIControl.State) -> UIImage?
//
//
//    // the glyph image for the minus/decrease button
//    @available(iOS 6.0, *)
//    open func setDecrementImage(_ image: UIImage?, for state: UIControl.State)
//
//    @available(iOS 6.0, *)
//    open func decrementImage(for state: UIControl.State) -> UIImage?

    override init(frame: CGRect) {
        self.valueStringProvider = { value in String(format: "%d", Int(value)) }
        super.init(frame: frame)
        configureContentVIew()
    }
    
    init(frame: CGRect, valueStringProvider: @escaping (Double) -> String) {
        self.valueStringProvider = valueStringProvider
        super.init(frame: frame)
        configureContentVIew()
    }
    
    convenience init(valueStringProvider: @escaping (Double) -> String) {
        self.init(frame: .zero, valueStringProvider: valueStringProvider)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func configureContentVIew() {
        subButton.backgroundColor = .systemGray6
        subButton.layer.cornerRadius = 6
        subButton.setImage(UIImage(systemName: "minus"), for: .normal)
        subButton.addTarget(self, action: #selector(Self.subButtonOnClicked(button:event:)), for: .touchUpInside)
        
        valueField.textAlignment = .center
        valueField.isEnabled = false
        
        let hstack = UIStackView(arrangedSubviews: [subButton, valueField])
        hstack.axis = .horizontal
        hstack.spacing = 10
        hstack.distribution = .fill
        
        addButton.backgroundColor = .systemGray6
        addButton.layer.cornerRadius = 6
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.addTarget(self, action: #selector(Self.addButtonOnClicked(button:event:)), for: .touchUpInside)
        
        container.axis = .horizontal
        container.spacing = 10;
        container.distribution = .fill
        container.addArrangedSubview(hstack)
        container.addArrangedSubview(addButton)
        
        self.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        subButton.snp.remakeConstraints { make in
            make.width.equalTo(44)
        }

        addButton.snp.remakeConstraints { make in
            make.width.equalTo(44)
        }
        
        updateView()
    }
    
    private func updateView() {
        valueField.text = valueStringProvider(value)
        
        if 0 == value {
            subButton.isHidden = true;
            valueField.isHidden = true;
        } else {
            subButton.isHidden = false;
            valueField.isHidden = false;
        }
    }
    
    @objc func subButtonOnClicked(button: UIButton, event: UIControl.Event) {
        value = max(minimumValue, value - stepValue)
    }
    
    @objc func addButtonOnClicked(button: UIButton, event: UIControl.Event) {
        value = min(maximumValue, value + stepValue)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

#if DEBUG
struct SHStepperas_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewRepresent(SHValueStepper(frame: .zero, valueStringProvider: { value in String(format: "value: %d", Int(value)) }))
    }
}
#endif
