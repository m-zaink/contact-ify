//
//  ContactModel.swift
//  ContactsApp
//
//  Created by Mohammed Sadiq on 16/01/20.
//  Copyright © 2020 Mohammed Sadiq. All rights reserved.
//

import Foundation
import Contacts

class ContactModel : Contact {
    required override init(firstName: String, lastName: String?, phoneNumber: String?, email: String?, company: String?, image: Data?) {
        super.init(firstName: firstName,
                   lastName: lastName,
                   phoneNumber: phoneNumber,
                   email: email,
                   company: company,
                   image: image);
    }
    
    static var keys = [
        CNContactGivenNameKey,
        CNContactFamilyNameKey,
        CNContactPhoneNumbersKey,
        CNContactEmailAddressesKey,
        CNContactOrganizationNameKey,
        CNContactImageDataKey
    ];
}
