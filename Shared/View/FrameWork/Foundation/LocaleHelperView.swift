//
//  LocaleHelperView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/28.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct LocaleHelperView: View {
    @State private var showLocaleInfo: Bool = false
    @State private var showPreferredLanguages: Bool = false
    
    @State private var showAvailableIdentifiers: Bool = false
    @State private var showISORegionCodes: Bool = false
    @State private var showISOLanguageCodes: Bool = false
    @State private var showISOCurrencyCodes: Bool = false
    @State private var showCommonISOCurrencyCodes: Bool = false
    
    var body: some View {
        List {
            Section {
                DisclosureGroup("LocaleInfo", isExpanded: $showLocaleInfo) {
                    Group {
                        Text("identifier: \(Locale.current.identifier)")
                        Text("calendar: \(Locale.current.calendar.description)")
                        Text("regionCode: \(Locale.current.regionCode ?? "nil")")
                        Text("languageCode: \(Locale.current.languageCode ?? "nil")")
                        Text("scriptCode: \(Locale.current.scriptCode ?? "nil")")
                        Text("variantCode: \(Locale.current.variantCode ?? "nil")")
                        Text("exemplarCharacterSet: \(Locale.current.exemplarCharacterSet?.description ?? "nil")")
                        Text("collationIdentifier: \(Locale.current.collationIdentifier ?? "nil")")
                        Text("collatorIdentifier: \(Locale.current.collatorIdentifier ?? "nil")")
                        Text("usesMetricSystem: \(Locale.current.usesMetricSystem.description)")
                    }
                    
                    Group {
                        Text("decimalSeparator: \(Locale.current.decimalSeparator ?? "nil")")
                        Text("groupingSeparator: \(Locale.current.groupingSeparator ?? "nil")")
                        Text("currencyCode: \(Locale.current.currencyCode ?? "nil")")
                        Text("currencySymbol: \(Locale.current.currencySymbol ?? "nil")")
                        Text("quotationBeginDelimiter: \(Locale.current.quotationBeginDelimiter ?? "nil")")
                        Text("quotationEndDelimiter: \(Locale.current.quotationEndDelimiter ?? "nil")")
                        Text("alternateQuotationBeginDelimiter: \(Locale.current.alternateQuotationBeginDelimiter ?? "nil")")
                        Text("alternateQuotationEndDelimiter: \(Locale.current.alternateQuotationEndDelimiter ?? "nil")")
                    }
                }
                DisclosureGroup("preferredLanguages", isExpanded: $showPreferredLanguages) {
                    ForEach(Locale.preferredLanguages.sorted(), id: \.self) { item in
                        Text(item)
                    }
                }
            } header: {
                Text("Getting Information About a Locale")
            }
            
            Section {
                Text("autoupdatingCurrent: \(Locale.autoupdatingCurrent.description)")
                Text("current: \(Locale.current.description)")
            } header: {
                Text("Getting the User's Locale")
            }
            
            Section {
                DisclosureGroup("availableIdentifiers", isExpanded: $showAvailableIdentifiers) {
                    ForEach(Locale.availableIdentifiers.sorted(), id: \.self) { item in
                        Text(item)
                    }
                }
                DisclosureGroup("isoRegionCodes", isExpanded: $showISORegionCodes) {
                    ForEach(Locale.isoRegionCodes.sorted(), id: \.self) { item in
                        Text(item)
                    }
                }
                DisclosureGroup("isoLanguageCodes", isExpanded: $showISOLanguageCodes) {
                    ForEach(Locale.isoLanguageCodes.sorted(), id: \.self) { item in
                        Text(item)
                    }
                }
                DisclosureGroup("isoCurrencyCodes", isExpanded: $showISOCurrencyCodes) {
                    ForEach(Locale.isoCurrencyCodes.sorted(), id: \.self) { item in
                        Text(item)
                    }
                }
                DisclosureGroup("commonISOCurrencyCodes", isExpanded: $showCommonISOCurrencyCodes) {
                    ForEach(Locale.commonISOCurrencyCodes.sorted(), id: \.self) { item in
                        Text(item)
                    }
                }
            } header: {
                Text("Getting Known Identifiers and Codes")
            }
        }
    }
}

#if DEBUG
struct LocaleHelper_Previews: PreviewProvider {
    static var previews: some View {
        LocaleHelperView()
    }
}
#endif
