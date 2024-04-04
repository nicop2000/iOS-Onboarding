//
//  ViewExtension.swift
//
//
//  Created by Nico Petersen on 04.04.24.
//

import SwiftUI

extension View {
    func visible(_ visible: Bool) -> some View {
        modifier(VisibilityModifier(visible: visible))
    }
}
