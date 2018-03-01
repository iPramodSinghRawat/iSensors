//
//  BatteryVC.swift
//  iOSSensors
//
//  Created by AlpineSoftIT on 01/03/18.
//  Copyright © 2018 iPramodSinghRawat. All rights reserved.
//

import UIKit

class BatteryVC: BaseViewController {

    var timer2 = Timer()
    
    @IBOutlet weak var batteryLevelLabel: UILabel!
    @IBOutlet weak var batteryStateLabel: UILabel!

    var batteryLevel: Float {
        return UIDevice.current.batteryLevel
    }
    
    var batteryState: UIDeviceBatteryState {
        return UIDevice.current.batteryState
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        UIDevice.current.isBatteryMonitoringEnabled = true
       
        batteryFunction()
        
        NotificationCenter.default.addObserver(self, selector: #selector(batteryStateDidChange), name: .UIDeviceBatteryStateDidChange, object: nil)
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelDidChange), name: .UIDeviceBatteryLevelDidChange, object: nil)

        timer2 = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.batteryFunction), userInfo: nil, repeats: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func batteryStateDidChange(_ notification: Notification) {
        switch batteryState {
            
        case .unplugged:
            print("not charging")
            self.batteryStateLabel.text = "not charging"
        case .charging, .full:
            print("charging")
            self.batteryStateLabel.text = "charging"
        case .full:
            print("full")
            self.batteryStateLabel.text = "full"
        case .unknown:
            print("not unknown")
            self.batteryStateLabel.text = "not unknown"
            
        }
    }
    
    @objc func batteryLevelDidChange(_ notification: Notification) {
        print(batteryLevel)
        self.batteryLevelLabel.text = "\(batteryLevel * 100)%"
    }
    
    
    @objc func batteryFunction() {
        self.batteryLevelLabel.text = "\(batteryLevel * 100)%"
        self.batteryStateLabel.text = "\(batteryState)"
        print("batteryLevel: \(batteryLevel)")
        print("batteryLevel: \(batteryState)")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
