//
//  SHValueStepperDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/10/28.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

class SHValueStepperDemoController: SHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "SHValueStepper"
        let stepper = SHValueStepper(valueStringProvider: { value in "value: \(value)" })

        self.view.addSubview(stepper)
        stepper.snp.makeConstraints { make in
            make.center.width.equalTo(self.view)
            make.height.equalTo(44)
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
struct SHValueStepperDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(SHValueStepperDemoController()).ignoresSafeArea()
    }
}
#endif
