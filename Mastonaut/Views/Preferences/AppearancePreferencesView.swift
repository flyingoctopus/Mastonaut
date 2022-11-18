//
//  Appearance.swift
//  Mastonaut
//
//  Created by Sören Kuklau on 18.11.22.
//  Copyright © 2022 Bruno Philipe. All rights reserved.
//

import SwiftUI
import CoreTootin

struct AppearancePreferencesView: View {
	@State var appearance: MastonautPreferences.Appearance

	let columns = [
		GridItem(.fixed(260), alignment: .trailing),
		GridItem(.fixed(380), alignment: .leading),
	]
	
    var body: some View {
		LazyVGrid(columns: columns) {
			Text("Appearance:")
			
			HStack {
				Picker("", selection: $appearance) {
					Text("Light").tag(Appearance.light)
					Text("Dark").tag(Appearance.dark)
					Text("Auto").tag(Appearance.auto)
				}
				.pickerStyle(.radioGroup)
				.horizontalRadioGroupLayout()
			}
		}
		.onChange(of: appearance) { newValue in
			Preferences.appearance = newValue
		}
	}
}

struct AppearancePreferencesView_Previews: PreviewProvider {
    static var previews: some View {
		AppearancePreferencesView(appearance: .dark)
    }
}
