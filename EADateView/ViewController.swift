//
//  ViewController.swift
//  EADateView
//
//  Created by Ehud Adler on 3/28/18.
//  Copyright © 2018 Ehud Adler. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DateViewDataSource {
  
  var current = Date()
  var counter = 0;

  func DateItem(_ direction: direction) -> (UILabel, Date) {
    
    current = Calendar.current.date(byAdding: .day, value:  counter, to: current)!
    counter += 1
    
    let temp_label                                       = UILabel()
    temp_label.font                                      = UIFont(name: "Helvetica", size: 40)
    temp_label.textColor                                 = UIColor.red
    
    return (temp_label, current)
  }
  
  @IBOutlet var dateView: DateView!
  

  override func viewDidLoad() {
    super.viewDidLoad()
    dateView.dateDelegate = self
    // Do any additional setup after loading the view, typically from a nib.
  }




}

