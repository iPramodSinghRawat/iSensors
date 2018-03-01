//
//  MotionActivityVC.swift
//  iOSSensors
//
//  Created by Pramod Singh Rawat on 01/03/18.
//  Copyright © 2018 iPramodSinghRawat. All rights reserved.
//

import UIKit
import CoreMotion

class MotionActivityVC: BaseViewController{

    let activityManager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()
    
    @IBOutlet weak var activityStateLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()

        // Do any additional setup after loading the view.
        
        var cal = NSCalendar.current
        var comps = cal.dateComponents([.year, .month, .day, .hour, .minute, .second ], from: NSDate() as Date)
        
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        let timeZone = NSTimeZone.system
        cal.timeZone = timeZone
        
        let midnightOfToday = cal.date(from: comps)!
        
        if(CMMotionActivityManager.isActivityAvailable()){
            self.activityManager.startActivityUpdates(to: OperationQueue.main, withHandler: { (data: CMMotionActivity!) -> Void in
                
                DispatchQueue.main.async{
                    
                    if(data.stationary == true){
                        print("Stationary")
                        self.activityStateLabel.text = "Stationary"
                    } else if (data.walking == true){
                        print("walking")
                        self.activityStateLabel.text = "Walking"
                    } else if (data.running == true){
                        print("Running")
                        self.activityStateLabel.text = "Running"
                    } else if (data.automotive == true){
                        print("Automotive")
                        self.activityStateLabel.text = "Automotive"
                    }
                }
            })
        }
        
        if(CMPedometer.isStepCountingAvailable()){
            let fromDate = NSDate(timeIntervalSinceNow: -86400 * 7)
            self.pedoMeter.queryPedometerData(from: fromDate as Date, to: NSDate() as Date) { (data : CMPedometerData!, error) -> Void in
                
                print(data)
                
                DispatchQueue.main.async{
                    if(error == nil){
                        print("queryPedometerData numberOfSteps \(data.numberOfSteps)")
                        self.stepsLabel.text = "\(data.numberOfSteps)"
                    }
                }
            }
            
            self.pedoMeter.startUpdates(from: midnightOfToday) { (data: CMPedometerData!, error) -> Void in
                
                DispatchQueue.main.async{
                    if(error == nil){
                        print("startUpdates numberOfSteps \(data.numberOfSteps)")
                        self.stepsLabel.text = "\(data.numberOfSteps)"
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.activityManager.stopActivityUpdates()
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
