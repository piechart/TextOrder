//
//  String+Helpers.swift
//  TextOrder
//
//  Created by apples on 19.03.2021.
//

import Foundation

extension String {
	var words: [String] {
		var result: [String] = []
		self.enumerateSubstrings(in: self.startIndex ..< self.endIndex, options: .byWords) { (word, _, _, _) in
			if word != nil {
				result.append(word!)
			}
		}
		return result
	}
}
