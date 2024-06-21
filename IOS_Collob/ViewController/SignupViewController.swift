//
//  SignupViewController.swift
//  IOS_Collob
//
//  Created by webcodegenie on 20/06/24.
//

import UIKit

class SignupViewController: UIViewController {

    var showPassword = false
    
    @IBOutlet weak var passwordShowBtn: UIButton!
    @IBOutlet var socialsViews: [UIView]!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tfUserPassword: UITextField!
    @IBOutlet weak var tfUserEmail: UITextField!
    @IBOutlet weak var tfUsername: UITextField!
    
//    MARK: - All view's lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfUserPassword.delegate = self
        tfUserEmail.delegate = self
        tfUsername.delegate = self
        
        let tapGesutre = UITapGestureRecognizer(target:self,action:#selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesutre)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        showPassword = false
        passwordShowBtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        tfUserPassword.isSecureTextEntry = true
        
        for socialView in socialsViews {
            socialView.layer.cornerRadius = socialView.frame.height/2
            socialView.clipsToBounds = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
//    MARK: - All IBActions Methods
    
    
    @IBAction func onRegisterBtnPressed(_ sender: Any) {
        let userEnteredName = tfUsername.text!.trimmingCharacters(in: .whitespaces)
        let userEnteredEmail = tfUserEmail.text!.trimmingCharacters(in: .whitespaces).lowercased()
        let userEnteredPassword = tfUserPassword.text!.trimmingCharacters(in: .whitespaces)
        
        
        if userEnteredEmail.isValidEmail() && userEnteredPassword.isValidPassword() && userEnteredName.isValidUsername(){
            UserDefaults.standard.set(userEnteredEmail, forKey: "userEmail")
            UserDefaults.standard.set(userEnteredPassword, forKey: "userPassword")
            
            tfUsername.text  =  ""
            tfUserEmail.text = ""
            tfUserPassword.text = ""
            
            self.navigationController?.popViewController(animated: true)
        }else if userEnteredName.isValidUsername() == false {
            showAlertBox(title: "Invalid Username", message: "Username should be more than 1 character.")
        }else if userEnteredEmail.isValidEmail() == false {
            showAlertBox(title: "Invalid Email", message: "Please enter a valid email, for example : abc@xyz.com")
        }else if userEnteredPassword.isValidPassword() == false {
            showAlertBox(title: "Invalid Password", message: "Please enter a password equal or more than 4 letters or digits.")
        }
        
        
    }
    
    
    
    @IBAction func onPasswordShowBtnPressed(_ sender: Any) {
        if showPassword == false {
            showPassword = true
            tfUserPassword.isSecureTextEntry = false
            passwordShowBtn.setImage(UIImage(systemName: "eye"), for: .normal)
        }else{
            showPassword = false
            tfUserPassword.isSecureTextEntry = true
            passwordShowBtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    
//    MARK: - All objc methods
    
    @objc func keyboardWillShow(notification:NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = 260 + 50
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
                self.navigationController?.popViewController(animated: true)
            case .down:
                print("Swiped down")
            case .left:
                print("Swiped left")
            case .up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    @objc func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    // MARK: - All void methods
    
    func showAlertBox(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}


extension SignupViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
        {
            print("working")
            self.view.endEditing(true)
            return true;
        }
}
