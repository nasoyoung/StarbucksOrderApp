//
//  HomeViewController.swift
//  StarbucksOrderApp
//
//  Created by 또영이 on 2021/10/28.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let list = MenuList.dummyList
    
    var coffeeInfo = CoffeeListInformation.sharedInstance
    
    var sendText = "nsy"

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func cartBtn(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "PayViewController") as? PayViewController else { return }
        vc.receiveText = sendText
        
        present(vc, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? OrderViewCell else { return UITableViewCell() }
        
        //configure를 불러 indexPath행에 순서에 맞게 표시
        cell.congigure(coffeeInfo: list[indexPath.row])
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailOrederViewController") as? DetailOrederViewController else { return }
        
        //굳이 셀에 접근 안해도되겠던디 ㅎㅎ list의 인덱스 안에 필요한 속성들만 IndexPath로 긁어서 가져오면 돼 ~~~
        vc.sendCoffeeName = list[indexPath.row].coffeeName
        vc.sendCoffeePrice = list[indexPath.row].price
        vc.sendCoffeeImage = list[indexPath.row].coffeeImage
        
        present(vc, animated: true)
    }
}

class OrderViewCell: UITableViewCell {
    
    @IBOutlet weak var coffeeImage: UIImageView!
    @IBOutlet weak var coffeeName: UILabel!
    @IBOutlet weak var coffeePrice: UILabel!
    
    
    
    func congigure(coffeeInfo: MenuList) {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        //Cell에 생성되는 시점에서 MenuList를 불러 렌더링하기
        coffeeImage.image = coffeeInfo.coffeeImage
        coffeeName.text = coffeeInfo.coffeeName
        coffeePrice.text = (numberFormatter.string(for: coffeeInfo.price) ?? "error") + "원"
    }
}
