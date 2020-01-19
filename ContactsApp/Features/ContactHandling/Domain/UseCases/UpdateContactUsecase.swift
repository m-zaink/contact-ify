//
//  UpdateContact.swift
//  ContactsApp
//
//  Created by Mohammed Sadiq on 16/01/20.
//  Copyright © 2020 Mohammed Sadiq. All rights reserved.
//

import Foundation

class UpdateContactUsecase : Usecase {
    typealias Parameters = (from: Contact, to: Contact);
    typealias ReturnType = Void;
    
    private var _contactRepository: ContactRepository = ContactRepositoryImpl.repository;
    
    func execute(withParameters params: Parameters) {
        _contactRepository.updateContact(from: params.from, to: params.to);
    }
}
