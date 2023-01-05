//
//  Organisation_View_Cell.swift
//  Period Angels
//
//  Created by Vijay Rathore on 03/01/23.
//

import UIKit

class Organisation_View_Cell : UITableViewCell {
    
    @IBOutlet weak var mView: UIView!
    @IBOutlet weak var distance: UILabel!
    
    @IBOutlet weak var organisationName: UILabel!
    
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var businessView: UIView!
    @IBOutlet weak var businessType: UILabel!
    @IBOutlet weak var businessImg: UIImageView!
    
    @IBOutlet weak var padsView: UIView!
    
    @IBOutlet weak var tampomsView: UIView!
    @IBOutlet weak var cupView: UIView!
    @IBOutlet weak var plasticFreeView: UIView!
    
    @IBOutlet weak var reusableView: UIView!
    
    override class func awakeFromNib() {
        
    }
    
}
