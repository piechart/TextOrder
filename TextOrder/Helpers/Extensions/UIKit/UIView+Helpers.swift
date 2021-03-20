//
//  UIView+Helpers.swift
//  TextOrder
//
//  Created by apples on 19.03.2021.
//

import UIKit

extension UIView {
	func pinEdges(to targetView: UIView, insets: UIEdgeInsets = .zero) {
		self.translatesAutoresizingMaskIntoConstraints = false
		targetView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			self.leadingAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
			self.topAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.topAnchor, constant: insets.top),
			self.trailingAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.trailingAnchor, constant: insets.right),
			self.bottomAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.bottomAnchor, constant: insets.bottom)
		])
	}
}
