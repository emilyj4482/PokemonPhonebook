//
//  Mode.swift
//  PokemonPhonebook
//
//  Created by EMILY on 11/12/2024.
//

import Foundation

enum Mode {
    case read
    case create
    case edit
    
    var buttonTitle: String {
        switch self {
        case .read: return "수정"
        default: return "저장"
        }
    }
}
