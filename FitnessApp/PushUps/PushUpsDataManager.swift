//
//  PUDataManager.swift
//  FitnessApp
//
//  Created by Булат Хатмуллин on 19.03.2022.
//

import Foundation

class PushUpsDataManager {
    
    var counterNumberOfPU = 0

    
    func obtainNumberOfPU() -> String? {
        counterNumberOfPU += 1
        return String(counterNumberOfPU)
    }
    
    func zeroingNumberOfPU(){
        counterNumberOfPU = 0
    }
    
    func savingResult(){
        
    }
    

    
}
