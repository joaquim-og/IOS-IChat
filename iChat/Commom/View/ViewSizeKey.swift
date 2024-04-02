//
//  ViewSizeKey.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 02/04/24.
//

import Foundation
import SwiftUI

struct ViewSizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}
