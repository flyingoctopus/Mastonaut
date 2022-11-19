//
//  GeneralPreferencesViewController.swift
//  Mastonaut
//
//  Created by Bruno Philipe on 12.05.19.
//  Mastonaut - Mastodon Client for Mac
//  Copyright © 2019 Bruno Philipe.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//

import Foundation
import CoreTootin
import SwiftUI

class GeneralPreferencesController: NSViewController
{
	@IBOutlet private weak var timelinesResizeExpandFirstButton: NSButton!
	@IBOutlet private weak var timelinesResizeShrinkFirstButton: NSButton!

	@IBOutlet private weak var newWindowAccountModeAskButton: NSButton!
	@IBOutlet private weak var newWindowAccountModePickFirstOneButton: NSButton!
	
	@IBOutlet private weak var appearancePreferencesView: NSView!

	private var preferenceObservers: [AnyObject] = []

	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		let appearance = Preferences.appearance
		let view = AppearancePreferencesView(appearance: appearance)

		hostSwiftUIView(view, inView: appearancePreferencesView)

		let timelinesResizeModeButtonMap: [MastonautPreferences.TimelinesResizeMode: NSButton] = [
			.expandWindowFirst: timelinesResizeExpandFirstButton,
			.shrinkColumnsFirst: timelinesResizeShrinkFirstButton,
		]

		preferenceObservers.append(PreferenceEnumRadioObserver(preference: \MastonautPreferences.timelinesResizeMode,
															   buttonMap: timelinesResizeModeButtonMap))

		let newWindowAccountModeButtonMap: [MastonautPreferences.NewWindowAccountMode: NSButton] = [
			.ask: newWindowAccountModeAskButton,
			.pickFirstOne: newWindowAccountModePickFirstOneButton,
		]

		preferenceObservers.append(PreferenceEnumRadioObserver(preference: \MastonautPreferences.newWindowAccountMode,
															   buttonMap: newWindowAccountModeButtonMap))
	}
	
	private func hostSwiftUIView<TSwiftUIView: View>(_ swiftView: TSwiftUIView, inView nsView: NSView) {
		let hostingView: NSHostingView<TSwiftUIView> = NSHostingView(rootView: swiftView)
		nsView.addSubview(hostingView)
		
		hostingView.translatesAutoresizingMaskIntoConstraints = false
		hostingView.leadingAnchor.constraint(equalTo: nsView.leadingAnchor).isActive = true
		hostingView.trailingAnchor.constraint(equalTo: nsView.trailingAnchor).isActive = true
		hostingView.topAnchor.constraint(equalTo: nsView.topAnchor).isActive = true
		hostingView.bottomAnchor.constraint(equalTo: nsView.bottomAnchor).isActive = true
	}
}
