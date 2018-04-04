//
//  DateView.swift
//  EADateView
//
//  Created by Ehud Adler on 3/28/18.
//  Copyright © 2018 Ehud Adler. All rights reserved.
//

import UIKit


public protocol DateViewDataSource: class
{
  func DateItem(_ direction: direction) -> (UILabel, Date)
}

class DateView: UIView, InfiniteScrollViewDataSource
{
  
  // Delegate
  public var dateDelegate  : DateViewDataSource?
  
  // final private let
  final private let SPACE_BETWEEN_MONTH_AND_MAIN: CGFloat = 1.0
  final private let infiniteSV = InfiniteScrollView()
  
  // private
  var currentMonth: Int = 0;
  
  var monthFont: UIFont {
    get { return month.font }
    set { month.font = newValue }
  }
  
  // month label
  let month: UILabel = {
    let temp_label                                       = UILabel()
    temp_label.font                                      = UIFont(name: "Helvetica", size: 20)
    temp_label.textColor                                 = UIColor.red
    temp_label.textAlignment                             = .center
    temp_label.text                                      = ""
    temp_label.adjustsFontSizeToFitWidth                 = true
    temp_label.translatesAutoresizingMaskIntoConstraints = false
    return temp_label
  }()
  
  let mainView: UIView = {
    let view                                       = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  // code
  override init(frame: CGRect)
  {
    super.init(frame: frame)
    commonInit()
  }
  
  private func commonInit()
  {
    
    
    /***** DEBUG *****/
    infiniteSV.backgroundColor = .yellow
    mainView.backgroundColor = UIColor.groupTableViewBackground
    /***** DEBUG *****/
    
    self.addSubview(mainView)
    self.addSubview(infiniteSV)
    self.addSubview(month)
    
    setUpMainView()
    setUpConstraints()
    
    infiniteSV.infiniteDelegate = self
    infiniteSV.showsHorizontalScrollIndicator = false
    infiniteSV.showsVerticalScrollIndicator   = false
    
  }
  
  private func setUpConstraints()
  {
    
    infiniteSV.translatesAutoresizingMaskIntoConstraints = false
    infiniteSV.topAnchor.constraint(equalTo: self.topAnchor).isActive       = true
    infiniteSV.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    infiniteSV.rightAnchor.constraint(equalTo: self.rightAnchor).isActive   = true
    infiniteSV.leftAnchor.constraint(equalTo: self.leftAnchor).isActive     = true
    
    month.bottomAnchor.constraint(equalTo: mainView.topAnchor, constant: -5).isActive = true
    month.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    month.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    
    mainView.widthAnchor.constraint(equalToConstant: self.frame.width/3).isActive = true
    mainView.heightAnchor.constraint(equalToConstant: self.frame.width/3).isActive = true
    mainView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
    mainView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    
  }
  
  private func setUpMainView()
  {
    self.mainView.layer.cornerRadius = 8
    self.mainView.layer.borderColor  = UIColor.black.cgColor
    self.mainView.layer.borderWidth  = 2
  }
  
  
  func changeMonth(to: String)
  {
    month.text = to;
  }
  
  func infiniteItem(_ lastView: UIView?, _ direction: direction) -> UIView {

    /*** <<<<<<THIS MUST BE REFACTORED>>>>>>> ***/
    
    let returnView = UIView() /* View to be returned */
    
    let temp_label = dateDelegate?.DateItem(direction).0
    let temp_date = dateDelegate?.DateItem(direction).1
    

    
    if let temp_label = temp_label, let temp_date = temp_date {
      
      let dateInfo = temp_date.getDayMonthYear()
      
      if dateInfo.1 != currentMonth {
        changeMonth(to: "\(currentMonth)")
      }
      
      temp_label.textAlignment                             = .center
      temp_label.adjustsFontSizeToFitWidth                 = true
      temp_label.translatesAutoresizingMaskIntoConstraints = false
      temp_label.backgroundColor = .clear
      
      temp_label.text = "\(dateInfo.0)"
      
      returnView.addSubview(temp_label)
      
      temp_label.topAnchor.constraint(equalTo: returnView.topAnchor).isActive       = true
      temp_label.bottomAnchor.constraint(equalTo: returnView.bottomAnchor).isActive = true
      temp_label.rightAnchor.constraint(equalTo: returnView.rightAnchor).isActive   = true
      temp_label.leftAnchor.constraint(equalTo: returnView.leftAnchor).isActive     = true
      
    }
    
    return returnView
  }
  
}

extension Date {
  func getDayMonthYear() -> (Int, Int, Int)
  {
    let calendar = Calendar.current
    let year = calendar.component(.year, from: self)
    let month = calendar.component(.month, from: self)
    let day = calendar.component(.day, from: self)
    return (day, month, year)
  }
}
