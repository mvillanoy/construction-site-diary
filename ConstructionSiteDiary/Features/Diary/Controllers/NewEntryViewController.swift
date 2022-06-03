//
//  NewEntryViewController.swift
//  ConstructionSiteDiary
//
//  Created by Monica Villanoy on 6/2/22.
//

import UIKit
import MapKit
import CoreLocation


class NewEntryViewController: UIViewController, CommentCardViewDelegate, DataCardViewDelegate, PhotoCardViewDelegate, EventCardViewDelegate, CLLocationManagerDelegate {
    

    let locationManager = CLLocationManager()
    
    var imagePicker = UIImagePickerController()

    
    var newEntryViewModel = NewEntryViewModel()
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    let photoCardView = PhotoCardView.loadNib()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationItem.title = "New"

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(exit))


    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        self.setupHideKeyboardOnTap()
        
        
        photoCardView.delegate = self
        stackView.addArrangedSubview(photoCardView)
        
        let dataCardView = DataCardView.loadNib()
        dataCardView.delegate = self
        stackView.addArrangedSubview(dataCardView)

        let commentCardView = CommentCardView.loadNib()
        commentCardView.delegate = self
        stackView.addArrangedSubview(commentCardView)
        
        let eventCardView = EventCardView.loadNib()
        eventCardView.delegate = self
        stackView.addArrangedSubview(eventCardView)
        
        if let myView = stackView.subviews.first {
            stackView.removeArrangedSubview(myView)
            stackView.setNeedsLayout()
            stackView.layoutIfNeeded()

            stackView.addArrangedSubview(myView)
            stackView.setNeedsLayout()
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submit(_ sender: Any) {
        newEntryViewModel.submit()
    }
    
    @objc func exit() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func commentChanged(value: String) {
        newEntryViewModel.entry.comment = value;
    }
    
    func dateChanged(value: String) {
        newEntryViewModel.entry.date = value;
    }
    
    func taskChanged(value: String) {
        newEntryViewModel.entry.task = value;
    }
    
    func areaChanged(value: String) {
        newEntryViewModel.entry.area = value;
    }
    
    func tagsChanged(value: String) {
        newEntryViewModel.entry.tags = value;
    }
    
    func eventChanged(value: String) {
        newEntryViewModel.entry.event = value;
    }
    
    func openImagePicker(){
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func deleted(view: PhotoCardView) {
    
    }
    
    func added(image: UIImage) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        newEntryViewModel.entry.lat = locValue.latitude
        newEntryViewModel.entry.long = locValue.longitude
        
        
        if let lastLocation = self.locationManager.location {
                let geocoder = CLGeocoder()
                    
                // Look up the location and pass it to the completion handler
                geocoder.reverseGeocodeLocation(lastLocation,
                            completionHandler: { (placemarks, error) in
                    if error == nil {
                        self.locationLabel.text = placemarks?[0].name
                    }
                    else {
                     // An error occurred during geocoding.
                    }
                })
            }
    }
    
    
    
}

extension NewEntryViewController {
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }

    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}

extension NewEntryViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            
            self.photoCardView.addImage(image: image)
            newEntryViewModel.images.append(image)
            dismiss(animated: true, completion: nil)
        }
    }
    
}
