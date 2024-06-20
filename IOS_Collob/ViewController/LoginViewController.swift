//
//  LoginViewController.swift
//  IOS_Collob
//
//  Created by webcodegenie on 20/06/24.
//

import UIKit

class LoginViewController: UIViewController {

    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var socialsViews: [UIView]!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var tfUserPassword: UITextField!
    @IBOutlet weak var tfUserEmail: UITextField!
    
//    MARK: - All View Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        for socialView in socialsViews {
            socialView.layer.cornerRadius = socialView.frame.height/2
            socialView.clipsToBounds = true
        }
        
    }
    
    func moveToHomeScreen(){
        let homeScreen = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        self.navigationController?.pushViewController(homeScreen, animated: true)
    }
    
//  MARK: - All IBActions methods
    @IBAction func onLoginBtnPressed(_ sender: Any) {
        let userEnteredEmail = tfUserEmail.text!
        let userEnteredPassword = tfUserPassword.text!
        
        if  userEnteredEmail.isValidEmail() && userEnteredPassword.isValidPassword(){
            
            if  (userEnteredEmail == UserDefaults.standard.string(forKey: "userEmail")) && (userEnteredPassword == UserDefaults.standard.string(forKey: "userPassword")){
                moveToHomeScreen()
                print("User Logged In !!!")
            }else{
                showAlertBox(title: "Invalid Credentials, Wrong email or password", message: "Please enter valid credentials to login.")
            }
            
        }else if userEnteredEmail.isValidEmail() == false {
            showAlertBox(title: "Invalid Email", message: "Please enter valid email to proceed.")
        }else if userEnteredPassword.isValidPassword() == false {
            showAlertBox(title: "Invalid Password", message: "Please enter a password equal or more than 4 letters or digits.")
        }
        
        
    }
    
    
    @IBAction func onRegisterBtnPressed(_ sender: Any) {
        let signupScreen = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        
        navigationController?.pushViewController(signupScreen, animated: true)
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    
    func showAlertBox(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

}

// MARK: - All Extensions

extension String {
    
    func isValidUsername() -> Bool{
        if self.count > 0 {
            return true
        }
        return false
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool{
        if self.count >= 4 {
            return true
        }
        return false
    }
    
    
}
