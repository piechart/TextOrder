//
//  TextOrderRootView.swift
//  TextOrder
//
//  Created by apples on 19.03.2021.
//

import UIKit

final class StateHighlightingButton: UIButton {
	override var isEnabled: Bool {
		didSet {
			super.isEnabled = self.isEnabled
			
			self.alpha = self.isEnabled ? 1 : 0.4
		}
	}
}

final class TextOrderRootView: UIView {
	let closeButton = UIButton.iconButton(with: SFSymbols.close.image)
	
	let flagButton = UIButton.iconButton(with: SFSymbols.flag.image)
	
	let progressView = ProgressView()
	
	let headerLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
		label.textColor = .text
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let userTilesbar = TilesBar()
	
	let phraseLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
		label.textColor = .text
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let targetTilesBar = TilesBar()
	
	let checkButton: StateHighlightingButton = {
		let button = StateHighlightingButton(type: .system)
		button.backgroundColor = .progressFill
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
		button.layer.cornerRadius = 8
		button.translatesAutoresizingMaskIntoConstraints = false
		button.isEnabled = false
		return button
	}()
	
	var panningTile: TileView?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.commonInit()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.commonInit()
	}
	
	private func commonInit() {
		let offset: CGFloat = 16
		let buttonSize: CGFloat = 44
		let barHeight: CGFloat = 54
		
		self.backgroundColor = .white
		
		self.addSubview(self.closeButton)
		self.addSubview(self.flagButton)
		self.addSubview(self.progressView)
		self.addSubview(self.headerLabel)
		self.addSubview(self.checkButton)
		self.addSubview(self.targetTilesBar)
		self.addSubview(self.userTilesbar)
		self.addSubview(self.phraseLabel)
		
		NSLayoutConstraint.activate([
			self.closeButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 4),
			self.closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: offset),
			self.closeButton.widthAnchor.constraint(equalToConstant: buttonSize),
			self.closeButton.heightAnchor.constraint(equalToConstant: buttonSize),
			
			self.flagButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -4),
			self.flagButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: offset),
			self.flagButton.widthAnchor.constraint(equalToConstant: buttonSize),
			self.flagButton.heightAnchor.constraint(equalToConstant: buttonSize),
			
			self.progressView.leadingAnchor.constraint(equalTo: self.closeButton.trailingAnchor, constant: offset / 2),
			self.progressView.centerYAnchor.constraint(equalTo: self.closeButton.centerYAnchor),
			self.progressView.trailingAnchor.constraint(equalTo: self.flagButton.leadingAnchor, constant: -offset / 2),
			self.progressView.heightAnchor.constraint(equalToConstant: 16),
			
			self.headerLabel.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor, constant: offset),
			self.headerLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: offset),
			self.headerLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -offset),
			
			self.checkButton.leadingAnchor.constraint(equalTo: self.headerLabel.leadingAnchor),
			self.checkButton.trailingAnchor.constraint(equalTo: self.headerLabel.trailingAnchor),
			self.checkButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -offset / 2),
			self.checkButton.heightAnchor.constraint(equalToConstant: barHeight),
			
			self.targetTilesBar.bottomAnchor.constraint(equalTo: self.checkButton.topAnchor, constant: -offset),
			self.targetTilesBar.leadingAnchor.constraint(equalTo: self.checkButton.leadingAnchor),
			self.targetTilesBar.trailingAnchor.constraint(equalTo: self.checkButton.trailingAnchor),
			self.targetTilesBar.heightAnchor.constraint(equalTo: self.checkButton.heightAnchor),
			
			self.userTilesbar.leadingAnchor.constraint(equalTo: self.targetTilesBar.leadingAnchor),
			self.userTilesbar.trailingAnchor.constraint(equalTo: self.targetTilesBar.trailingAnchor),
			self.userTilesbar.heightAnchor.constraint(equalTo: self.targetTilesBar.heightAnchor),
			self.userTilesbar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			
			self.phraseLabel.leadingAnchor.constraint(equalTo: self.headerLabel.leadingAnchor),
			self.phraseLabel.trailingAnchor.constraint(equalTo: self.headerLabel.trailingAnchor),
			self.phraseLabel.bottomAnchor.constraint(equalTo: self.userTilesbar.topAnchor, constant: -offset)
		])
	}
}
