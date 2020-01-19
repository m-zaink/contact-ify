//
//  File.swift
//  ContactsApp
//
//  Created by Mohammed Sadiq on 16/01/20.
//  Copyright © 2020 Mohammed Sadiq. All rights reserved.
//

import Foundation

protocol Usecase {
    associatedtype Parameters;
    associatedtype ReturnType;
    
    func execute(withParameters params: Parameters) -> ReturnType;
}
