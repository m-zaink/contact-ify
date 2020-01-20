//
//  ContactBook.swift
//  ContactsApp
//
//  Created by Mohammed Sadiq on 16/01/20.
//  Copyright © 2020 Mohammed Sadiq. All rights reserved.
//

import Foundation
import Contacts

class ContactRepositoryImpl : ContactRepository {
    static var repository: ContactRepository = ContactRepositoryImpl();
    
    private let dataSource: ContactDataSource = ContactDataSourceImpl.shared;
    
    
    func addContact(_ contact: Contact) {
        let contactToInsert: CNMutableContact = makeContact(fromContactModel: contact);
        _ = dataSource.addContact(contactToInsert);
    }
    
    func removeContact(_ contact: Contact) {
        let contactToDelete: CNMutableContact = makeContact(fromContactModel: contact);
        _ = dataSource.removeContact(contactToDelete);
    }
    
    func updateContact(from fromContact: Contact, to toContact: Contact) {
        let fromContact: CNMutableContact = makeContact(fromContactModel: fromContact);
        let toContact: CNMutableContact = makeContact(fromContactModel: toContact);
        
        _ = dataSource.updateContact(from: fromContact, to: toContact);
    }
    
    func getContacts() -> [Contact] {
        return dataSource.getContacts() as [Contact];
    }
}

// MARK: Auxiliary methods

extension ContactRepositoryImpl {
    private func makeContact(fromContactModel contact: Contact) -> CNMutableContact {
        let contactToReturn: CNMutableContact = CNMutableContact();
        
        contactToReturn.givenName = contact.firstName;
        
        if let familyName = contact.lastName {
            contactToReturn.familyName = familyName;
        }
        
        if let workEmail = contact.email {
            let workEmailToInsert: CNLabeledValue = CNLabeledValue(label: CNLabelWork, value: workEmail as NSString);
            contactToReturn.emailAddresses = [workEmailToInsert];
        }
        
        if let phoneNumber = contact.phoneNumber {
            let phoneNumberToInsert: CNLabeledValue = CNLabeledValue(label: CNLabelPhoneNumberMain, value: CNPhoneNumber(stringValue: phoneNumber));
            contactToReturn.phoneNumbers = [phoneNumberToInsert];
        }
        
        if let company = contact.company {
            contactToReturn.organizationName = company;
        }
        
        if let image = contact.image {
            contactToReturn.imageData = image;
        }
        
        return contactToReturn;
    }
}
