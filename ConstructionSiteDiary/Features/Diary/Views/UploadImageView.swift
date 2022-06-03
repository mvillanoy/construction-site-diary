//
//  UploadImageView.swift
//  ConstructionSiteDiary
//
//  Created by Monica Villanoy on 6/3/22.
//

import UIKit

protocol UploadImageViewDelegate{
    func deleted(deletedSubview:UploadImageView)
}
class UploadImageView: UIView {
    var delegate:UploadImageViewDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!{
        didSet {
            
        }
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        self.delegate?.deleted(deletedSubview: self)
    }
    
    func setImage(image:UIImage){
        imageView.image = image
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.heightAnchor.constraint(equalToConstant: 75).isActive = true
        self.widthAnchor.constraint(equalToConstant: 75).isActive = true
        self.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        self.isUserInteractionEnabled = true;
    }
    
    class func loadNib() -> UploadImageView {
        let nib = UINib(nibName: "UploadImageView", bundle: nil)
        let nibObjects = nib.instantiate(withOwner: nil, options: nil)
        let customTitleView = nibObjects.first as! UploadImageView
        return customTitleView
    }
}
