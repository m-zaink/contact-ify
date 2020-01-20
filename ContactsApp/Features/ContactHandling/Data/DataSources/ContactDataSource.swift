//
//  ContactDataSource.swift
//  ContactsApp
//
//  Created by Mohammed Sadiq on 17/01/20.
//  Copyright © 2020 Mohammed Sadiq. All rights reserved.
//

import Foundation
import Contacts

protocol ContactDataSource {
    static var shared: ContactDataSource {
        get
    }
    
    func addContact(_ contact: CNMutableContact);
    func removeContact(_ contact: CNMutableContact);
    func updateContact(from fromContact: CNMutableContact, to toContact: CNMutableContact);
    func getContacts() -> [ContactModel];
}

class ContactDataSourceImpl : ContactDataSource {
    private var store: CNContactStore = CNContactStore();
    static var shared: ContactDataSource = ContactDataSourceImpl();
    
    // Returns true upon successful addition of the passed contact
    // Otherwise returns false
    func addContact(_ contact: CNMutableContact) {
        do {
            let saveRequest: CNSaveRequest = CNSaveRequest();
            saveRequest.add(contact, toContainerWithIdentifier: nil);
            
            try self.store.execute(saveRequest);
        } catch {
            print(error);
        }
    }
    
    
    // Returns true upon successful deletion of the passed contact
    // Otherwise returns false
    func removeContact(_ contact: CNMutableContact) {
        do {
            let predicateWithMatchingName: NSPredicate = CNContact.predicateForContacts(matchingName: contact.givenName);
            
            guard let contactToDelete: CNMutableContact = fetchContact(withPredicate: predicateWithMatchingName) else {
                return;
            }
            
            let saveRequest: CNSaveRequest = CNSaveRequest();
            saveRequest.delete(contactToDelete);
            try self.store.execute(saveRequest);
        } catch {
            print("Error in removing contact", error);
        }
    }
    
    // Returns true upon successful updation of the passed contact
    // Otherwise returns false
    func updateContact(from fromContact: CNMutableContact, to toContact: CNMutableContact) {
        do {
            let predicateWithMatchingName: NSPredicate = CNContact.predicateForContacts(matchingName: fromContact.givenName);
            
            guard let toUpdateContact: CNMutableContact = fetchContact(withPredicate: predicateWithMatchingName, keysToFetch: ContactModel.keys) else {
                return;
            }
            
            toUpdateContact.givenName = toContact.givenName;
            toUpdateContact.familyName = toContact.familyName;
            toUpdateContact.emailAddresses = toContact.emailAddresses;
            toUpdateContact.organizationName = toContact.organizationName;
            toUpdateContact.phoneNumbers = toContact.phoneNumbers;
            toUpdateContact.imageData = toContact.imageData;
            
            let saveRequest: CNSaveRequest = CNSaveRequest();
            saveRequest.update(toUpdateContact);
            
            try self.store.execute(saveRequest);
        } catch {
            print("Error in updating contact", error);
        }
    }
    
    // Returns true upon successful updation of the passed contact
    // Otherwise returns false
    func getContacts() -> [ContactModel] {
        do {
            let keysToFetch = [
                CNContactGivenNameKey,
                CNContactFamilyNameKey,
                CNContactEmailAddressesKey,
                CNContactPhoneNumbersKey,
                CNContactOrganizationNameKey,
                CNContactImageDataKey
            ];
            
            let rawContacts: [CNContact] = try {
                // Get all the containers
                var allContainers: [CNContainer] = [];
                allContainers = try store.containers(matching: nil);
                
                var results: [CNContact] = [];
                
                // Iterate all containers and append their contacts to our results array
                for container in allContainers {
                    let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier);
                    
                    let containerResults = try store.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as [CNKeyDescriptor]);
                    
                    results.append(contentsOf: containerResults);
                }
                return results
                }();
            
            var contacts: [ContactModel] = Array<ContactModel>();
            
            for contact in rawContacts {
                contacts.append(makeContactModel(fromRawContact: contact));
            }
            
            contacts.sort { (a, b) -> Bool in
                if a.firstName == b.firstName {
                    return (a.lastName ?? "") < (b.lastName ?? "");
                }
                
                return a.firstName < b.firstName;
            }
            
            return contacts;
        } catch {
            print(error);
            return Array<ContactModel>();
        }
    }
}

// MARK: - Auxiliary methods

extension ContactDataSourceImpl {
    func makeContactModel(fromRawContact contact: CNContact) -> ContactModel {
        return ContactModel(firstName: contact.givenName,
                            lastName: contact.familyName,
                            phoneNumber: contact.phoneNumbers.first?.value.stringValue,
                            email: contact.emailAddresses.first?.value as String?,
                            company: contact.organizationName,
                            image: contact.imageData);
    }
    
    func fetchContact(withPredicate predicate: NSPredicate, keysToFetch: [String] = [CNContactGivenNameKey]) -> CNMutableContact? {
        do {
            let contactsMatched = try self.store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch as [CNKeyDescriptor]);
            
            if let contact = contactsMatched.first {
                let contactToReturn: CNMutableContact = contact.mutableCopy() as! CNMutableContact;
                return contactToReturn;
            }
        } catch {
            print("Error in fetching contact with such predicate!");
        }
        
        return nil;
    }
}
