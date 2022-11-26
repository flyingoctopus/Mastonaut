//
//  NotificationPerAccountPreferencesView.swift
//  Mastonaut
//
//  Created by Sören Kuklau on 26.11.22.
//  Copyright © 2022 Bruno Philipe. All rights reserved.
//

import SwiftUI

struct NotificationPerAccountPreferencesView: View {
	let columns = [
		GridItem(.fixed(140), alignment: .topTrailing),
		GridItem(.flexible(), alignment: .leading),
	]
	
    var body: some View {
		VStack {
			Text("The following options only apply to the selected account:")
			
			LazyVGrid(columns: columns) {
				Text("Show Notifications:")
				
				VStack(alignment: .leading) {
					Text("Always")
					Text("Never")
					Text("When this account is active")
					
					Text("Selecting 'When this account is active' will cause Mastonaut to only show notifications if you have at least one open window where this account is selected.")
						.font(.system(size: 11))
						.foregroundColor(.secondary)
						.padding(.top, 1)
				}
				
				Text("Notification Types:")
				
				VStack(alignment: .leading) {
					Button("Configure…") {
						print("Hello")
					}

					Text("All")
						.font(.system(size: 11))
						.foregroundColor(.secondary)
				}

				Text("Show Details:")
				
				VStack(alignment: .leading) {
					Text("Always")
					Text("Never")
					Text("If the status is safe-for-work")
					
					Text("A status is considered safe-for-work if it has no content warning, no media flagged as sensitive, and is not tagged #NSFW.")
						.font(.system(size: 11))
						.foregroundColor(.secondary)
						.padding(.top, 1)
				}
			}
		}
    }
}

struct NotificationPerAccountPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPerAccountPreferencesView()
    }
}
