//
//  AttributedStringDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/9.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit

class AttributedStringDemoController: SHBaseViewController {
    private var container: UIStackView!
    private var label1: UILabel!
    private var label2: UILabel!
    private var label3: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        navigationItem.largeTitleDisplayMode = .never
        title = "AttributedStringDemo"
        configureConatiner()
        configureLabel1()
        configureLabel2()
        configureLabel3()
    }
    
    private func configureConatiner() {
        container = UIStackView(frame: .zero)
        container.axis = .vertical
        container.spacing = 10
        container.distribution = .fillEqually
        view.addSubview(container)
        container.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func configureLabel1() {
        let str1 = "aaaa"
        let str2 = "bbbb"
        let str3 = "cccc"
        let text = str1 + str2 + str3
        let attrString = NSMutableAttributedString(string: text)

        let attr1: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 20, weight: .bold),
                                                     .backgroundColor: UIColor.blue,
                                                     .foregroundColor: UIColor.red,]
        attrString.addAttributes(attr1, range: NSRange(location: 0, length: str1.count))
        let attr2: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 30, weight: .bold),.foregroundColor: UIColor.green]
        attrString.addAttributes(attr2, range: NSRange(location: str1.count, length: str2.count))
        let attr3: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 40, weight: .bold),.foregroundColor: UIColor.blue]
        attrString.addAttributes(attr3, range: NSRange(location: str1.count + str2.count, length: str2.count))

        label1 = UILabel()
        label1.attributedText = attrString
        container.addArrangedSubview(label1)
    }
    
    private func configureLabel2() {
        let str1 = "aaaa"
        let str2 = "bbbb"
        let str3 = "cccc"
        let attr1: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 20, weight: .bold),
                                                     .backgroundColor: UIColor.blue,
                                                     .foregroundColor: UIColor.red,]
        let attr2: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 30, weight: .bold),.foregroundColor: UIColor.green]
        let attr3: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 40, weight: .bold),.foregroundColor: UIColor.blue]
        let attrString = NSMutableAttributedString(string: str1, attributes: attr1)
        attrString.append(NSAttributedString(string: str2, attributes: attr2))
        attrString.append(NSAttributedString(string: str3, attributes: attr3))

        label2 = UILabel()
        label2.attributedText = attrString
        container.addArrangedSubview(label2)
    }
    
    private func configureLabel3() {
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        style.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        let title: String = "Title"
        let subtitle: String = "SubTitle"

        let titleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.label,
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: UIFont.TextStyle.largeTitle),
            NSAttributedString.Key.paragraphStyle : style
        ]
        let subtitleAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.label,
            NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body),
            NSAttributedString.Key.paragraphStyle : style
        ]

        let attributedString = NSMutableAttributedString(string: title, attributes: titleAttributes)
        attributedString.append(NSAttributedString(string: "\n"))
        attributedString.append(NSAttributedString(string: subtitle, attributes: subtitleAttributes))

        label3 = UILabel()
        label3.numberOfLines = 0
        label3.attributedText = attributedString
        container.addArrangedSubview(label3)
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
struct AttributedStringDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(AttributedStringDemoController()).ignoresSafeArea()
    }
}
#endif
