//
//  ProfilePicImage.swift

//

import UIKit
import SnapKit

class ProfilePicView:UIView
{
    var empltyImageView:UIImageView = UIImageView()
    var filledImageView:UIImageView = UIImageView()
    var editButton:UIButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.backgroundColor = UIColor.AppColor.profilePicBg
        self.clipsToBounds = true
        
        empltyImageView = UIImageView.init(image: UIImage.init(named: "camera"))
        self.addSubview(empltyImageView)
        empltyImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        filledImageView = UIImageView.init()
        self.addSubview(filledImageView)
        filledImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        editButton = UIButton.init(type: .custom)
        editButton.setImage(UIImage.init(named: "ProfilePicEdit"), for: .normal)
        self.addSubview(editButton)
        editButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        empltyImageView.isHidden = true
        filledImageView.isHidden = true
        editButton.isHidden = true
    }
    
    func loadImageUrlString(urlString:String?)
    {
        guard let urlString = urlString, urlString.isValid else
        {
            empltyImageView.isHidden = false
            filledImageView.isHidden = true
            
            return
        }
        empltyImageView.isHidden = true
        filledImageView.loadFromUrlString(urlString, placeholder: nil, needAccess: false) {(result) in
            
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.cornerRadiusValue = frame.size.width/2.0
        
    }
}
