//
//  ArrangeableColumn.swift
//  Mastonaut
//
//  Created by Sören Kuklau on 30.10.23.
//

import SwiftUI

struct ArrangeableColumn: View {
    @State var icon: String
    @State var text: String

    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(text)
        }.frame(minWidth: 160, minHeight: 100)
            .border(.secondary)
    }
}

#Preview {
    ArrangeableColumn(icon: "house", text: "Home")
}
