//
//  ContactsDemoView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/12/22.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

import SwiftUI
import Combine
import Contacts

extension CNContainer: Identifiable {
    public var id: String { self.identifier }
}


extension CNContact: Identifiable {
    public var id: String { self.identifier }
}

class ContactsDemoViewModel: ObservableObject {
    
    private let store = CNContactStore()
    
    @Published var authorizationStatus: CNAuthorizationStatus = CNAuthorizationStatus.notDetermined
    
    @Published var contacts: [CNContact] = []
    
    @Published var containers: [CNContainer] = []
    
    public func checkAuthorizationStatus() {
        self.authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        switch self.authorizationStatus {
        case .notDetermined:
            requestAuthorization()
        case .restricted:
            break;
        case .denied:
            break;
        case .authorized:
            requestAuthorizationSuccess()
        @unknown default:
            fatalError("Unknown CNAuthorizationStatus")
        }
    }
    
    private func requestAuthorization() {
        store.requestAccess(for: .contacts) { [weak self] isAccess, error in
            DispatchQueue.main.async {
                self?.authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
            }
            if let e = error {
                #if DEBUG
                print(e)
                #endif
                return
            }
            if (!isAccess) {
                return
            }
            self?.requestAuthorizationSuccess()
        }
    }
    
    private func requestAuthorizationSuccess() {
        self.fetchContacts()
    }
    
    public func fetchContacts() {
        DispatchQueue.global().async { [weak self] in
            let keys = [CNContactFamilyNameKey, CNContactMiddleNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
            let request = CNContactFetchRequest(keysToFetch: keys)
            var contacts: [CNContact] = []
            do {
                try self?.store.enumerateContacts(with: request) {
                    (contact, stop) in
                    // Array containing all unified contacts from everywhere
                    contacts.append(contact)
                }
                DispatchQueue.main.async {
                    self?.fetchContactsDone(contacts: contacts)
                }
            }
            catch {
                print("unable to fetch contacts")
            }
        }
//        do {
//            let predicate = CNContact.predicateForContacts(matchingName: "Appleseed")
//            let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey] as [CNKeyDescriptor]
//            self.contacts = try self.store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)
//            print("Fetched contacts: \(self.contacts)")
//            print("Fetched containers: \(self.containers)")
//        } catch {
//            print("Failed to fetch contact, error: \(error)")
//            // Handle the error
//        }

    }
    
    private func fetchContactsDone(contacts: [CNContact]) {
        self.contacts = contacts
        print("Fetched contacts: \(self.contacts)")
    }
    
}

struct ContactsDemoView: View {
    @ObservedObject private var viewModel = ContactsDemoViewModel()
    
    var body: some View {
        VStack {
            Text("authorizationStatus:\(viewModel.authorizationStatus)")
                .padding()
            List(viewModel.contacts) { item in
                VStack {
                    Text("\(item.givenName) \(item.middleName) \(item.familyName)")
                    ForEach(item.phoneNumbers, id: \.self) { item in
                        Text("phone number: \(item.value.stringValue)")
                    }
                }
            }
        }
        .onAppear {
            viewModel.checkAuthorizationStatus()
        }
    }
}

struct ContactsDemoView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsDemoView()
    }
}
