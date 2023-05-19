//
//  UIStackViewDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/13.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit

class UIStackViewDemoController: SHBaseViewController {
    private var container: UIStackView!
    private var container1: UIStackView!
    private var container2: UIStackView!
    private var container3: UIStackView!
    private var container4: UIStackView!
    private var container5: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UIStackView"
        self.configureView()
    }
    
    private func configureView() {
        let vstack = UIStackView(arrangedSubviews: [
            {
                let v1 = UILabel()
                v1.text = "fill"
                v1.backgroundColor = .systemPink
                let v2 = UIView()
                v2.backgroundColor = .orange
                let v3 = UIView()
                v3.backgroundColor = .purple
                
                v1.snp.makeConstraints { make in
                    make.width.equalTo(50)
                }
                
                v2.snp.makeConstraints { make in
                    make.width.equalTo(100)
                }
                
                let hstack = UIStackView(arrangedSubviews: [v1, v2, v3])
                hstack.backgroundColor = .yellow
                hstack.axis = .horizontal
                hstack.spacing = 10
                hstack.distribution = .fill
                return hstack
            }(),
            {
                let v1 = UILabel()
                v1.text = "fillEqually"
                v1.backgroundColor = .systemPink
                let v2 = UIView()
                v2.backgroundColor = .orange
                let v3 = UIView()
                v3.backgroundColor = .purple
                let hstack = UIStackView(arrangedSubviews: [v1, v2, v3])
                hstack.backgroundColor = .yellow
                hstack.axis = .horizontal
                hstack.spacing = 10
                hstack.distribution = .fillEqually
                return hstack
            }(),
            {
                let v1 = UILabel()
                v1.text = "fillProportionally"
                v1.backgroundColor = .systemPink
                let v2 = UIView()
                v2.backgroundColor = .orange
                let v3 = UIView()
                v3.backgroundColor = .purple
                v1.snp.makeConstraints { make in
                    make.width.equalTo(10)
                }
                v2.snp.makeConstraints { make in
                    make.width.equalTo(30)
                }
                v3.snp.makeConstraints { make in
                    make.width.equalTo(60)
                }
                let hstack = UIStackView(arrangedSubviews: [v1, v2, v3])
                hstack.backgroundColor = .yellow
                hstack.axis = .horizontal
                hstack.spacing = 10
                hstack.distribution = .fillProportionally
                return hstack
            }(),
            {
                let v1 = UILabel()
                v1.text = "equalSpacing"
                v1.backgroundColor = .systemPink
                let v2 = UIView()
                v2.backgroundColor = .orange
                let v3 = UIView()
                v3.backgroundColor = .purple
                let hstack = UIStackView(arrangedSubviews: [v1, v2, v3])
                hstack.backgroundColor = .yellow
                hstack.axis = .horizontal
                hstack.spacing = 10
                hstack.distribution = .equalSpacing
                v1.snp.makeConstraints { make in
                    make.width.equalTo(150)
                }
                v2.snp.makeConstraints { make in
                    make.width.equalTo(50)
                }
                v3.snp.makeConstraints { make in
                    make.width.equalTo(100)
                }
                return hstack
            }(),
            {
                let v1 = UILabel()
                v1.text = "equalCentering"
                v1.backgroundColor = .systemPink
                let v2 = UIView()
                v2.backgroundColor = .orange
                let v3 = UIView()
                v3.backgroundColor = .purple
                let hstack = UIStackView(arrangedSubviews: [v1, v2, v3])
                hstack.backgroundColor = .yellow
                hstack.axis = .horizontal
                hstack.spacing = 10
                hstack.distribution = .equalCentering
                v1.snp.makeConstraints { make in
                    make.width.equalTo(150)
                }
                v2.snp.makeConstraints { make in
                    make.width.equalTo(50)
                }
                v3.snp.makeConstraints { make in
                    make.width.equalTo(100)
                }
                return hstack
            }(),
        ])
        vstack.backgroundColor = .blue
        vstack.axis = .vertical
        vstack.spacing = 10;
        vstack.distribution = .fillEqually
        view.addSubview(vstack)
        vstack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func configureContainer() {
        container = UIStackView()
        container.backgroundColor = .blue
        container.axis = .vertical
        container.spacing = 10
        container.distribution = .fillEqually
        view.addSubview(container)
        container.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func configureContainer1() {
        container1 = UIStackView()
        container1.backgroundColor = .yellow
        container1.axis = .horizontal
        container1.distribution = .fill
        container1.spacing = 10
        container.addArrangedSubview(container1)
        
        let v1 = UILabel()
        v1.text = "fill"
        v1.backgroundColor = .systemPink
        let v2 = UIView()
        v2.backgroundColor = .orange
        let v3 = UIView()
        v3.backgroundColor = .purple
        container1.addArrangedSubview(v1)
        v1.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        container1.addArrangedSubview(v2)
        v2.snp.makeConstraints { make in
            make.width.equalTo(200)
        }
        container1.addArrangedSubview(v3)
    }
    
    private func configureContainer2() {
        container2 = UIStackView()
        container2.backgroundColor = .yellow
        container2.axis = .horizontal
        container2.distribution = .fillEqually
        container2.spacing = 10
        container.addArrangedSubview(container2)
        
        let v1 = UILabel()
        v1.text = "fillEqually"
        v1.backgroundColor = .systemPink
        let v2 = UIView()
        v2.backgroundColor = .orange
        let v3 = UIView()
        v3.backgroundColor = .purple
        container2.addArrangedSubview(v1)
        container2.addArrangedSubview(v2)
        container2.addArrangedSubview(v3)
    }
    
    private func configureContainer3() {
        container3 = UIStackView()
        container3.backgroundColor = .yellow
        container3.axis = .horizontal
        container3.distribution = .fillProportionally
        container3.spacing = 10
        container.addArrangedSubview(container3)
        
        let v1 = UIView()
        v1.backgroundColor = .systemPink
        let v2 = UIView()
        v2.backgroundColor = .orange
        let v3 = UIView()
        v3.backgroundColor = .purple
        container3.addArrangedSubview(v1)
        v1.snp.makeConstraints { make in
            make.width.equalTo(10)
        }
        container3.addArrangedSubview(v2)
        v2.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        container3.addArrangedSubview(v3)
        v3.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
    }
    
    private func configureContainer4() {
        container4 = UIStackView()
        container4.backgroundColor = .yellow
        container4.axis = .horizontal
        container4.distribution = .equalSpacing
        container4.alignment = .top
//        container4.spacing = 10
        container.addArrangedSubview(container4)
        
        let v1 = UILabel()
        v1.numberOfLines = 0
        v1.text = "equalSpacing alignment = .top"
        v1.backgroundColor = .systemPink
        let v2 = UILabel()
        v2.numberOfLines = 0
        v2.text = "equalSpacing"
        v2.backgroundColor = .orange
        let v3 = UILabel()
        v3.numberOfLines = 0
        v3.text = "equalSpacing"
        v3.backgroundColor = .purple
        container4.addArrangedSubview(v1)
        v1.snp.makeConstraints { make in
            make.width.equalTo(150)
        }
        container4.addArrangedSubview(v2)
        v2.snp.makeConstraints { make in
            make.width.equalTo(50)
        }
        container4.addArrangedSubview(v3)
        v3.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
    }
    
    private func configureContainer5() {
        container5 = UIStackView()
        container5.backgroundColor = .yellow
        container5.axis = .horizontal
        container5.alignment = .bottom
        container5.distribution = .equalCentering
//        container4.spacing = 10
        container.addArrangedSubview(container5)
        
        let v1 = UILabel()
        v1.numberOfLines = 0
        v1.text = "equalCentering alignment = .bottom"
        v1.backgroundColor = .systemPink
        let v2 = UILabel()
        v2.numberOfLines = 0
        v2.text = "equalCentering"
        v2.backgroundColor = .orange
        let v3 = UILabel()
        v3.numberOfLines = 0
        v3.text = "equalCentering"
        v3.backgroundColor = .purple
        container5.addArrangedSubview(v1)
        v1.snp.makeConstraints { make in
            make.width.equalTo(150)
        }
        container5.addArrangedSubview(v2)
        v2.snp.makeConstraints { make in
            make.width.equalTo(50)
        }
        container5.addArrangedSubview(v3)
        v3.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
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
struct UIStackViewDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(UIStackViewDemoController()).ignoresSafeArea()
    }
}
#endif
