//
//  VisibilityModifier.swift
//
//
//  Created by Nico Petersen on 04.04.24.
//

import SwiftUI

struct VisibilityModifier: ViewModifier {
    var visible: Bool

    func body(content: Content) -> some View {
        if visible {
            content
        }
    }
}
