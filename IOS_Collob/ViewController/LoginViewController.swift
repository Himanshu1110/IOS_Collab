//
//  LoginViewController.swift
//  IOS_Collob
//
//  Created by webcodegenie on 20/06/24.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {

    var showPassword = false
    
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var passwordShowBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var tfUserPassword: UITextField!
    @IBOutlet weak var tfUserEmail: UITextField!
    
//    MARK: - All View Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfUserPassword.delegate = self
        tfUserEmail.delegate = self
        
        let tapGesutre = UITapGestureRecognizer(target:self,action:#selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesutre)
        
        if UserDefaults.standard.bool(forKey: "IsUserLoggedIn"){
            moveToHomeScreen()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        print("\nEmail :",UserDefaults.standard.string(forKey: "userEmail") ?? "","\nPassword :",UserDefaults.standard.string(forKey: "userPassword") ?? "")
        
        showPassword = false
        passwordShowBtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        tfUserPassword.isSecureTextEntry = true

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    
//  MARK: - All IBActions methods
    @IBAction func onLoginBtnPressed(_ sender: Any) {
        let userEnteredEmail = tfUserEmail.text!.lowercased()
        let userEnteredPassword = tfUserPassword.text!
            
            if  (userEnteredEmail == UserDefaults.standard.string(forKey: "userEmail")) && (userEnteredPassword == UserDefaults.standard.string(forKey: "userPassword")){
                
                tfUserEmail.text = ""
                tfUserPassword.text = ""
                
                UserDefaults.standard.set(true, forKey: "IsUserLoggedIn")
                moveToHomeScreen()
                print("User Logged In !!!")
            }else{
                showAlertBox(title: "Invalid Credentials, Wrong email or password", message: "Please enter valid credentials to login.")
            }
            
    }
    
    
    @IBAction func onRegisterBtnPressed(_ sender: Any) {
        let signupScreen = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        
        navigationController?.pushViewController(signupScreen, animated: true)
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
    
    
    @IBAction func onGoogleBtnPressed(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self){ signInResult, error in

            guard error == nil else { return }

          // If sign in succeeded, display the app's main content View.
            guard let signInResult = signInResult else { return }
            let user = signInResult.user

            let emailAddress = user.profile?.email
            let fullName = user.profile?.name
            let familyName = user.profile?.familyName
            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
            
            
            print(fullName!,emailAddress!,familyName!,profilePicUrl!)

            self.moveToHomeScreen()
        }
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = 260 + 20
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    
    @objc func hideKeyboard(){
        self.view.endEditing(true)
    }
    
//    MARK: All void methods
    
    func showAlertBox(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func moveToHomeScreen(){
        let MainScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomTabbarController") as! CustomTabbarController
        
        self.navigationController?.pushViewController(MainScreen, animated: true)
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

extension LoginViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
        {
            self.view.endEditing(true)
            return true;
        }
}
