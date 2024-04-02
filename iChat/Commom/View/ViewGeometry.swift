//
//  ViewGeometry.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 02/04/24.
//

import Foundation
import SwiftUI

struct ViewGeometry: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: ViewSizeKey.self, value: geometry.size)
        }
    }
}
