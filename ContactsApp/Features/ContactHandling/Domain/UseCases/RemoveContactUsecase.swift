//
//  RemoveContact.swift
//  ContactsApp
//
//  Created by Mohammed Sadiq on 16/01/20.
//  Copyright © 2020 Mohammed Sadiq. All rights reserved.
//

import Foundation

class RemoveContactUsecase : Usecase {
    typealias Parameters = Contact;
    typealias ReturnType = Void;
    
    private var _contactRepository: ContactRepository = ContactRepositoryImpl.repository;
    
    func execute(withParameters params: Parameters) {
        _contactRepository.removeContact(params);
    }
}
