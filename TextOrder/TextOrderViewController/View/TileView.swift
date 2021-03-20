//
//  TileView.swift
//  TextOrder
//
//  Created by apples on 19.03.2021.
//

import UIKit

final class TileView: UIView {
	private let label: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 17)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .progressFill
		label.adjustsFontSizeToFitWidth = true
		label.textAlignment = .center
		return label
	}()
	
	var viewModel: TileViewModel! {
		didSet {
			self.label.text = self.viewModel.value
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		self.commonInit()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.commonInit()
	}
	
	private func commonInit() {
		self.layer.cornerRadius = 8
		self.layer.borderWidth = 2
		self.layer.borderColor = UIColor.progressBackground.cgColor
			
		self.addSubview(self.label)
		NSLayoutConstraint.activate([
			self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
			self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2),
			self.label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
		])
	}
}
