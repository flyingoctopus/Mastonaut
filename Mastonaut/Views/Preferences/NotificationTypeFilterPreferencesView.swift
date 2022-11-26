//
//  NotificationTypeFilterPreferencesView.swift
//  Mastonaut
//
//  Created by Sören Kuklau on 26.11.22.
//  Copyright © 2022 Bruno Philipe. All rights reserved.
//

import SwiftUI

struct NotificationTypeFilterPreferencesView: View {
	@State var dummyBool: Bool
	
    var body: some View {
		VStack(alignment: .leading) {
			VStack(alignment: .leading) {
				Toggle("Mentions", isOn: $dummyBool)
				Toggle("Statuses", isOn: $dummyBool)
				
				Text("For people for whom you've specifically enabled notifications")
					.font(.system(size: 11))
					.foregroundColor(.secondary)
					.padding(.leading, 20)
					.padding(.bottom, 10)

				Toggle("New followers", isOn: $dummyBool)
				Toggle("Follow requests", isOn: $dummyBool)
					.padding(.bottom, 10)

				Toggle("Boosts", isOn: $dummyBool)
				Toggle("Favorites", isOn: $dummyBool)
					.padding(.bottom, 10)

				Toggle("Poll results", isOn: $dummyBool)
					.padding(.bottom, 10)

				Toggle("Edits", isOn: $dummyBool)
					.padding(.bottom, 10)
			}
			
			VStack(alignment: .leading) {
				Text("For admins:")
							
				Toggle("Sign-ups", isOn: $dummyBool)
					.padding(.leading, 10)
				Toggle("Reports", isOn: $dummyBool)
					.padding(.leading, 10)
					.padding(.bottom, 10)
			}
		}
    }
}

struct NotificationTypeFilterPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
		NotificationTypeFilterPreferencesView(dummyBool: true)
    }
}
