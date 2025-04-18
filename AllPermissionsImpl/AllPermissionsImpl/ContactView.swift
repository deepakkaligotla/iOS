//
//  ContactView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 29/03/24.
//

import SwiftUI
import Contacts
import ContactsUI

struct ContactView: View {
    @State private var contacts: [CNContact] = []
    @State private var selectedContacts: Set<CNContact> = []
    @State private var newContact: CNContact = CNContact()
    @State private var selectedContact: CNContact?
    @State private var searchName: String = ""
    @State private var selectionEnabled: Bool = false
    @State private var createContactSheet: Bool = false
    @State private var contactDetailsSheet: Bool = false
    var contactStore = CNContactStore()
    
    var contactViewDelegate: CNContactViewControllerDelegate {
        return ContactViewDelegate()
    }
    
    var searchResults: [CNContact] {
        if searchName.isEmpty {
            return contacts
        } else {
            return contacts.filter { $0.givenName.contains(searchName) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if CNContactStore.authorizationStatus(for: .contacts) == .authorized {
                    if self.searchResults.isEmpty {
                        Text("No Contact Found")
                    } else {
                        List(selection: $selectedContacts) {
                            ForEach(searchResults, id: \.identifier) { contact in
                                Button {
                                    if self.selectionEnabled {
                                        self.toggleSelection(contact)
                                    } else {
                                        self.fetchContactDetails(contact)
                                    }
                                } label: {
                                    HStack {
                                        Text("\(contact.givenName) \(contact.familyName)")
                                        Spacer()
                                        if self.selectionEnabled {
                                            if self.selectedContacts.contains(contact) {
                                                Image(systemName: "checkmark.circle.fill")
                                                    .foregroundColor(.blue)
                                            } else {
                                                Image(systemName: "circle")
                                                    .foregroundColor(.gray)
                                            }
                                        } else {
                                            Text("\u{f232}").font(.custom("Font Awesome 6 Brands", size: 24))
                                                .onTapGesture {
                                                    if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
                                                        let whatsappURL = URL(string: "https://wa.me/\(phoneNumber.filter {"0123456789".contains($0)})")!
                                                        print(whatsappURL)
                                                        if UIApplication.shared.canOpenURL(whatsappURL) {
                                                            UIApplication.shared.open(whatsappURL)
                                                        } else {
                                                            print("Unable to open WhatsApp")
                                                        }
                                                    } else {
                                                        print("Contact does not have a mobile number")
                                                    }
                                                }
                                        }
                                    }
                                }
                                
                            }
                        }
                        .sheet(isPresented: $createContactSheet, onDismiss: {
                            self.fetchContacts()
                            self.createContactSheet=false
                        }) {
                            NewContactView(contact: newContact, delegate: self.contactViewDelegate)
                        }
                        .sheet(item: $selectedContact, onDismiss: {
                            self.fetchContacts()
                            self.selectedContact = nil
                            self.contactDetailsSheet=false
                        }) { contact in
                            ContactDetailsView(contact: contact, delegate: self.contactViewDelegate)
                                .frame(height: 750)
                        }
                    }
                } else {
                    Button("Grant Contact Permission") {
                        CNContactStore().requestAccess(for: .contacts) { granted, error in }
                    }
                }
            }
        }
        .searchable(text: $searchName)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {self.createContactSheet = true}) {
                    Image(systemName: "plus")
                }
                Button(action: fetchContacts) {
                    Image(systemName: "arrow.clockwise")
                }
                Button(action: {
                    if self.selectionEnabled {
                        self.deleteContacts()
                    } else {
                        self.selectedContacts.removeAll()
                        self.selectionEnabled = true
                    }
                }) {
                    Image(systemName: self.selectedContacts.isEmpty ? "checkmark.circle" : "trash")
                }
            }
        }
        .onAppear{
            self.fetchContacts()
        }
    }
    
    private func fetchContacts() {
        if CNContactStore.authorizationStatus(for: .contacts) == .authorized {
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let keys = [CNContactIdentifierKey,
                                CNContactNamePrefixKey,
                                CNContactGivenNameKey,
                                CNContactMiddleNameKey,
                                CNContactFamilyNameKey,
                                CNContactPreviousFamilyNameKey,
                                CNContactNameSuffixKey,
                                CNContactNicknameKey,
                                CNContactOrganizationNameKey,
                                CNContactDepartmentNameKey,
                                CNContactJobTitleKey,
                                CNContactPhoneticGivenNameKey,
                                CNContactPhoneticMiddleNameKey,
                                CNContactPhoneticFamilyNameKey,
                                CNContactPhoneticOrganizationNameKey,
                                CNContactBirthdayKey,
                                CNContactNonGregorianBirthdayKey,
                                //CNContactNoteKey,
                                CNContactImageDataKey,
                                CNContactThumbnailImageDataKey,
                                CNContactImageDataAvailableKey,
                                CNContactTypeKey,
                                CNContactPhoneNumbersKey,
                                CNContactEmailAddressesKey,
                                CNContactPostalAddressesKey,
                                CNContactDatesKey,
                                CNContactUrlAddressesKey,
                                CNContactRelationsKey,
                                CNContactSocialProfilesKey,
                                CNContactInstantMessageAddressesKey]
                    let fetchRequest = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                    var fetchedContacts: [CNContact] = []
                    try CNContactStore().enumerateContacts(with: fetchRequest) { contact, _ in
                        fetchedContacts.append(contact)
                    }
                    DispatchQueue.main.async {
                        self.contacts.removeAll()
                        self.contacts = fetchedContacts
                    }
                } catch {
                    print("Error fetching contacts: \(error)")
                }
            }
        }
    }
    
    private func fetchContactDetails(_ contact: CNContact) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let keysToFetch = [CNContactViewController.descriptorForRequiredKeys(), CNContactViewController.descriptorForRequiredKeys()]
                let detailedContact = try contactStore.unifiedContact(withIdentifier: contact.identifier, keysToFetch: keysToFetch)
                DispatchQueue.main.async {
                    self.selectedContact = detailedContact
                    self.contactDetailsSheet = true
                }
            } catch {
                print("Error fetching contact details: \(error)")
            }
        }
    }
    
    private func createContact() {
        do {
            let request = CNSaveRequest()
            request.add(CNMutableContact(), toContainerWithIdentifier: nil)
            try contactStore.execute(request)
            DispatchQueue.main.async {
                self.fetchContacts()
            }
        } catch {
            print("Error creating contacts: \(error)")
        }
    }
    
    private func deleteContacts() {
        do {
            let request = CNSaveRequest()
            for contactToDelete in selectedContacts {
                let mutableContact = contactToDelete.mutableCopy() as! CNMutableContact
                request.delete(mutableContact)
            }
            try contactStore.execute(request)
            
            DispatchQueue.main.async {
                self.selectedContacts.removeAll()
                self.fetchContacts()
                self.selectionEnabled = false
            }
        } catch {
            print("Error deleting contacts: \(error)")
        }
    }
    
    private func toggleSelection(_ contact: CNContact) {
        if selectedContacts.contains(contact) {
            selectedContacts.remove(contact)
        } else {
            selectedContacts.insert(contact)
        }
    }
}

struct NewContactView: UIViewControllerRepresentable {
    var contact: CNContact
    var delegate: CNContactViewControllerDelegate?
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let contactViewController = CNContactViewController(forNewContact: contact)
        contactViewController.allowsActions = true
        contactViewController.delegate = delegate
        let navigationController = UINavigationController(rootViewController: contactViewController)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        if let contactViewController = uiViewController.topViewController as? CNContactViewController {
            
        }
    }
}

struct ContactDetailsView: UIViewControllerRepresentable {
    var contact: CNContact
    var delegate: CNContactViewControllerDelegate?
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let contactViewController = CNContactViewController(for: contact)
        contactViewController.allowsEditing = true
        contactViewController.delegate = delegate
        let navigationController = UINavigationController(rootViewController: contactViewController)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        if let contactViewController = uiViewController.topViewController as? CNContactViewController {
            
        }
    }
}

class ContactViewDelegate: NSObject, CNContactViewControllerDelegate {
    func contactViewController(_ controller: CNContactViewController, didCompleteWith contact: CNContact?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
