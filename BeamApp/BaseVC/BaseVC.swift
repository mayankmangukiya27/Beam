import UIKit
import SnapKit
import FloatingPanel
import CoreLocation
import MapKit

enum NavigationBarType {
    case none
    case title
    case image
}

class BaseVC: UIViewController {

    var pageTitle: String = ""{
        didSet{
            self.titleLableString.text = pageTitle
        }
    }
    var subTitle: String = ""
    var navigationBarType: NavigationBarType = .none
    var shouldHideNotificationButton = true
    var shoudHideBackButton = false
    let locationManager = CLLocationManager()
    var titleLableString = AppLabel()
    let fpc = FloatingPanelController()
    var tapFilter: TapFilter?
    var blurView: UIVisualEffectView?
    
    var menuActionHandler: (() -> Void)?
    var shareActionHandler: (() -> Void)?
    var searchActionHandler: (() -> Void)?
    var backItemActionHandler: (() -> Void)?

   
    override func viewDidLoad() {
        super.viewDidLoad()
        changeNavigationBar(withMenu: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        fpc.dismiss(animated: true, completion: nil)
    }

    func changeNavigationBar(withMenu: Bool = false) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = false
        self.navigationController?.navigationBar.barTintColor = UIColor.AppColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.AppColor.navTintColor]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        switch self.navigationBarType {
        case .none:
            self.navigationController?.navigationBar.isHidden = true
        case .title:
            setNavigationTitle()
        case .image:
            setNavigationImage()

        }
       
       if !shouldHideNotificationButton {
        setNavigationMenuButton()
       
       }
       
        if !shoudHideBackButton{
            addLeftHomeBarButton()
        }
    }
 
    func setNavigationTitle() {
        if !pageTitle.isEmpty {
            titleLableString = AppLabel.init(frame: .zero)
            titleLableString.font = UIFont(name: UIFont.AppFont.semiBold, size: 18)
            titleLableString.textString = pageTitle
            titleLableString.textColor = UIColor.AppColor.white
            titleLableString.textAlignment = .center
            titleLableString.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 34)
            let view = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 34))
            view.spacing = 8
            view.addArrangedSubview(titleLableString)
            navigationItem.titleView =  view
        }
    }
    private func setNavigationImage() {
        let view = UIView()
        let titleImage = UIImageView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 200, height: 40)))
        titleImage.image = #imageLiteral(resourceName: "Logo").withInsets(UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0))
        titleImage.contentMode = .scaleAspectFit
        titleImage.center = view.center
        view.addSubview(titleImage)
        self.navigationItem.titleView = view
    }
    
    func addLeftHomeBarButton(){
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        btn.addTarget(self, action: #selector(btnDotsPressed), for: .touchUpInside)
      //  btn.setImage(#imageLiteral(resourceName: "Back"), for: .normal)
        btn.contentMode = .scaleAspectFit
        btn.layer.borderColor = UIColor.AppColor.text.cgColor
        btn.layer.borderWidth = 1.0
        btn.layer.cornerRadius = 4.0
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
    }
    
    func addRightShareBtn(){
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 51, height: 32))
        btn.addTarget(self, action: #selector(btnSharePressed), for: .touchUpInside)
        btn.setImage(#imageLiteral(resourceName: "icn_share"), for: .normal)
        btn.contentMode = .scaleAspectFit
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
    }
    
    func setNavigationMenuButton() {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        btn.addTarget(self, action: #selector(btnMenuPressed), for: .touchUpInside)
        btn.setImage(#imageLiteral(resourceName: "Bell"), for: .normal)
        btn.contentMode = .scaleAspectFit
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
    }
    
    private let lbl = AppLabel()
    func showNoDataMsg(message: String, inCenter:Bool = true) {
        lbl.fontSize = "18"
        lbl.txtColorCode = "textBlack"
        lbl.textString = message
        lbl.tag = 500
        if !lbl.isDescendant(of: self.view) {
            self.view.addSubview(lbl)
        }
        if inCenter{
            lbl.snp.makeConstraints({
                $0.center.equalTo(view.snp.center)
            })
        }
        else{
            lbl.snp.makeConstraints({
                $0.centerX.equalTo(view.snp.centerX)
                $0.centerY.equalTo(view.snp.centerY).multipliedBy(1.5)
            })
        }
    }
    
    func removeNoDataLabel(){
        view.viewWithTag(500)?.removeFromSuperview()
    }
    
    @objc func backButtonAction() {
        self.backItemActionHandler?()
    }
    
    @objc  func btnDotsPressed(){
      
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc private func btnSharePressed(){
        self.shareActionHandler?()
    }
    
    @objc private func btnMenuPressed(){
    }
    
}

