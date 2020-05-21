/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit


typealias Action = () -> Void

enum MapDetailViewModelType {
    
    case phone
    case website
    case facebook
    case address
    case workingHours
 
    var title: String {
        switch self {
        case .address:
            return L10n.Location.Details.address
        case .website:
            return L10n.Location.Details.website
        case .phone:
            return L10n.Location.Details.phone
        case .facebook:
            return L10n.Location.Details.fb
        case .workingHours:
            return L10n.Location.Details.workingHours
        }
    }
}

protocol MapDetailViewModelProtocol {
    
    var type: MapDetailViewModelType { get }
    var title: String { get }
    var content: String { get }
    var action: Action? { get }
    var image: UIImage? { get }
    
}


struct MapDetailViewModel: MapDetailViewModelProtocol {
    
    let type: MapDetailViewModelType
    let content: String
    let action: Action?
    
    var title: String {
        return type.title
    }
    
    var image: UIImage? {
        switch type {
        case .address:
            return UIImage(named: "navigate", in: .frameworkBundle, compatibleWith: nil)
        case .phone:
            return UIImage(named: "call", in: .frameworkBundle, compatibleWith: nil)
        case .facebook, .website:
            return UIImage(named: "open", in: .frameworkBundle, compatibleWith: nil)
        case .workingHours:
            return nil
        }
    }
    
    init(type: MapDetailViewModelType, content: String, action: Action?) {
        self.type = type
        self.content = content
        self.action = action
    }
    
}
