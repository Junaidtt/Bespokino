//
//  MeasurmentValue.swift
//  Bespokino
//
//  Created by Bespokino on 8/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import Foundation


struct ModelNumber {
    var modValue:String
    
}

struct Measurement {
    
    var model:String
    var shoulderMaster:Double
    var sleeveMaster:Double
    var chestMaster:Double
    var waistMaster:Double
    var hipsMaster:Double
    var lengthMaster:Double
    var bicepsMaster:Double
    var cuffMaster:Double
    var neckMaster:Double

    
}

class MeasurementValue {
    
    var measurment = [Measurement]()
    
    func setMeasurment(m:String,completion:(Bool,Measurement?,Error?)->Void)  {
        
        let measurment1 = Measurement(model: "1", shoulderMaster: 18, sleeveMaster: 24, chestMaster: 32, waistMaster: 29, hipsMaster: 38, lengthMaster: 27, bicepsMaster: 12, cuffMaster: 10, neckMaster: 45)
        
        let measurment2 = Measurement(model: "2", shoulderMaster: 18, sleeveMaster: 24, chestMaster: 34, waistMaster: 31, hipsMaster: 39, lengthMaster: 27, bicepsMaster: 13, cuffMaster: 10, neckMaster: 45)
        
        let measurment3 = Measurement(model: "3", shoulderMaster: 19, sleeveMaster: 25, chestMaster: 36, waistMaster: 33, hipsMaster: 40, lengthMaster: 30, bicepsMaster: 13.5, cuffMaster: 10, neckMaster: 45)
        
        let measurment4 = Measurement(model: "4", shoulderMaster: 19.5, sleeveMaster: 25.5, chestMaster: 38, waistMaster: 35, hipsMaster: 41, lengthMaster: 30, bicepsMaster: 14, cuffMaster: 10, neckMaster: 45)
        
        let measurment5 = Measurement(model: "5", shoulderMaster: 19.5, sleeveMaster: 25.5, chestMaster: 40, waistMaster: 37, hipsMaster: 42, lengthMaster: 30, bicepsMaster: 14, cuffMaster: 10, neckMaster: 45)
        
        let measurment6 = Measurement(model: "6", shoulderMaster: 20, sleeveMaster: 25.5, chestMaster: 42, waistMaster: 39, hipsMaster: 43, lengthMaster: 30, bicepsMaster: 15.5, cuffMaster: 10, neckMaster: 45)
        
        let measurment7 = Measurement(model: "7", shoulderMaster: 20, sleeveMaster: 25.5, chestMaster: 44, waistMaster: 41, hipsMaster: 44, lengthMaster: 31, bicepsMaster: 15.5, cuffMaster: 10, neckMaster: 45)
        
        let measurment8 = Measurement(model: "8", shoulderMaster: 21, sleeveMaster: 26, chestMaster: 46, waistMaster: 43, hipsMaster: 45, lengthMaster: 31, bicepsMaster: 16, cuffMaster: 10, neckMaster: 45)
        
        let measurment9 = Measurement(model: "9", shoulderMaster: 21, sleeveMaster: 26, chestMaster: 48, waistMaster: 46, hipsMaster: 47, lengthMaster: 31, bicepsMaster: 16, cuffMaster: 11, neckMaster: 50)
        
        let measurment10 = Measurement(model: "10", shoulderMaster: 22, sleeveMaster: 26, chestMaster: 50, waistMaster: 47, hipsMaster: 49, lengthMaster: 32, bicepsMaster: 16.5, cuffMaster: 11, neckMaster: 50)
        
        let measurment11 = Measurement(model: "11", shoulderMaster: 22, sleeveMaster: 26, chestMaster: 52, waistMaster: 50, hipsMaster: 51, lengthMaster: 32, bicepsMaster: 16.5, cuffMaster: 11, neckMaster: 50)
        
        let measurment12 = Measurement(model: "12", shoulderMaster: 23, sleeveMaster: 26, chestMaster: 54, waistMaster: 52, hipsMaster: 52, lengthMaster: 33, bicepsMaster: 17, cuffMaster: 11, neckMaster: 50)
        
        let measurment13 = Measurement(model: "13", shoulderMaster: 23, sleeveMaster: 26, chestMaster: 56, waistMaster: 54, hipsMaster: 54, lengthMaster: 33, bicepsMaster: 17, cuffMaster: 11, neckMaster: 50)
        
        let measurment14 = Measurement(model: "14", shoulderMaster: 24, sleeveMaster: 26, chestMaster: 60, waistMaster: 58, hipsMaster: 58, lengthMaster: 33, bicepsMaster: 17, cuffMaster: 11, neckMaster: 50)
        
        
        let measurment1L = Measurement(model: "1L", shoulderMaster: 18, sleeveMaster: 24, chestMaster: 32, waistMaster: 29, hipsMaster: 38, lengthMaster: 30, bicepsMaster: 12, cuffMaster: 10, neckMaster: 45)
        
        let measurment2L = Measurement(model: "2L", shoulderMaster: 18, sleeveMaster: 24, chestMaster: 34, waistMaster: 31, hipsMaster: 39, lengthMaster: 30, bicepsMaster: 13, cuffMaster: 10, neckMaster: 45)
        
        let measurment3L = Measurement(model: "3L", shoulderMaster: 19, sleeveMaster: 25, chestMaster: 36, waistMaster: 33, hipsMaster: 40, lengthMaster: 33, bicepsMaster: 13.5, cuffMaster: 10, neckMaster: 45)
 
        
        let measurment4L = Measurement(model: "4L", shoulderMaster: 19.5, sleeveMaster: 25.5, chestMaster: 38, waistMaster: 35, hipsMaster: 41, lengthMaster: 33, bicepsMaster: 14, cuffMaster: 10, neckMaster: 45)
        
        let measurment5L = Measurement(model: "5L", shoulderMaster: 19.5, sleeveMaster: 25.5, chestMaster: 40, waistMaster: 37, hipsMaster: 42, lengthMaster: 33, bicepsMaster: 14, cuffMaster: 10, neckMaster: 45)
        
        let measurment6L = Measurement(model: "6L", shoulderMaster: 20, sleeveMaster: 25.5, chestMaster: 42, waistMaster: 39, hipsMaster: 43, lengthMaster: 33, bicepsMaster: 15.5, cuffMaster: 10, neckMaster: 45)
        
        let measurment7L = Measurement(model: "7L", shoulderMaster: 20, sleeveMaster: 25.5, chestMaster: 44, waistMaster: 41, hipsMaster: 44, lengthMaster: 34, bicepsMaster: 15.5, cuffMaster: 10, neckMaster: 45)
        
        let measurment8L = Measurement(model: "8L", shoulderMaster: 21, sleeveMaster: 26, chestMaster: 46, waistMaster: 43, hipsMaster: 45, lengthMaster: 34, bicepsMaster: 16, cuffMaster: 10, neckMaster: 45)
        
        let measurment9L = Measurement(model: "9L", shoulderMaster: 21, sleeveMaster: 26, chestMaster: 48, waistMaster: 46, hipsMaster: 47, lengthMaster: 34, bicepsMaster: 16, cuffMaster: 11, neckMaster: 50)
        
        let measurment10L = Measurement(model: "10L", shoulderMaster: 22, sleeveMaster: 26, chestMaster: 50, waistMaster: 47, hipsMaster: 49, lengthMaster: 35, bicepsMaster: 16.5, cuffMaster: 11, neckMaster: 50)
        
        let measurment11L = Measurement(model: "11L", shoulderMaster: 22, sleeveMaster: 26, chestMaster: 52, waistMaster: 50, hipsMaster: 51, lengthMaster: 35, bicepsMaster: 16.5, cuffMaster: 11, neckMaster: 50)
        
        let measurment12L = Measurement(model: "12L", shoulderMaster: 23, sleeveMaster: 26, chestMaster: 54, waistMaster: 52, hipsMaster: 52, lengthMaster: 36, bicepsMaster: 17, cuffMaster: 11, neckMaster: 50)
        
        let measurment13L = Measurement(model: "13L", shoulderMaster: 23, sleeveMaster: 26, chestMaster: 56, waistMaster: 54, hipsMaster: 54, lengthMaster: 36, bicepsMaster: 17, cuffMaster: 11, neckMaster: 50)
        
        let measurment14L = Measurement(model: "14L", shoulderMaster: 24, sleeveMaster: 26, chestMaster: 60, waistMaster: 58, hipsMaster: 58, lengthMaster: 36, bicepsMaster: 17, cuffMaster: 11, neckMaster: 50)
        
        
        self.measurment.append(measurment1)
        self.measurment.append(measurment2)
        self.measurment.append(measurment3)
        self.measurment.append(measurment4)
        self.measurment.append(measurment5)
        self.measurment.append(measurment6)
        self.measurment.append(measurment7)
        self.measurment.append(measurment8)
        self.measurment.append(measurment9)
        self.measurment.append(measurment10)
        self.measurment.append(measurment11)
        self.measurment.append(measurment12)
        self.measurment.append(measurment13)
        self.measurment.append(measurment14)

        self.measurment.append(measurment1L)
        self.measurment.append(measurment2L)
        self.measurment.append(measurment3L)
        self.measurment.append(measurment4L)
        self.measurment.append(measurment5L)
        self.measurment.append(measurment6L)
        self.measurment.append(measurment7L)
        self.measurment.append(measurment8L)
        self.measurment.append(measurment9L)
        self.measurment.append(measurment10L)
        self.measurment.append(measurment11L)
        self.measurment.append(measurment12L)
        self.measurment.append(measurment13L)
        self.measurment.append(measurment14L)
        
        
        print(measurment)
        
        for i in measurment{
            
            let loopModel = i.model
            
            if loopModel == m{
                
              //  print(i)
               
                completion(true, i, nil)
                break
                
            }
            
        }
        
        
        
    }
    
    
    
}





























