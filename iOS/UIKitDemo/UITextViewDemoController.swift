//
//  UITextViewDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/17.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit

class UITextViewDemoController: SHBaseViewController {
    private var textView: UITextView!
    private var scrollView: UIScrollView!
    
    private var inputContainer: UIStackView!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTextView()
    }
    
    private func configureTextView() {
        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
        self.scrollView = scrollView
        
        let contenView = UIStackView()
        contenView.axis = .vertical
        scrollView.addSubview(contenView)
        contenView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        textView = UITextView()
        textView.backgroundColor = .systemGray6
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        textView.textColor = .orange
        textView.font = .systemFont(ofSize: 20, weight: .bold)
        textView.text = "你知道，魔术师要是说穿了自己的把戏，别人就不会再夸赞他了。关于我的工作方法，要是我给你讲过多的话，你可能就会有这样的感觉这个福尔摩斯也不过如此，比一般人高明不到哪去。"
        textView.keyboardType = .default
        textView.returnKeyType = .default
        textView.isEditable = true
        textView.isSelectable = true
        textView.delegate = self
        
        let bottomBar = UIStackView.hstack(arrangedSubviews: [
            makeButton(systemImageName: "heart"),
            makeButton(systemImageName: "heart"),
            makeButton(systemImageName: "heart"),
            UIView()
        ], spacing: 10)

        let inputContainer = UIStackView(arrangedSubviews: [textView, bottomBar]);
        inputContainer.axis = .vertical;
        self.inputContainer = inputContainer;
        
        contenView.addArrangedSubview(UIView())
        contenView.addArrangedSubview(inputContainer)
        
        inputContainer.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
//
//        bottomBar.snp.makeConstraints { make in
//            make.height.equalTo(20)
//        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        let menu = UIMenuItem(title: "custom menu", action: #selector(menuOnCliked))
        UIMenuController.shared.menuItems = [menu]
    }
    
    private func makeButton(systemImageName: String) -> UIButton {
        let button = UIButton();
        button .setImage(UIImage(systemName: systemImageName), for: .normal)
        return button;
    }
    
    @objc func keyboardApear() {
#if DEBUG
print("\(#function)")
#endif
    }
    
    @objc func keyboardHidden() {
#if DEBUG
print("\(#function)")
#endif
    }
    
    @objc func keyboardWillChangeFrame() {
#if DEBUG
print("\(#function)")
#endif
    }
    
    @objc func menuOnCliked() {
        #if DEBUG
        print("\(#function)")
        #endif
    }
    
    static var keyBoardHeight: CGFloat = 0;
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

//        if notification.name == UIResponder.keyboardWillHideNotification {
//            self.scrollView.snp.remakeConstraints { make in
//                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
//                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)//.offset(-(keyboardViewEndFrame.height - view.safeAreaInsets.bottom))
//                make.left.right.equalToSuperview()
//            }
//        } else {
//            self.scrollView.snp.remakeConstraints { make in
//                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
//                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-(keyboardViewEndFrame.height - view.safeAreaInsets.bottom))
//                make.left.right.equalToSuperview()
//            }
//        }

        scrollView.scrollIndicatorInsets = scrollView.contentInset
        print("scrollView contentInset:\(scrollView.contentInset)")
        print("text frame:\(self.textView.frame)")
        scrollView.scrollRectToVisible(self.inputContainer.frame, animated: true)
//        let selectedRange = scrollView.selectedRange
//        scrollView.scrollRangeToVisible(selectedRange)
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
struct UITextViewDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(UITextViewDemoController()).ignoresSafeArea()
    }
}
#endif


extension UITextViewDemoController: UITextViewDelegate {
    //Responding to Editing Notifications
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        #if DEBUG
        print("\(#function)")
        #endif
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        #if DEBUG
        print("\(#function)")
        #endif
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        #if DEBUG
        print("\(#function)")
        #endif
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        #if DEBUG
        print("\(#function)")
        #endif
    }
    
    //Responding to Text Changes
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        #if DEBUG
        print("\(#function) range: \(range) replacementString: \(text)")
        #endif
        var result = false
        let string = text
        if let text = textView.text, let range = Range(range, in: text) {
            let newText = text.replacingCharacters(in: range, with: string)
            if newText.count < 10 {
               result = true
            }
        }
        return result
    }
        
    func textViewDidChange(_ textView: UITextView) {
        #if DEBUG
        print("\(#function)")
        #endif
    }
    
    //Responding to Selection Changes
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        #if DEBUG
        print("\(#function)")
        #endif
    }
    
    //Interacting with Text Data
    
//    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
//        #if DEBUG
//        print("\(#function)")
//        #endif
//        return true
//    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        #if DEBUG
        print("\(#function)")
        #endif
        return true
    }
}
