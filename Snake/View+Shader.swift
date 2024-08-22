//
//  View+Shader.swift
//  Snake
//
//  Created by Astemir Eleev on 21/8/24.
//

import SwiftUI

@dynamicMemberLookup
enum EffectsLibrary {
    static subscript(dynamicMember name: String) -> ShaderFunction {
        ShaderLibrary.bundle(.main)[dynamicMember: name]
    }
}

extension View {
    func matrix(time: TimeInterval, isEnabled: Bool = true) -> some View {
        colorEffect(
            EffectsLibrary.matrix(
                .boundingRect,
                .float(time)
            ),
            isEnabled: isEnabled
        )
    }
}
