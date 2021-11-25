//
//  LoginViewController.swift
//  StarbucksOrderApp
//
//  Created by 또영이 on 2021/10/28.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var tfID: UITextField!
    @IBOutlet weak var tfPW: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfID.delegate = self
        tfPW.delegate = self
        
        self.loginBtn.layer.cornerRadius = 15

    }
    
    //빈 화면 터치시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: tfID.text!, password: tfPW.text!) {(user, error ) in
            if user != nil {
                //로그인 성공
                    let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)

            } else {
                //로그인 실패
                self.presentAlert(message: "아이디와 비밀번호를 확인해 주세요!")
            }
        }
    }

    @IBAction func singButton(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignViewController") as? SignViewController else { return }
        vc.modalPresentationStyle = .overCurrentContext
//        vc.view.backgroundColor = .black
//        vc.view.alpha = 0.3
        self.present(vc, animated: false, completion: nil)
    }
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0, width: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
                 paddingLeft: CGFloat = 0, constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        
        if let left = leftAnchor {
            anchor(left: left, paddingLeft: paddingLeft)
        }
    }
    
    func setDimensions(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeight(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(_ width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let view = superview else { return }
        anchor(top: view.topAnchor, left: view.leftAnchor,
               bottom: view.bottomAnchor, right: view.rightAnchor)
    }
}

extension UIViewController {
    
    /// 커스텀 경고창
    /// - 잠시 생겼다가 사라지는 경고창
    func presentAlert(message: String) {
        
        let alertSuperView = UIView()
        alertSuperView.backgroundColor
            = UIColor.black.withAlphaComponent(0.77)
        alertSuperView.layer.cornerRadius = 17
        alertSuperView.isHidden = true
        
        let alertLabel = UILabel()
        alertLabel.font = UIFont.systemFont(ofSize: 12)
        alertLabel.textColor = .white
        
        self.view.addSubview(alertSuperView)
        alertSuperView.centerX(inView: self.view)
        alertSuperView.anchor(bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                              paddingBottom: 70,
                              width: self.view.frame.width * 0.80,
                              height: 37)
        
        alertSuperView.addSubview(alertLabel)
        alertLabel.centerY(inView: alertSuperView)
        alertLabel.centerX(inView: alertSuperView)
        alertLabel.setDimensions(height: 37,
                                 width: self.view.frame.width * 0.83)
        alertLabel.textAlignment = .center
        alertLabel.numberOfLines = 0
        
        alertLabel.text = message
        alertSuperView.alpha = 1.0
        alertSuperView.isHidden = false
        UIView.animate(withDuration: 2.0,
                       delay: 1.0,
                       options: .curveEaseIn,
                       animations: { alertSuperView.alpha = 0 },
                       completion: { _ in
                        alertSuperView.removeFromSuperview()
                       })
    }
}
