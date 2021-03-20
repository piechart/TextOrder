//
//  StateHighlightingButton.swift
//  TextOrder
//
//  Created by apples on 20.03.2021.
//

import UIKit.UIButton

final class StateHighlightingButton: UIButton {
	override var isEnabled: Bool {
		didSet {
			super.isEnabled = self.isEnabled
			
			self.alpha = self.isEnabled ? 1 : 0.4
		}
	}
}
