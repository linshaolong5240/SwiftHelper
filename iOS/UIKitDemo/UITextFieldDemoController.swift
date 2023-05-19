//
//  UITextFieldDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/16.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit

class UITextFieldDemoController: SHBaseViewController {
    private var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTextField()
    }
    
    private func configureTextField() {
        textField = UITextField()
        textField.placeholder = "placeholder"
//        textField.text = "你知道，魔术师要是说穿了自己的把戏，别人就不会再夸赞他了。关于我的工作方法，要是我给你讲过多的话，你可能就会有这样的感觉这个福尔摩斯也不过如此，比一般人高明不到哪去。"
        textField.textColor = .orange
        textField.backgroundColor = .gray
        textField.borderStyle = .roundedRect
//        textField.borderStyle = .line
//        textField.borderStyle = .bezel
        textField.clearButtonMode = .always
//        textField.clearButtonMode = .whileEditing
//        textField.clearButtonMode = .unlessEditing
//        textField.clearButtonMode = .never
        textField.keyboardType = .default
//        textField.keyboardType = .asciiCapable
//        textField.keyboardType = .asciiCapableNumberPad
//        textField.keyboardType = .numbersAndPunctuation
//        textField.keyboardType = .URL
//        textField.keyboardType = .numberPad
//        textField.keyboardType = .phonePad
//        textField.keyboardType = .namePhonePad
//        textField.keyboardType = .emailAddress
//        textField.keyboardType = .decimalPad
//        textField.keyboardType = .twitter
//        textField.keyboardType = .webSearch
        textField.returnKeyType = .default
        textField.returnKeyType = .go
        textField.returnKeyType = .google
        textField.returnKeyType = .join
        textField.returnKeyType = .next
        textField.returnKeyType = .route
        textField.returnKeyType = .search
        textField.returnKeyType = .send
        textField.returnKeyType = .yahoo
        textField.returnKeyType = .done
        textField.returnKeyType = .emergencyCall
        textField.returnKeyType = .continue
        textField.delegate = self
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(20)
        }
    }
    
    private func updateText(_ text: String) {
        textField.text = text
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

#if DEBUG
struct UITextFieldDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(UITextFieldDemoController()).ignoresSafeArea()
    }
}
#endif

extension UITextFieldDemoController: UITextFieldDelegate {
    //Managing Editing
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        #if DEBUG
        print("\(#function)")
        #endif
        return true
//        false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        #if DEBUG
        print("\(#function)")
        #endif
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        #if DEBUG
        print("\(#function)")
        #endif
        return true
//        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        #if DEBUG
        print("\(#function) reason: UITextField.DidEndEditingReason \(reason.rawValue)")
        #endif
    }
    
    //Editing the Text Field’s Text
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        #if DEBUG
        print("\(#function) range: \(range) replacementString: \(string)")
        #endif

        var result = false

        if let text = textField.text, let range = Range(range, in: text) {
            let newText = text.replacingCharacters(in: range, with: string)
            if newText.count < 10 {
               result = true
            }
        }
        return result
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        #if DEBUG
        print("\(#function)")
        #endif
        return textField.text?.count ?? 0 > 5 ? true : false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        #if DEBUG
        print("\(#function)")
        #endif
        return true
    }
    
    //Managing Text Selection
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        #if DEBUG
        print("\(#function)")
        #endif
    }
}
