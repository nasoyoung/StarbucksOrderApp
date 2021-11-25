//
//  CoffeeListInformation.swift
//  StarbucksOrderApp
//
//  Created by 또영이 on 2021/11/08.
//

import Foundation
import UIKit

class CoffeeListInformation {
    public static let sharedInstance: CoffeeListInformation = CoffeeListInformation()
    
    var receiveCoffeeNames: Array<String> = []
    var receiveCoffeePrice: Array<Int> = []
    var receiveCoffeeQuantity: Array<String> = []
    var receiveCoffeeSize: Array<String> = []
    var receiveCoffeeCupType: Array<String> = []
}
