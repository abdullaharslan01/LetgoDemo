import UIKit

class LoginVC: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - Properties
    
    var isEmailValid = false
    var isPasswordValid = false
    
    let loginViewModel = LoginViewModel()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        updateButtonAppearance()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // MARK: - Actions
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else{return}
        
        loginViewModel.login(email: email, password: password) { response in
            
            if let response = response {
                
                if response.success == 1 {
                    
                    UserPref().loginStatusSet(status: .active)
                    
                    DispatchQueue.main.async {
                       
                        UserPref().setUserInfo(user: response.liste![0])
                        
                        self.showAlert(title: "Success", message: response.message, buttonTitle: "OK") {
                            self.performSegue(withIdentifier: SegueRoutes.tabbarVC.rawValue, sender: nil)

                        }
                        
                        
                        
                    }
                    
                    
                }
                else {
                    
                    DispatchQueue.main.async {
                        self.showAlert(title: "Fail", message: response.message, buttonTitle: "OK") {
                            
                        }
                        
                    }
                    
                    
                    
                }
            }
            
            
        }
        
        
        
        
    }

    @IBAction func registerButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: SegueRoutes.registerVC.rawValue, sender: nil)
    }

    // MARK: - Helper Methods

    func updateButtonAppearance() {
        
        if isEmailValid && isPasswordValid {
            nextButton.isEnabled = true
            nextButton.backgroundColor = UIColor(named: "main")
            nextButton.setTitleColor(.white, for: .normal)
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = UIColor.systemGray5
            nextButton.setTitleColor(UIColor.black, for: .normal)
        }
    }

}

extension LoginVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
           if textField == emailTextField {
               
               let currentText = (textField.text ?? "") as NSString
               let newText = currentText.replacingCharacters(in: range, with: string)
                isEmailValid = isValidEmail(newText)
               emailLabel.textColor = isEmailValid ? .black : UIColor(named: "main")
               
               emailTextField.textColor = isEmailValid ? .black : UIColor(named: "main")
               
           } else if textField == passwordTextField {

               let currentText = (textField.text ?? "") as NSString
               let newText = currentText.replacingCharacters(in: range, with: string)
                isPasswordValid = isValidPassword(newText)
               
               passwordTextField.textColor = isPasswordValid ? .black : UIColor(named: "main")
               passwordLabel.textColor = isPasswordValid ? .black : UIColor(named: "main")
               
           }
        updateButtonAppearance()
           return true
       }

    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    

    func isValidPassword(_ password: String) -> Bool {
        return password.count > 8
    }
}

