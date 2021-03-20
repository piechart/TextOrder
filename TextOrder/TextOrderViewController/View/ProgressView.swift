//
//  ProgressView.swift
//  TextOrder
//
//  Created by apples on 19.03.2021.
//

import UIKit

final class ProgressView: UIView {
	
	var progress: CGFloat = 0 {
		didSet {
			self.setNeedsLayout()
		}
	}
	
	private lazy var progressLine: UIView = {
		let view = UIView()
		view.backgroundColor = .progressFill
		view.translatesAutoresizingMaskIntoConstraints = false
		
		let glowView = UIView()
		view.addSubview(glowView)
		glowView.backgroundColor = .progressGlow
		glowView.layer.cornerRadius = 2
		
		glowView.translatesAutoresizingMaskIntoConstraints = false
		let glowTrailing = glowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6)
		glowTrailing.priority = .defaultLow
		NSLayoutConstraint.activate([
			glowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
			glowView.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
			glowTrailing,
			glowView.heightAnchor.constraint(equalToConstant: 4)
		])
		
		return view
	}()
	
	private var progressLineWidthConstraint: NSLayoutConstraint!
	
	private var currentProgress: CGFloat {
		self.bounds.width * self.progress
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		if self.layer.cornerRadius == 0 {
			self.layer.cornerRadius = self.bounds.height / 2
			self.progressLine.layer.cornerRadius = self.layer.cornerRadius
		}
		
		if self.progressLineWidthConstraint.constant != self.currentProgress {
			self.progressLineWidthConstraint.constant = self.currentProgress
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.commonInit()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.commonInit()
	}
	
	private func commonInit() {
		self.backgroundColor = .progressBackground
		self.translatesAutoresizingMaskIntoConstraints = false
		
		self.addSubview(self.progressLine)
		self.progressLineWidthConstraint = self.progressLine.widthAnchor.constraint(equalToConstant: 0)
		NSLayoutConstraint.activate([
			self.progressLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			self.progressLine.topAnchor.constraint(equalTo: self.topAnchor),
			self.progressLineWidthConstraint,
			self.progressLine.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}
}
