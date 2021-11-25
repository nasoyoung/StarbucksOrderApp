//
//  DetailOrederViewController.swift
//  StarbucksOrderApp
//
//  Created by 또영이 on 2021/11/01.
//

import UIKit

class DetailOrederViewController: UIViewController {
    
    private let list = MenuList.dummyList
    
    var coffeeInfo = CoffeeListInformation.sharedInstance
    
    @IBOutlet weak var coffeeName: UILabel!
    @IBOutlet weak var coffeeePrice: UILabel!
    @IBOutlet weak var coffeeImage: UIImageView!
    @IBOutlet weak var tallButton: UIButton!
    @IBOutlet weak var grandeButton: UIButton!
    @IBOutlet weak var ventiButton: UIButton!
    @IBOutlet weak var storeCup: UIButton!
    @IBOutlet weak var personalCup: UIButton!
    @IBOutlet weak var onlyOnceCup: UIButton!
    @IBOutlet weak var orderView: UIView!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    var sendCoffeeImage: UIImage?
    var sendCoffeeName = ""
    var sendCoffeePrice: Int?
    var sendCoffeeValue: Int?
    
    var startNum = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        coffeeName.text = sendCoffeeName
        coffeeePrice.text = (numberFormatter.string(for: (self.sendCoffeePrice ?? 0)) ?? "error") + "원"
        coffeeImage.image = sendCoffeeImage
        
        orderViewLayerSetting()
        cupSizeBorderSettings()
        cupSelectedSettings()
        
        minusButton.isEnabled = false
        
        tallButton.layer.borderColor = #colorLiteral(red: 0, green: 0.6509803922, blue: 0.3843137255, alpha: 1)
        tallButton.layer.borderWidth = 2.0
        
        self.coffeeInfo.receiveCoffeeSize = UserDefaults.standard.stringArray(forKey: "coffeeSize") ?? [String]()
        self.coffeeInfo.receiveCoffeeNames = UserDefaults.standard.stringArray(forKey: "coffeeNames") ?? [String]()
        self.coffeeInfo.receiveCoffeePrice = UserDefaults.standard.array(forKey: "coffeePrice") as? [Int] ?? [Int]()
        self.coffeeInfo.receiveCoffeeCupType = UserDefaults.standard.stringArray(forKey: "coffeeCupType") ?? [String]()
        self.coffeeInfo.receiveCoffeeQuantity = UserDefaults.standard.stringArray(forKey: "coffeeQuantity") ?? [String]()
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    func orderViewLayerSetting() {
        orderButton.layer.cornerRadius = 15
        orderView.layer.shadowColor = UIColor.systemGray.cgColor
        orderView.layer.shadowOffset = CGSize(width: 15, height: 0)
        orderView.layer.shadowOpacity = 0.3
        orderView.layer.shadowRadius = 3
        orderView.layer.masksToBounds = false
    }
    
