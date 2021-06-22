//
//  Int+Extension.swift
//  Weather
//
//  Created by Evgeny Novgorodov on 15.11.2020.
//

extension Int {
    
    func withSign() -> String {
        self > 0 ? "+\(self)" : "\(self)"
    }
}
