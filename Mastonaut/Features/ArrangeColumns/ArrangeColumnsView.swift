//
//  ArrangeColumnsView.swift
//  Mastonaut
//
//  Created by Sören Kuklau on 30.10.23.
//

import SwiftUI

struct ArrangeColumnsView: View {
    var body: some View {
        HStack {
            ArrangeableColumn(icon: "house", text: "Home")

            ArrangeableColumn(icon: "bell", text: "Notifications")

            ArrangeableColumn(icon: "star", text: "Favorites")
        }.padding(10)
    }
}

#Preview {
    ArrangeColumnsView()
}
