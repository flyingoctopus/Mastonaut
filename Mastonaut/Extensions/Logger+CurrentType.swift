//
//  Logger+CurrentType.swift
//  Mastonaut
//
//  Created by Sören Kuklau on 17.11.22.
//  Copyright © 2022 Bruno Philipe. All rights reserved.
//

import Foundation
import Logging

extension Logger {
	/// Construct a `Logger` given an object from a type that will serve
	/// as the **subsystem** (an Apple Unified Logging concept).
	///
	/// For example, if `subsystemObject` is of  type `MyClass` and
	/// lives in a bundle with identifier `com.example.MyApp`, the
	/// subsystem of logging messages gets set to
	/// `com.example.MyApp.MyClass`, so you can easily use
	/// **Console** to filter for log mesages occuring in that particular
	/// type.
	init(subsystemType subsystemObject: AnyObject) {
		let subsystemType: AnyObject.Type = type(of: subsystemObject)

		let bundleIdentifier = Bundle(for: subsystemType).bundleIdentifier!
				
		let label = "\(bundleIdentifier).\(String(describing: subsystemType))"
		
		self.init(label: label)
	}
}
