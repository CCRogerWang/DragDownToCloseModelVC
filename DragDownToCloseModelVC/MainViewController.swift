//
//  MainViewController.swift
//  DragDownToCloseModelVC
//
//  Created by roger on 2017/10/13.
//  Copyright © 2017年 roger. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func goButtonPressed(_ sender: Any) {
        let vc = ModelViewController()
        vc.interactor = Interactor()
        self.present(vc, animated: true, completion: nil)
    }

}



