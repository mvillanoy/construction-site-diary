//
//  EventCardView.swift
//  ConstructionSiteDiary
//
//  Created by Monica Villanoy on 6/3/22.
//

import UIKit
import SimpleCheckbox
import AAPickerView

protocol EventCardViewDelegate{
    func eventChanged(value:String)
}


let eventItems = ["Event1", "Event2", "Event3"]

class EventCardView: UIView {
    var delegate:EventCardViewDelegate?


    @IBOutlet weak var eventTextField: AAPickerView!{
        didSet{
            eventTextField.pickerType = .string(data: eventItems)
            eventTextField.valueDidSelected = { index in
                self.delegate?.eventChanged(value: eventItems[index as! Int])
            }
        }
    }
    
    @IBOutlet weak var eventCheckbox: Checkbox!{
        didSet {
            eventCheckbox.checkmarkStyle = .cross
            eventCheckbox.valueChanged = { (isChecked) in
                self.eventTextField.isHidden = !isChecked
            }
        }
    }

    @IBAction func checkboxToggled(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = true;
    }
    
    class func loadNib() -> EventCardView {
        let nib = UINib(nibName: "EventCardView", bundle: nil)
        let nibObjects = nib.instantiate(withOwner: nil, options: nil)
        let customTitleView = nibObjects.first as! EventCardView
        return customTitleView
    }
}
