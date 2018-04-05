//
//  CakeDataManager.swift
//  Cake List
//
//  Created by Jordan Helzer on 4/4/18.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

import UIKit

class CakeDataManager: NSObject {

	static let shared = CakeDataManager()
	
	static let infoURLString = "https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json"
	
	var cakes: [CakeInfo] = []
	
	class func refresh(_ completionHandler: (() -> Void)? = nil) {
		DispatchQueue.global(qos: .background).async {
			defer {
				if let completion = completionHandler {
					DispatchQueue.main.async {
						completion()
					}
				}
			}
			guard let url = URL(string: CakeDataManager.infoURLString), let data = try? Data.init(contentsOf: url) else {
				return
			}
			
			let cakes = try? JSONDecoder().decode([CakeInfo].self, from: data)
			if let _ = cakes {
				CakeDataManager.shared.cakes.removeAll()
				CakeDataManager.shared.cakes.append(contentsOf: cakes!)
			}
			
		}
	}
}

