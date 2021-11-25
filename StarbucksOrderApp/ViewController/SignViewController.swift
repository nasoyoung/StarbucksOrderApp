//
//  SignViewController.swift
//  StarbucksOrderApp
//
//  Created by 또영이 on 2021/10/28.
//

import UIKit
import FirebaseAuth

class SignViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var singView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var signBtn: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var PWTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTF.delegate = self
        PWTF.delegate = self
        
        self.singView.layer.cornerRadius = 16
        self.cancelBtn.layer.cornerRadius = 10
        self.signBtn.layer.cornerRadius = 10

    }
    
    //빈 화면 터치시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
    
    @IBAction func signButton(_ sender: UIButton) {
        
        Auth.auth().createUser(withEmail: emailTF.text!, password: PWTF.text!) {(user, error) in
            
            if user != nil {
                //회원가입 정상 처리 후 다음 로직, 로그인 페이지 또는 바로 로그인 시키기
                let alret = UIAlertController(title: "완료", message: "회원가입이 정상적으로 처리되었습니다. 로그인 해주세요", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default, handler: {_ in
                    let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                })
                alret.addAction(action)
                self.present(alret, animated: true, completion: nil)
                
            } else {
                //회원가입 실패
                let alret = UIAlertController(title: "경고", message: "이메일 형식이 아니거나 비밀번호 8자리 이상이 아닙니다.", preferredStyle: .alert)
                let action = UIAlertAction(title: "닫기", style: .default, handler: nil)
                alret.addAction(action)
                self.present(alret, animated: true, completion: nil)
            }
        }
    }
}
