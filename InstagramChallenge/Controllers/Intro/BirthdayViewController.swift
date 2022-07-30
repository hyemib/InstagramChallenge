
import UIKit

class BirthdayViewController: UIViewController {

    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    let datePicker = UIDatePicker()
    var date: Date?
    var birthday: Date?
    var age = 0
    var day = 0
    
    var enableNextButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBirthdayTextFieldDesign()
        setBirthdayTextField()
        setNextButtonDesign()
        configureDatePicker()
    }
    
    func setBirthdayTextFieldDesign() {
        birthdayTextField.layer.borderWidth = 1
        birthdayTextField.layer.borderColor = UIColor.mainBlueColor.cgColor
        birthdayTextField.layer.cornerRadius = 5
        
        ageLabel.isHidden = true
    }
    
    func setBirthdayTextField() {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy년 MM월 dd일"
        formmater.locale = Locale(identifier: "ko_KR")
        date = datePicker.date
        birthdayTextField.placeholder = formmater.string(from: date!)
    }
    
    func setNextButtonDesign() {
        nextButton.layer.cornerRadius = nextButton.frame.height / 5
        nextButton.backgroundColor = .mainBlueBlurColor
    }
    
    func setEnableNextButton() {
        if day > 0 {
            nextButton.backgroundColor = .mainBlueColor
            enableNextButton = true
        } else {
            nextButton.backgroundColor = .mainBlueBlurColor
            enableNextButton = false
        }
    }
    
    func configureDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        birthdayTextField.inputView = datePicker
    }
    
    
    @objc func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy년 MM월 dd일"
        formmater.locale = Locale(identifier: "ko_KR")
        birthday = datePicker.date
        birthdayTextField.text = formmater.string(from: birthday!)
        
        let interval = date!.timeIntervalSince(birthday!)
        day = Int(interval/86400)
        age = day > 0 ? (day/365)+1 : 0
        
        ageLabel.isHidden = false
        ageLabel.text = "\(age)세"
    
        setEnableNextButton()
    }
    
    @IBAction func pressNextButton(_ sender: UIButton) {
        if !enableNextButton { return }
        guard let vc = self.storyboard?.instantiateViewController(identifier: "TermsViewController") as? TermsViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
        
    }
    
}
