//
//  DetailViewController.swift
//  WheelyTest
//
//  Created by Anastasia Loginova on 13.04.17.
//  Copyright © 2017 Anastasia Loginova. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var crazyItem: Crazy?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = crazyItem?.title
        titleLabel.text = crazyItem?.title
        textLabel.text = crazyItem?.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
