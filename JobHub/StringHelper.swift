//
//  StringHelper.swift
//  JobHub
//
//  Created by Ankit Angra on 13/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
}
