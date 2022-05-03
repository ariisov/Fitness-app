//
//  SUDataManager.swift
//  FitnessApp
//
//  Created by Булат Хатмуллин on 19.03.2022.
//

import Foundation

class SitUpsDataManager{
    
    var counterNumberOfSU = 0
    
    func obtainNumberOfSU() -> String {
        counterNumberOfSU += 1
        return String(counterNumberOfSU)
    }
}
