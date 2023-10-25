//
//  TagModifier.swift
//  Flickr Search Code Challenge
//
//  Created by Jonathan Lepolt on 10/25/23.
//

import SwiftUI

struct TagModifier: ViewModifier {
    /// Background color to use for our tag view
    let color: Color

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(
                Capsule()
                    .fill(color)
            )
    }
}

extension View {
    func makeTag(color: Color) -> some View {
        self
            .modifier(TagModifier(color: color))
    }
}

#Preview {
    Text("Tag")
        .makeTag(color: .blue.opacity(0.5))
}
