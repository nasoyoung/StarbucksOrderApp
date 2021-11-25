//
//  OrderModel.swift
//  StarbucksOrderApp
//
//  Created by 또영이 on 2021/11/01.
//

import Foundation
import UIKit

struct MenuList {
    let coffeeName: String
    let price: Int
    let coffeeImg: String
    
    var coffeeImage: UIImage? {
        let imageName = UIImage(named: coffeeImg)
        return imageName
    }
    
    static var dummyList: [MenuList] {
        return [
            MenuList(coffeeName: "카페 아메리카노", price: 4100, coffeeImg: "Americano"),
            MenuList(coffeeName: "스타벅스 돌체라떼", price: 5600, coffeeImg: "Dolce"),
            MenuList(coffeeName: "블랙 글레이즈드 라떼", price: 6100, coffeeImg: "Glazed"),
            MenuList(coffeeName: "자몽 허니 블랙티", price: 5300, coffeeImg: "Honey"),
            MenuList(coffeeName: "민트 초콜릿 칩 블렌디드", price: 6100, coffeeImg: "Mint"),
            MenuList(coffeeName: "딸기 요거트 블렌디드", price: 6100, coffeeImg: "StrawBerry")
        ]
    }
}

