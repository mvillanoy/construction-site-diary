//
//  DataCardView.swift
//  ConstructionSiteDiary
//
//  Created by Monica Villanoy on 6/3/22.
//

import UIKit
import AAPickerView

protocol DataCardViewDelegate{
    func dateChanged(value:String)
    func taskChanged(value:String)
    func areaChanged(value:String)
    func tagsChanged(value:String)
}


let areaItems = ["Front", "Inside", "Back"]
let taskItems = ["Construction", "Interior", "Landscaping"]


class DataCardView: UIView, UITextViewDelegate, UITextFieldDelegate {
    
    var delegate:DataCardViewDelegate?

    @IBOutlet weak var datePicker: AAPickerView!{
        didSet{
            datePicker.pickerType = .date
            datePicker.valueDidSelected = { date in
                self.delegate?.dateChanged(value: "\(date)")
            }
        }
    }
    
    @IBOutlet weak var areaPicker: AAPickerView!{
        didSet{
            areaPicker.pickerType = .string(data: areaItems)
            areaPicker.valueDidSelected = { index in
                self.delegate?.areaChanged(value: areaItems[index as! Int])
            }
        }
    }
    
    @IBOutlet weak var taskPicker: AAPickerView!{
        didSet{
            taskPicker.pickerType = .string(data: taskItems)
            taskPicker.valueDidSelected = { index in
                self.delegate?.taskChanged(value: taskItems[index as! Int])
            }
        }
    }
    
    @IBOutlet weak var tagsTextField: UITextField!{
        didSet{
            tagsTextField.delegate = self
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.delegate?.tagsChanged(value: textView.text)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.heightAnchor.constraint(equalToConstant: 281).isActive = true
        self.isUserInteractionEnabled = true;
    }
    
    class func loadNib() -> DataCardView {
        let nib = UINib(nibName: "DataCardView", bundle: nil)
        let nibObjects = nib.instantiate(withOwner: nil, options: nil)
        let customTitleView = nibObjects.first as! DataCardView
        return customTitleView
    }
}
