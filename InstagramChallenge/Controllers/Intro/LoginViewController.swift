
import UIKit
import Firebase
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

var signUp = SignUpRequest()
var kakaoSignUp = KakaoSignUpRequest()

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordViewButtonImgae: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    
    private let userDataService = UserDataService()

    var viewPassword = true
    var enableLoginButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.delegate = self
        passwordTextField.delegate = self
        
        passwordTextField.isSecureTextEntry = viewPassword
        
        setTextFieldDesign()
        setLoginOrJoinButtonDesign(button: loginButton)
        
       // userDataService.requestFetchAutoSignIn(delegate: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setTextFieldDesign() {
        idTextField.addLeftPaading(padding: 10)
        passwordTextField.addLeftPaading(padding: 10)
    }

    @IBAction func setIdTextField_(_ sender: Any) {
        checkTextFieldMaxLength(textField: idTextField, maxLength: 20)
        setEnableLoginButton()
    }
    
    @IBAction func setPasswordTextField_(_ sender: Any) {
        checkTextFieldMaxLength(textField: passwordTextField, maxLength: 20)
        setEnableLoginButton()
    }
    
    @IBAction func changePasswordSecure(_ sender: Any) {
        if viewPassword {
            passwordTextField.isSecureTextEntry = false
            passwordViewButtonImgae.image = UIImage(named: "password_view_true")
        } else {
            passwordTextField.isSecureTextEntry = true
            passwordViewButtonImgae.image = UIImage(named: "password_view_false")
        }
        viewPassword = !viewPassword
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            pressLoginButton(loginButton)
        }
        return true
    }
    
    func setEnableLoginButton() {
        if idTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            loginButton.backgroundColor = .mainBlueBlurColor
            enableLoginButton = false
        } else {
            loginButton.backgroundColor = .mainBlueColor
            enableLoginButton = true
        }
    }
    
    func isValidLogin(textField: UITextField!, minLength: Int, maxLength: Int) -> Bool {
        guard textField.text != nil else { return false }
        var regEx = ""
        if textField == idTextField {
            regEx = "^.{\(minLength),\(maxLength)}"
        } else if textField == passwordTextField {
            regEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{\(minLength),\(maxLength)}"
        }
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: textField.text)
    }
    
    func didFailLogin() {
        let alret = UIAlertController(title: "계정을 찾을 수 없음", message: "\(idTextField.text!)에 연결된 계정을 찾을 수 없습니다. 다른 전화번호나 이메일 주소를 사용해보세요. Instagram 계정이 없으면 가입할 수 있습니다.", preferredStyle: .alert)
        let join = UIAlertAction(title: "가입하기", style: .default) {_ in
            self.moveJoinView()
        }
        let retry = UIAlertAction(title: "다시 시도", style: .default)
        alret.addAction(join)
        alret.addAction(retry)
        present(alret, animated: true, completion: nil)
    }
    
    
    @IBAction func pressLoginButton(_ sender: UIButton) {
        if !enableLoginButton { return }
    
        if isValidLogin(textField: idTextField, minLength: 3, maxLength: 20) && isValidLogin(textField: passwordTextField, minLength: 6, maxLength: 20) {
            userDataService.requestFetchSignIn(SignInRequest(loginId: idTextField.text!, password: passwordTextField.text!), delegate: self)
            
        } else {
            didFailLogin()
        }
        
    }
    
    func moveJoinView() {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "JoinViewController") as? JoinViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func pressJoinButton(_ sender: UIButton) {
        moveJoinView()
    }
    
    @IBAction func pressKakaoLoginButton(_ sender: UIButton) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
             if let _ = error {
                 self.presentFailKakaoLoginAlert()
             } else {
                 UserApi.shared.me {(user, error) in
                     if let _ = error {
                         self.presentFailKakaoLoginAlert()
                     } else {
                         self.userDataService.requestFetchKakaoSignIn(KakaoSignInRequest(accessToken: oauthToken!.accessToken), delegate: self)
                         kakaoSignUp.accessToken = oauthToken!.accessToken
                     }
                 }
             }
        }
    }
}
