//
//  FAQSViewController.swift
//  Period Angels
//
//  Created by Vijay Rathore on 01/01/23.
//

import UIKit

class FAQSViewController : UIViewController {
    
    
    @IBOutlet weak var giftWellness: UILabel!
    
    
    override func viewDidLoad() {
        giftWellness.isUserInteractionEnabled = true
        giftWellness.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(giftWellnessClicked)))
    }
    
    @objc func giftWellnessClicked(){
        UIApplication.shared.open(URL(string: "https://giftwellness.co.uk/pages/planet-period")!)
    }
}
