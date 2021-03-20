//
//  CGRect+Helpers.swift
//  TextOrder
//
//  Created by apples on 19.03.2021.
//

import CoreGraphics

extension CGRect {
	
	/// https://stackoverflow.com/a/51076570/5164739
	func intersectionPercentage(_ otherRect: CGRect) -> CGFloat {
		if !intersects(otherRect) { return 0 }
		let intersectionRect = self.intersection(otherRect)
		if intersectionRect == self || intersectionRect == otherRect {
			return 1
		}
		let intersectionArea = intersectionRect.width * intersectionRect.height
		let area = self.width * self.height
		let otherRectArea = otherRect.width * otherRect.height
		let sumArea = area + otherRectArea
		let sumAreaNormalized = sumArea / 2.0
		return intersectionArea / sumAreaNormalized
	}
}
