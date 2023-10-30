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
            HStack {
                Image(systemName: "house")
                Text("Home")
            }.frame(minWidth: 160, minHeight: 100)
                .border(.secondary)

            HStack {
                Image(systemName: "bell")
                Text("Notifications")
            }.frame(minWidth: 160, minHeight: 100)
                .border(.secondary)
        }.padding(10)
    }
}

#Preview {
    ArrangeColumnsView()
}
