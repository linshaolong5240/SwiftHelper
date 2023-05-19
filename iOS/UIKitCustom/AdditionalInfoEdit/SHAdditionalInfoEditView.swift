//
//  SHAdditionalInfoEditView.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/10/31.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit

open class SHAdditionalInfoEditView: UIView {
    
    open private(set) var wordCount: Int = 0;
    open private(set) var maxWordCount: Int = 100;
    open private(set) var images = [UIImage]();

    open private(set) var textView = UITextView();
    open private(set) var wordCountLabel = UILabel();

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContentView()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContentView() {
        self.backgroundColor = UIColor.orange;
        textView.text = """
    航天事业的发展关系国家的前途命运，体现我国的综合国力及国际影响力。“祝融”探火、“嫦娥”奔月、“羲和”逐日、“梦天”升空……党的十八大以来，以习近平同志为核心的党中央在领导推进新时代中
"""
        textView.delegate = self
        let imagePickButton = UIButton()
        imagePickButton.setTitle("+", for: .normal)
        imagePickButton.titleLabel?.font = .systemFont(ofSize: 40, weight: .medium)
        imagePickButton.backgroundColor = UIColor.blue
        imagePickButton.addTarget(self, action: #selector(buttonOnClicked(button:event:)), for: .touchUpInside)
        
        let hstack = UIStackView(arrangedSubviews: [imagePickButton, UIView()])
        hstack.axis = .horizontal;
        
        imagePickButton.snp.makeConstraints { make in
            make.width.equalTo(50)
        }
        
        let vstack = UIStackView(arrangedSubviews: [textView, wordCountLabel, hstack])
        vstack.axis = .vertical
        vstack.spacing = 12;
        
        hstack.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        wordCountLabel.text = "\(textView.text.count)/\(maxWordCount)"
        wordCountLabel.textAlignment = .right
        
        self.addSubview(vstack)
        vstack.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(12)
        }
    }
    
    @objc open func buttonOnClicked(button: UIButton, event: UIControl.Event) {
        #if DEBUG
        print("\(#function)")
        #endif
    }
    
    private func updateUI() {
        wordCountLabel.text = "\(textView.text.count)/\(maxWordCount)"
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
struct SHAdditionalInfoEditView_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewRepresent(SHAdditionalInfoEditView())
    }
}
#endif

extension SHAdditionalInfoEditView: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        updateUI()
    }
}
