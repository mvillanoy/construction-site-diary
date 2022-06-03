//
//  CommentCardView.swift
//  ConstructionSiteDiary
//
//  Created by Monica Villanoy on 6/3/22.
//

import UIKit

protocol CommentCardViewDelegate{
    func commentChanged(value:String)
}


class CommentCardView: UIView, UITextViewDelegate {
    var delegate:CommentCardViewDelegate?
    
    @IBOutlet weak var commentTextView: UITextView!{
        didSet {
            commentTextView.delegate = self
            commentTextView.backgroundColor = .white
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.delegate?.commentChanged(value: textView.text)
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.heightAnchor.constraint(equalToConstant: 114).isActive = true
        self.isUserInteractionEnabled = true;
    }
    
    class func loadNib() -> CommentCardView {
        let nib = UINib(nibName: "CommentCardView", bundle: nil)
        let nibObjects = nib.instantiate(withOwner: nil, options: nil)
        let customTitleView = nibObjects.first as! CommentCardView
        return customTitleView
    }
}
