//
//  LocalizedHelper.swift
//  SwiftHelper
//
//  Created by sauron on 2022/6/2.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment:"")
    }
    
//    var localized: String{
//        return Bundle.main.localizedString(forKey: self, value: nil, table: "StandardLocalizations")
//    }
    
    func localizeWithFormat(arguments: CVarArg...) -> String{
        return String(format: self.localized, arguments: arguments)
    }
    
}
