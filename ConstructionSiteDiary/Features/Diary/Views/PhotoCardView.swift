//
//  PhotoCardView.swift
//  ConstructionSiteDiary
//
//  Created by Monica Villanoy on 6/3/22.
//



import UIKit
import SimpleCheckbox


protocol PhotoCardViewDelegate{
    func openImagePicker()
    func deleted(view:PhotoCardView)
    func added(image:UIImage)
}

class PhotoCardView: UIView, UploadImageViewDelegate {
    
    
    var delegate:PhotoCardViewDelegate?
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var galleryCheckbox: Checkbox!{
        didSet{
            galleryCheckbox.checkmarkStyle = .cross
        }
    }
    
    @IBAction func addPhotoPressed(_ sender: Any) {
        self.delegate?.openImagePicker()

    }
    
    
    func addImage(image:UIImage){
        let uploadImageView = UploadImageView.loadNib();
        uploadImageView.delegate = self
        uploadImageView.imageView.image = image
        stackView.setNeedsLayout()
        stackView.layoutIfNeeded()
        stackView.addArrangedSubview(uploadImageView)
        stackView.setNeedsLayout()
        
    }
    
    func deleted(deletedSubview: UploadImageView) {
        stackView.setNeedsLayout()
        stackView.layoutIfNeeded()
        stackView.removeArrangedSubview(deletedSubview)
        stackView.setNeedsLayout()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.heightAnchor.constraint(equalToConstant: 297).isActive = true
        self.isUserInteractionEnabled = true;
    }
    
    class func loadNib() -> PhotoCardView {
        let nib = UINib(nibName: "PhotoCardView", bundle: nil)
        let nibObjects = nib.instantiate(withOwner: nil, options: nil)
        let customTitleView = nibObjects.first as! PhotoCardView
        return customTitleView
    }
    
}