    func cupSelectedSettings() {
        storeCup.layer.borderWidth = 0.7
        storeCup.layer.borderColor = UIColor.systemGray.cgColor
        
        personalCup.layer.borderWidth = 0.7
        personalCup.layer.borderColor = UIColor.systemGray.cgColor
        
        onlyOnceCup.layer.borderWidth = 0.7
        onlyOnceCup.layer.borderColor = UIColor.systemGray.cgColor
        
        storeCup.layer.cornerRadius = 15
        storeCup.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        onlyOnceCup.layer.cornerRadius = 15
        onlyOnceCup.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    func cupSizeBorderSettings() {
        tallButton.layer.borderColor = UIColor.systemGray.cgColor
        tallButton.layer.borderWidth = 0.7
        tallButton.layer.cornerRadius = 8
        
        grandeButton.layer.borderColor = UIColor.systemGray.cgColor
        grandeButton.layer.borderWidth = 0.7
        grandeButton.layer.cornerRadius = 8
        
        ventiButton.layer.borderColor = UIColor.systemGray.cgColor
        ventiButton.layer.borderWidth = 0.7
        ventiButton.layer.cornerRadius = 8
    }

    @IBAction func tallBtn(_ sender: UIButton) {
        tallButton.layer.borderColor = #colorLiteral(red: 0, green: 0.6509803922, blue: 0.3843137255, alpha: 1)
        tallButton.layer.borderWidth = 2.0
        grandeButton.layer.borderColor = UIColor.systemGray.cgColor
        grandeButton.layer.borderWidth = 0.7
        ventiButton.layer.borderColor = UIColor.systemGray.cgColor
        ventiButton.layer.borderWidth = 0.7
        
        
    }
    
    @IBAction func grandeBtn(_ sender: UIButton) {
        grandeButton.layer.borderColor = #colorLiteral(red: 0, green: 0.6509803922, blue: 0.3843137255, alpha: 1)
        grandeButton.layer.borderWidth = 2.0
        tallButton.layer.borderColor = UIColor.systemGray.cgColor
        tallButton.layer.borderWidth = 0.7
        ventiButton.layer.borderColor = UIColor.systemGray.cgColor
        ventiButton.layer.borderWidth = 0.7
        
    }
    
    @IBAction func ventiBtn(_ sender: UIButton) {
        ventiButton.layer.borderColor = #colorLiteral(red: 0, green: 0.6509803922, blue: 0.3843137255, alpha: 1)
        ventiButton.layer.borderWidth = 2.0
        tallButton.layer.borderColor = UIColor.systemGray.cgColor
        tallButton.layer.borderWidth = 0.7
        grandeButton.layer.borderColor = UIColor.systemGray.cgColor
        grandeButton.layer.borderWidth = 0.7
        
    }
    
    @IBAction func storeCupAction(_ sender: UIButton) {
        storeCup.backgroundColor = #colorLiteral(red: 0, green: 0.6509803922, blue: 0.3843137255, alpha: 1)
        storeCup.setTitleColor(.white, for: .normal)
        
        personalCup.backgroundColor = .white
        personalCup.setTitleColor(.darkGray, for: .normal)
        
        onlyOnceCup.backgroundColor = .white
        onlyOnceCup.setTitleColor(.darkGray, for: .normal)
    }
    
    @IBAction func personalCupAction(_ sender: UIButton) {
        storeCup.backgroundColor = .white
        storeCup.setTitleColor(.darkGray, for: .normal)
        
        personalCup.backgroundColor = #colorLiteral(red: 0, green: 0.6509803922, blue: 0.3843137255, alpha: 1)
        personalCup.setTitleColor(.white, for: .normal)
        
        onlyOnceCup.backgroundColor = .white
        onlyOnceCup.setTitleColor(.darkGray, for: .normal)
    }
    
    @IBAction func onlyOnceCupAction(_ sender: UIButton) {
        storeCup.backgroundColor = .white
        storeCup.setTitleColor(.darkGray, for: .normal)
        
        personalCup.backgroundColor = .white
        personalCup.setTitleColor(.darkGray, for: .normal)
        
        onlyOnceCup.backgroundColor = #colorLiteral(red: 0, green: 0.6509803922, blue: 0.3843137255, alpha: 1)
        onlyOnceCup.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func minusBtn(_ sender: UIButton) {
        startNum -= 1
        valueLabel.text = String(startNum)
        coffeeCountUpDown()
    }
    
    @IBAction func plusBtn(_ sender: UIButton) {
        startNum += 1
        valueLabel.text = String(startNum)
        coffeeCountUpDown()
    }
    
    func coffeeCountUpDown () {
        if startNum == 1 {
            minusButton.isEnabled = false
            plusButton.isEnabled = true
        } else if startNum == 10 {
            minusButton.isEnabled = true
            plusButton.isEnabled = false
        } else {
            minusButton.isEnabled = true
            plusButton.isEnabled = true
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        coffeeePrice.text = (numberFormatter.string(for: (self.sendCoffeePrice ?? 0) * startNum) ?? "error") + "원"
    }
    
    @IBAction func cartBtn(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "PayViewController") as? PayViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        
        print("추가 되는 가격: \(coffeeInfo.receiveCoffeePrice)")
        
        if storeCup.backgroundColor == #colorLiteral(red: 0, green: 0.6509803922, blue: 0.3843137255, alpha: 1) {
            let calculrateValue = (self.sendCoffeePrice ?? 0) * startNum
            coffeeInfo.receiveCoffeeNames.append(self.sendCoffeeName)
            coffeeInfo.receiveCoffeePrice.append(calculrateValue)
            coffeeInfo.receiveCoffeeQuantity.append(String(startNum))
            coffeeInfo.receiveCoffeeCupType.append("매장컵")
            
            if tallButton.layer.borderColor == #colorLiteral(red: 0, green: 0.6509803922, blue: 0.3843137255, alpha: 1) {
                coffeeInfo.receiveCoffeeSize.append("Tall")
            } else if grandeButton.layer.borderColor == #colorLiteral(red: 0, green: 0.6509803922, blue: 0.3843137255, alpha: 1) {
                coffeeInfo.receiveCoffeeSize.append("Grande")
            } else if ventiButton.layer.borderColor == #colorLiteral(red: 0, green: 0.6509803922, blue: 0.3843137255, alpha: 1) {
                coffeeInfo.receiveCoffeeSize.append("Venti")
            }
            
