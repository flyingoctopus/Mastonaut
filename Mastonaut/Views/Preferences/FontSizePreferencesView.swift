//
//  Appearance.swift
//  Mastonaut
//
//  Created by Sören Kuklau on 18.11.22.
//  Copyright © 2022 Bruno Philipe. All rights reserved.
//

import CoreTootin
import FontPicker
import SwiftUI

struct FontSizePreferencesView: View {
	@State private var timelineFont: NSFont = MastonautPreferences.instance.timelineFont
	@State private var focusedFont: NSFont = MastonautPreferences.instance.focusedFont

	let columns = [
		GridItem(.fixed(260), alignment: .trailing),
		GridItem(.fixed(380), alignment: .leading),
	]

	var body: some View {
		LazyVGrid(columns: columns) {
			Text("Timeline status font size:")

			HStack {
				FontPicker("", selection: $timelineFont)
					.padding(.leading, -7) // FontPicker shows its own label, which we don't want

				Button("Reset") {
					timelineFont = MastonautPreferences.defaultTimelineFont
				}

				Text("\(timelineFont.displayName ?? "(no font)") \(timelineFont.pointSize, specifier: "%.0f")")
			}
			
			Text("Conversation status font size:")

			HStack {
				FontPicker("", selection: $focusedFont)
					.padding(.leading, -7) // FontPicker shows its own label, which we don't want

				Button("Reset") {}

				Text("\(focusedFont.displayName ?? "(no font)") \(focusedFont.pointSize, specifier: "%.0f")")
			}
		}
		.onChange(of: timelineFont) { newValue in
			MastonautPreferences.instance.timelineFont = newValue
		}
		.onChange(of: focusedFont) { newValue in
			MastonautPreferences.instance.focusedFont = newValue
		}
		// AppKit layout hacks
		.padding(.trailing, 15)
		.frame(minHeight: 70)
	}
}

struct FontSizePreferencesView_Previews: PreviewProvider {
	static var previews: some View {
		FontSizePreferencesView()
	}
}
