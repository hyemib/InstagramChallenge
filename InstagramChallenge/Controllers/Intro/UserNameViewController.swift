
import UIKit

class UserNameViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var clearButtonImage: UIImageView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    private let userDataService = UserDataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userNameTextField.delegate = self
        
        userNameTextField.addLeftPaading(padding: 10)
        setNextButtonDesign()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
    func setNextButtonDesign() {
        nextButton.layer.cornerRadius = nextButton.frame.height / 5
        nextButton.backgroundColor = .mainBlueColor
    }
    
    func checkTextFieldMaxLength(textField: UITextField!, maxLength: Int) {
        if textField.text?.count ?? 0 > maxLength {
            textField.deleteBackward()
        }
    }
    
    @IBAction func setUserNameTextField_(_ sender: Any) {
        checkTextFieldMaxLength(textField: userNameTextField, maxLength: 20)
        errorMessage.text = ""
        userNameTextField.layer.borderWidth = 1
        userNameTextField.layer.borderColor = UIColor.mainLightGrayColor.cgColor
        userNameTextField.layer.cornerRadius = 5
    }
    
    @IBAction func clearTextFieldText(_ sender: UIButton) {
        userNameTextField.text = ""
    }
    
    func isValidUserName(textField: UITextField!) -> Bool {
        guard textField.text != nil else { return false }
        let regEx = "^[0-9a-z_.]*$"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: textField.text)
    }
    
    func didSuceessUserName() {
        signUp.loginId = userNameTextField.text!
        kakaoSignUp.loginId = userNameTextField.text!
        
        clearButtonImage.image = UIImage(systemName: "checkmark.circle")
        clearButtonImage.tintColor = UIColor(red: 126/255, green: 208/255, blue: 98/255, alpha: 1.0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "FinalConfirmationViewController") as? FinalConfirmationViewController else { return }
            vc.id = self.userNameTextField.text!
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    func didFailUserName() {
        userNameTextField.layer.borderWidth = 1
        userNameTextField.layer.borderColor = UIColor.red.cgColor
        userNameTextField.layer.cornerRadius = 5
        errorMessage.text = "사용자 이름 \(userNameTextField.text!)을(를) 사용할 수 없습니다."
    }
    
    @IBAction func pressNextButton(_ sender: UIButton) {
        if isValidUserName(textField: userNameTextField) {
            userDataService.requestFetchCheckDuplicateLoginId(loginId: userNameTextField.text!, delegate: self)
        } else {
            let alret = UIAlertController(title: "아이디는 영어,숫자,'_','.'만 사용 가능합니다.", message: "", preferredStyle: .alert)
            let yes = UIAlertAction(title: "확인", style: .default)
            alret.addAction(yes)
            present(alret, animated: true, completion: nil)
        }
    }
    
    @IBAction func moveLoginView(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}
