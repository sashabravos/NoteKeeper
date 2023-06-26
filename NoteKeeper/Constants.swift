//
//  Constants.swift
//  myMemos
//
//  Created by Александра Кострова on 07.05.2023.
//

import UIKit

struct Keys {
    static let noteCell = "noteCellIdentifier"
    static let categoryСell = "categoryСellIdentifier"

    static let systemItemArray = "MemosArray"
    
    struct Colors {
            static let backgroundColor: UIColor = .systemBackground
            static let primaryTextColor: UIColor = .label
            static let secondaryTextColor: UIColor = .lightGray
        }
        struct Images {
            static let arrowImage = UIImage(systemName: "chevron.right.circle")
            static let checkmark = UIImage(systemName: "checkmark.circle.fill")
            static let circle = UIImage(systemName: "circle")
        }
    
    struct CheckmarkCondition {
        static let check = Keys.Images.checkmark?.withTintColor(.label, renderingMode: .alwaysOriginal)
        static let notYet = Keys.Images.circle?.withTintColor(.label, renderingMode: .alwaysOriginal)
    }
}
