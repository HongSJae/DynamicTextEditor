//
//  File.swift
//  DynamicTextEditor
//
//  Created by mini on 5/26/25.
//

import SwiftUI

struct ExampleView: View {
    @State var text: String = ""

    var body: some View {
        DynamicTextEditor(
            "Placehoder"
            text: $text,
            lineSpace: 2
        )
        .setFont(uiFont: uifont)
    }
}
