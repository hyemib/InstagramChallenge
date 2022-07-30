
import UIKit
import SafariServices

class TermsViewController: UIViewController {

    @IBOutlet weak var allAgreementButtonImage: UIImageView!
    @IBOutlet weak var allAgreementButton: UIButton!
    @IBOutlet weak var useTermsButtonImage: UIImageView!
    @IBOutlet weak var useTermsButton: UIButton!
    @IBOutlet weak var dataButtonImage: UIImageView!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var locationButtonImage: UIImageView!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    var agreementCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setContinueButtonDesign()
    }
    
    func clickTermsButtonDesign(image: UIImageView) {
        image.image = UIImage(systemName: "checkmark.circle.fill")
        image.tintColor = .mainBlueColor
    }
    
    func unClickTermsButtonDesign(image: UIImageView) {
        image.image = UIImage(systemName: "circle")
        image.tintColor = .mainLightGrayColor
    }
    
    func setEnableContiuneButton() {
        if agreementCount == 3 {
            continueButton.backgroundColor = .mainBlueColor
        } else {
            continueButton.backgroundColor = .mainBlueBlurColor
        }
    }
    
    func clickTermsButton(button: UIButton, image: UIImageView) {
        if button.isSelected {
            unClickTermsButtonDesign(image: image)
            agreementCount -= 1
        } else {
            clickTermsButtonDesign(image: image)
            agreementCount += 1
        }
        setEnableContiuneButton()
        button.isSelected = !button.isSelected
    }
    
    @IBAction func clickAllAgreementButton(_ sender: UIButton) {
        if sender.isSelected {
            for button in [allAgreementButton, useTermsButton, dateButton, locationButton] {
                button?.isSelected = false
            }
            for image in [allAgreementButtonImage, useTermsButtonImage, dataButtonImage, locationButtonImage] {
                unClickTermsButtonDesign(image: image!)
            }
            agreementCount = 0
        } else {
            for button in [allAgreementButton, useTermsButton, dateButton, locationButton] {
                button?.isSelected = true
            }
            for image in [allAgreementButtonImage, useTermsButtonImage, dataButtonImage, locationButtonImage] {
                clickTermsButtonDesign(image: image!)
            }
            agreementCount = 3
        }
        setEnableContiuneButton()
    }
    
    func unclickAllAgreementButton() {
        allAgreementButton.isSelected = false
        unClickTermsButtonDesign(image: allAgreementButtonImage)
    }

    @IBAction func clickUseTermsButton(_ sender: UIButton) {
        clickTermsButton(button: useTermsButton, image: useTermsButtonImage)
        unclickAllAgreementButton()
    }
    
    @IBAction func clickDataButton(_ sender: UIButton) {
        clickTermsButton(button: dateButton, image: dataButtonImage)
        unclickAllAgreementButton()
    }
    
    @IBAction func clickLocationButton(_ sender: UIButton) {
        clickTermsButton(button: locationButton, image: locationButtonImage)
        unclickAllAgreementButton()
    }
    
    @IBAction func moveWebView(_ sender: UIButton) {
        let url = NSURL(string: "https://gridgetest.oopy.io")
        let safariView = SFSafariViewController(url: url as! URL)
        self.present(safariView, animated: true, completion: nil)
    }
    
    func setContinueButtonDesign() {
        continueButton.layer.cornerRadius = continueButton.frame.height / 5
        continueButton.backgroundColor = .mainBlueBlurColor
    }
    
   
    @IBAction func pressContinueButton(_ sender: UIButton) {
        if agreementCount < 3 { return }
        guard let vc = self.storyboard?.instantiateViewController(identifier: "UserNameViewController") as? UserNameViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}
