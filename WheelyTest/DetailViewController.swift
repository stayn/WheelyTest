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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Private
    

}
