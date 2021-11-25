//
//  PayViewController.swift
//  StarbucksOrderApp
//
//  Created by 또영이 on 2021/11/02.
//

import UIKit
import UserNotifications

class PayViewController: UIViewController {
    
    private let list = MenuList.dummyList
    
    var coffeeInfo = CoffeeListInformation.sharedInstance
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tfNickName: UITextField!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var coffeeTotalPrice: UILabel!
    
    //장바구니 인식 키 뒤로가기 한번 두번
    var receiveText = ""
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.coffeeInfo.receiveCoffeeSize = UserDefaults.standard.stringArray(forKey: "coffeeSize") ?? [String]()
        self.coffeeInfo.receiveCoffeeNames = UserDefaults.standard.stringArray(forKey: "coffeeNames") ?? [String]()
        self.coffeeInfo.receiveCoffeePrice = UserDefaults.standard.array(forKey: "coffeePrice") as? [Int] ?? [Int]()
        self.coffeeInfo.receiveCoffeeCupType = UserDefaults.standard.stringArray(forKey: "coffeeCupType") ?? [String]()
        self.coffeeInfo.receiveCoffeeQuantity = UserDefaults.standard.stringArray(forKey: "coffeeQuantity") ?? [String]()
        
        self.tableView.reloadData()
        
        buttonSetting()
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        coffeeTotalPrice.text = (numberFormatter.string(for: coffeeInfo.receiveCoffeePrice.reduce(0, +)) ?? "error") + "원"
        
    }
    
    //빈 화면 터치시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func buttonSetting() {
        backButton.layer.cornerRadius = 20
        payButton.layer.cornerRadius = 20
        
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        
        if receiveText == "nsy" {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func payBtn(_ sender: UIButton) {
        
        let alertVC = UIAlertController(title: "알림", message: "결제가 완료되었습니다.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .default, handler: { _ in
            
            self.userNotificationCenter.delegate = self
            self.sendNotification(seconds: 5)
            
            self.coffeeInfo.receiveCoffeeNames.removeAll()
            self.coffeeInfo.receiveCoffeePrice.removeAll()
            self.coffeeInfo.receiveCoffeeQuantity.removeAll()
            self.coffeeInfo.receiveCoffeeSize.removeAll()
            self.coffeeInfo.receiveCoffeeCupType.removeAll()
            
            UserDefaults.standard.removeObject(forKey: "coffeeNames")
            UserDefaults.standard.removeObject(forKey: "coffeeSize")
            UserDefaults.standard.removeObject(forKey: "coffeeQuantity")
            UserDefaults.standard.removeObject(forKey: "coffeeCupType")
            UserDefaults.standard.removeObject(forKey: "coffeePrice")
            
            self.tableView.reloadData()
            
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            
        })
        
        alertVC.addAction(alertAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    //알림 전송
    func sendNotification(seconds: Double) {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "스타벅스"
        notificationContent.body = "\(tfNickName.text ?? "")님 메뉴 준비중 입니다⭐️"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: "testNotification",
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
}

extension PayViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .badge, .sound, .banner])
        
    }
}

//MARK: - TableView

extension PayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeeInfo.receiveCoffeeNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2") as? PayViewCell else { return UITableViewCell() }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        cell.lblCoffeeName.text = coffeeInfo.receiveCoffeeNames[indexPath.row]
        cell.lblCoffeePrice.text = (numberFormatter.string(for: coffeeInfo.receiveCoffeePrice[indexPath.row]) ?? "error") + "원"
        cell.lblCoffeeQuantity.text = coffeeInfo.receiveCoffeeQuantity[indexPath.row]
        cell.coffeeSize.text = coffeeInfo.receiveCoffeeSize[indexPath.row]
        cell.coffeeCupType.text = coffeeInfo.receiveCoffeeCupType[indexPath.row]
        cell.deleteButton.addTarget(self, action: #selector(deleteAction(_:)), for: .touchUpInside)
        cell.deleteButton.tag = indexPath.row
        
        return cell
    }
    
    @objc func deleteAction(_ sender: UIButton!) {
        coffeeInfo.receiveCoffeeNames.remove(at: sender.tag)
        coffeeInfo.receiveCoffeePrice.remove(at: sender.tag)
        coffeeInfo.receiveCoffeeQuantity.remove(at: sender.tag)
        coffeeInfo.receiveCoffeeSize.remove(at: sender.tag)
        coffeeInfo.receiveCoffeeCupType.remove(at: sender.tag)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        coffeeTotalPrice.text = (numberFormatter.string(for: coffeeInfo.receiveCoffeePrice.reduce(0, +)) ?? "error") + "원"
        
        UserDefaults.standard.set(coffeeInfo.receiveCoffeeNames, forKey: "coffeeNames")
        UserDefaults.standard.set(coffeeInfo.receiveCoffeeSize, forKey: "coffeeSize")
        UserDefaults.standard.set(coffeeInfo.receiveCoffeeQuantity, forKey: "coffeeQuantity")
        UserDefaults.standard.set(coffeeInfo.receiveCoffeeCupType, forKey: "coffeeCupType")
        UserDefaults.standard.set(coffeeInfo.receiveCoffeePrice, forKey: "coffeePrice")
        
        self.tableView.reloadData()
        
        print("커피이름: \(coffeeInfo.receiveCoffeeNames)")
        print("커피가격: \(coffeeInfo.receiveCoffeePrice)")
        print("커피수량: \(coffeeInfo.receiveCoffeeQuantity)")
        print("커피사이즈: \(coffeeInfo.receiveCoffeeSize)")
        print("커피종류: \(coffeeInfo.receiveCoffeeCupType)")
    }
}

class PayViewCell: UITableViewCell {
    @IBOutlet weak var lblCoffeeName: UILabel!
    @IBOutlet weak var lblCoffeeQuantity: UILabel!
    @IBOutlet weak var lblCoffeePrice: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var coffeeSize: UILabel!
    @IBOutlet weak var coffeeCupType: UILabel!
}
