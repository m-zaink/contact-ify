//
//  ProfileImageView.swift
//  ContactsApp
//
//  Created by Mohammed Sadiq on 20/01/20.
//  Copyright © 2020 Mohammed Sadiq. All rights reserved.
//

import UIKit

class ProfileImageView: UIImageView {
    func roundedImage() {
        self.layer.cornerRadius = (self.image?.size.width ?? 150) / 2;
    }
}