            UserDefaults.standard.set(self.coffeeInfo.receiveCoffeeNames, forKey: "coffeeNames")
            UserDefaults.standard.set(self.coffeeInfo.receiveCoffeeSize, forKey: "coffeeSize")
            UserDefaults.standard.set(self.coffeeInfo.receiveCoffeeQuantity, forKey: "coffeeQuantity")
            UserDefaults.standard.set(self.coffeeInfo.receiveCoffeeCupType, forKey: "coffeeCupType")
            UserDefaults.standard.set(self.coffeeInfo.receiveCoffeePrice, forKey: "coffeePrice")
            
            self.present(vc, animated: true)
            
        } else if personalCup.backgroundColor == #colorLiteral(red: 0, green: 0.6509803922, blue: 0.3843137255, alpha: 1) {
            let calculrateValue = (self.sendCoffeePrice ?? 0) * startNum
            coffeeInfo.receiveCoffeeNames.append(self.sendCoffeeName)
            coffeeInfo.receiveCoffeePrice.append(calculrateValue)
            coffeeInfo.receiveCoffeeQuantity.append(String(startNum))
            coffeeInfo.receiveCoffeeCupType.append("개인컵")
            
            if tallButton.layer.borderColor == #colorLiteral(red: 0, green: 0.6509803922, blue: 0.3843137255, alpha: 1) {
                coffeeInfo.receiveCoffeeSize.append("Tall")
            } else if grandeButton.layer.borderColor == #colorLiteral(red: 0, green: 0.6509803922, blue: 0.3843137255, alpha: 1) {
                coffeeInfo.receiveCoffeeSize.append("Grande")
            } else if ventiButton.layer.borderColor == #colorLiteral(red: 0, green: 0.6509803922, blue: 0.3843137255, alpha: 1) {
                coffeeInfo.receiveCoffeeSize.append("Venti")
            }
            
            UserDefaults.standard.set(self.coffeeInfo.receiveCoffeeNames, forKey: "coffeeNames")
            UserDefaults.standard.set(self.coffeeInfo.receiveCoffeeSize, forKey: "coffeeSize")
            UserDefaults.standard.set(self.coffeeInfo.receiveCoffeeQuantity, forKey: "coffeeQuantity")
            UserDefaults.standard.set(self.coffeeInfo.receiveCoffeeCupType, forKey: "coffeeCupType")
            UserDefaults.standard.set(self.coffeeInfo.receiveCoffeePrice, forKey: "coffeePrice")
            
            self.present(vc, animated: true)
            
        } else if onlyOnceCup.backgroundColor == #colorLiteral(red: 0, green: 0.6509803922, blue: 0.3843137255, alpha: 1) {
            let calculrateValue = (self.sendCoffeePrice ?? 0) * startNum
            coffeeInfo.receiveCoffeeNames.append(self.sendCoffeeName)
            coffeeInfo.receiveCoffeePrice.append(calculrateValue)
            coffeeInfo.receiveCoffeeQuantity.append(String(startNum))
            coffeeInfo.receiveCoffeeCupType.append("일회용컵")
            
            if tallButton.layer.borderColor == #colorLiteral(red: 0, green: 0.6509803922, blue: 0.3843137255, alpha: 1) {
                coffeeInfo.receiveCoffeeSize.append("Tall")
            } else if grandeButton.layer.borderColor == #colorLiteral(red: 0, green: 0.6509803922, blue: 0.3843137255, alpha: 1) {
                coffeeInfo.receiveCoffeeSize.append("Grande")
            } else if ventiButton.layer.borderColor == #colorLiteral(red: 0, green: 0.6509803922, blue: 0.3843137255, alpha: 1) {
                coffeeInfo.receiveCoffeeSize.append("Venti")
            }
            
            UserDefaults.standard.set(self.coffeeInfo.receiveCoffeeNames, forKey: "coffeeNames")
            UserDefaults.standard.set(self.coffeeInfo.receiveCoffeeSize, forKey: "coffeeSize")
            UserDefaults.standard.set(self.coffeeInfo.receiveCoffeeQuantity, forKey: "coffeeQuantity")
            UserDefaults.standard.set(self.coffeeInfo.receiveCoffeeCupType, forKey: "coffeeCupType")
            UserDefaults.standard.set(self.coffeeInfo.receiveCoffeePrice, forKey: "coffeePrice")
            
            self.present(vc, animated: true)
            
        } else {
            presentAlert(message: "컵이 선택되지 않았습니다.")
        }
    }
}

