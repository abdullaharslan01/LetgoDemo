import UIKit

class RegisterVC: UIViewController {

    // MARK: - UI Elements

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var fullNameTextField: UITextField!

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var firstPasswordLabel: UILabel!
    @IBOutlet weak var firstPasswordTextField: UITextField!

    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    @IBOutlet weak var registerButton: UIButton!
    
    var isFullNameValid = false
    var isEmailValid = false
    var isPasswordValid = false
    var doPasswordsMatch = false
    
    
    let registerViewModel = RegisterViewModel()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        delegateConfiguration()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // MARK: - Function
    
    func delegateConfiguration() {
        fullNameTextField.delegate = self
        emailTextField.delegate = self
        firstPasswordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
    }
    
    
    func updateButtonAppearance() {
        if isFullNameValid && isEmailValid && isPasswordValid && doPasswordsMatch {
            registerButton.isEnabled = true
            registerButton.backgroundColor = UIColor(named: "main")
            registerButton.setTitleColor(.white, for: .normal)
        } else {
            registerButton.isEnabled = false
            registerButton.backgroundColor = UIColor.systemGray5
            registerButton.setTitleColor(UIColor.black, for: .normal)
        }
    }

    
    
    func fullNameCheck(_ fullName: String) -> Bool {
        return fullName.count >= 3
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    func isValidPassword(_ password: String) -> Bool {
        return password.count > 8
    }

    
    @IBAction func loginButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        let name = fullNameTextField.text
        let email = emailTextField.text
        let password = firstPasswordTextField.text

        let user = User(name: name, email: email, password: password)

        registerViewModel.register(user: user) { success, message in
            DispatchQueue.main.async {
                if success {
                    
                    self.showAlert(title: "SUCCESS", message: message, buttonTitle: "OK") {

                        self.dismiss(animated: true)

                    }
                                    
                    
                    
                } else {
                    self.showAlert(title: "FAIL", message: message, buttonTitle: "OK") {
                        
                    }
                }
            }
        }
    }

}

extension RegisterVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {


        if textField == fullNameTextField {
            let currentText = (textField.text ?? "") as NSString
            let newText = currentText.replacingCharacters(in: range, with: string)
            isFullNameValid = fullNameCheck(newText)
            fullNameTextField.textColor = isFullNameValid ? .black : UIColor(named: "main")
            fullNameLabel.textColor = isFullNameValid ? .black : UIColor(named: "main")
        } else if textField == emailTextField {
            let currentText = (textField.text ?? "") as NSString
            let newText = currentText.replacingCharacters(in: range, with: string)
            isEmailValid = isValidEmail(newText)
            emailTextField.textColor = isEmailValid ? .black : UIColor(named: "main")
            emailLabel.textColor = isEmailValid ? .black : UIColor(named: "main")
        } else if textField == firstPasswordTextField || textField == confirmPasswordTextField {
            let currentText = (textField.text ?? "") as NSString
            let newText = currentText.replacingCharacters(in: range, with: string)
            isPasswordValid = isValidPassword(newText)
            textField.textColor = isPasswordValid ? .black : UIColor(named: "main")
            
            if textField == firstPasswordTextField {
                firstPasswordLabel.textColor = isPasswordValid ? .black : UIColor(named: "main")
            } else {
                confirmPasswordLabel.textColor = isPasswordValid ? .black : UIColor(named: "main")
                doPasswordsMatch = firstPasswordTextField.text == newText
            }
        }

        updateButtonAppearance()
        
        return true
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateButtonAppearance()
    }
   

}

