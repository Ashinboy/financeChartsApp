//
//  itemViewController.swift
//  financeChartsApp
//
//  Created by Ashin Wang on 2022/6/9.
//

import UIKit


class itemViewController: UIViewController {

    @IBOutlet weak var itemBtnOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        itemBtnOutlet.layer.cornerRadius = 5
    }
    
    @IBAction func itemBtn(_ sender: UIButton) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
