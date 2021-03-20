//
//  UIButton+Helpers.swift
//  TextOrder
//
//  Created by apples on 19.03.2021.
//

import UIKit.UIButton

extension UIButton {
	static func iconButton(with image: UIImage) -> UIButton {
		let button = UIButton(type: .system)
		button.tintColor = .iconTint
		button.setImage(image, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}
}

