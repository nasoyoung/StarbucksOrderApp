//
//  EventViewController.swift
//  StarbucksOrderApp
//
//  Created by 또영이 on 2021/10/28.
//

import UIKit
import UserNotifications

class EventViewController: UIViewController {
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var infoImage: UIImageView!
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    var infoImg = ["InfoImg", "InfoImg2", "InfoImg3", "EventImg", "EventImg2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestNotificationAuthorization()
        
        self.closeBtn.layer.cornerRadius = 15
    }

    // 뷰가 화면에 나타나기 직전에 이미지 호출 & 이미지 랜덤 구현
    override func viewWillAppear(_ animated: Bool) {
        infoImage.image = UIImage(named: String(infoImg[0...4].randomElement() ?? "nil"))
    }
    
    //사용자에게 알림 권한 요청 (노티피케이션)
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)

        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
}
