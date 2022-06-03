//
//  ViewController.swift
//  ConstructionSiteDiary
//
//  Created by Monica Villanoy on 6/2/22.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addEntryPressed(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Diary", bundle: nil)
        let newEntryVC = mainStoryboard.instantiateViewController(withIdentifier: "NewEntryVC") as! NewEntryViewController
        let navController = UINavigationController(rootViewController: newEntryVC)
        present(navController, animated: true, completion: nil)

    }
    
}

