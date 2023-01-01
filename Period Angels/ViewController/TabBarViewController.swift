//
//  TabBarViewController.swift
//  Period Angels
//
//  Created by Vijay Rathore on 25/12/22.
//


import UIKit


class TabBarViewController : UITabBarController, UITabBarControllerDelegate {
  
    var tabBarItems = UITabBarItem()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate  = self

        let selectedImage1 = UIImage(named: "question-4")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage1 = UIImage(named: "question")?.withRenderingMode(.alwaysOriginal)
        tabBarItems = self.tabBar.items![0]
        tabBarItems.image = deSelectedImage1
        tabBarItems.selectedImage = selectedImage1
        
        let selectedImage2 = UIImage(named: "location-3")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage2 = UIImage(named: "map")?.withRenderingMode(.alwaysOriginal)
        tabBarItems = self.tabBar.items![1]
        tabBarItems.image = deSelectedImage2
        tabBarItems.selectedImage = selectedImage2
        
        let selectedImage3 = UIImage(named: "home-6")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage3 = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        tabBarItems = self.tabBar.items![2]
        tabBarItems.image = deSelectedImage3
        tabBarItems.selectedImage = selectedImage3
        
        
        let selectedImage4 = UIImage(named: "user-10")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage4 = UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
        tabBarItems = self.tabBar.items![3]
        tabBarItems.image = deSelectedImage4
        tabBarItems.selectedImage = selectedImage4
        
    
        selectedIndex = 1
        
        let selectedColor   = UIColor(red: 203/255.0, green: 131/255.0, blue: 142/255.0, alpha: 1.0)
        let unselectedColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0255.0, alpha: 1)
 

    }

}


