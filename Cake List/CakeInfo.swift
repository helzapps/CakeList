//
//  CakeInfo.swift
//  Cake List
//
//  Created by Jordan Helzer on 4/4/18.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

import UIKit

class CakeInfo: NSObject, Codable {
	var desc: String = ""
	var title: String = ""
	var image: String = ""
}

extension CakeInfo {
	var actualImage: UIImage? {
		get {
			return ImageCache.getImage(at: image)
		}
	}
}
