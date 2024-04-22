import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        

        email.delegate = self
        password.delegate = self
        updateButtonAppearance(isValidEmail: false, isValidPassword: false)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
        
        //print(email.text, password.text)
    }

    @IBAction func registerButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: SegueNames.registerVC.rawValue, sender: nil)
        
        
    }

    func updateButtonAppearance(isValidEmail: Bool, isValidPassword: Bool) {
        if isValidEmail && isValidPassword {
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

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let emailText = email.text, let passwordText = password.text else { return }

        let isEmailValid = isValidEmail(emailText)
        let isPasswordValid = isValidPassword(passwordText)

        emailLabel.textColor = isEmailValid ? UIColor.black : UIColor(named: "main")
        passwordLabel.textColor = isPasswordValid ? UIColor.black : UIColor(named: "main")

        updateButtonAppearance(isValidEmail: isEmailValid, isValidPassword: isPasswordValid)
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func isValidPassword(_ password: String) -> Bool {
        return password.count > 8 && !password.isEmpty
    }
}

