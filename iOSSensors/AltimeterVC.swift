//
//  AltimeterVC.swift
//  iOSSensors
//
//  Created by AlpineSoftIT on 01/03/18.
//  Copyright © 2018 iPramodSinghRawat. All rights reserved.
//

import UIKit
import CoreMotion

class AltimeterVC: BaseViewController {

    let altimeter = CMAltimeter()
    
    @IBOutlet weak var relativeAltitudeLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        // Do any additional setup after loading the view.

        if CMAltimeter.isRelativeAltitudeAvailable() {
            self.altimeter.startRelativeAltitudeUpdates(to: OperationQueue.current!, withHandler: { data, error in
                if !(error != nil) {
                    print("Relative Altitude: \(data?.relativeAltitude)")
                    print("Relative Pressure: \(data?.pressure)")
                    
                    var relativeAltitudeData = data?.relativeAltitude as! Double
                    var pressureData = data?.pressure as! Double
                    
                    self.relativeAltitudeLabel.text = String(format: "%.6f", relativeAltitudeData)
                    self.pressureLabel.text = String(format: "%.6f", pressureData)
                }else{
                    self.altimeter.stopRelativeAltitudeUpdates() // Stop updates
                    print("Stopped relative altitude updates.")
                    
                    let alertView = UIAlertView(title: "Error", message: error!.localizedDescription, delegate: nil, cancelButtonTitle: "OK")
                    alertView.show()
                }
            })
        }else{
            print("altimeter no available")
            let alertView = UIAlertView(title: "Not Available", message: "Altimeter Not Available", delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.altimeter.stopRelativeAltitudeUpdates()
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
