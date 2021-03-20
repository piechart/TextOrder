//
//  SFSymbols.swift
//  TextOrder
//
//  Created by apples on 19.03.2021.
//

import UIKit

enum SFSymbols: String {
	case close = "xmark"
	case flag
	
	var image: UIImage {
		UIImage(systemName: self.rawValue)!
	}
}
