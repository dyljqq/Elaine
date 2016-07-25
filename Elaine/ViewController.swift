//
//  ViewController.swift
//  Elaine
//
//  Created by 季勤强 on 16/7/25.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Elaine.request(.GET, "https://httpbin.org/get", params: ["foo": "bar"]).delegate.taskDidCompleteWithError = { session, task, error in
            print(session)
            print(task)
            print(error)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

