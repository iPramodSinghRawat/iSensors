//
//  ViewController.swift
//  iOSSensors
//
//  Created by Pramod Singh Rawat on 28/02/18.
//  Copyright © 2018 iPramodSinghRawat. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: BaseViewController{

    var motionManager: CMMotionManager!
    var timer: Timer!
    
    @IBOutlet weak var accelerometerDataLabel: UILabel!
    @IBOutlet weak var gyroDataLabel: UILabel!
    @IBOutlet weak var magnetometerDataLabel: UILabel!
    @IBOutlet weak var deviceMotionDataLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        self.accelerometerDataLabel.numberOfLines = 0
        self.gyroDataLabel.numberOfLines = 0
        self.magnetometerDataLabel.numberOfLines = 0
        self.deviceMotionDataLabel.numberOfLines = 0
        
        self.accelerometerDataLabel.lineBreakMode = .byTruncatingMiddle
        self.gyroDataLabel.lineBreakMode = .byTruncatingMiddle
        self.magnetometerDataLabel.lineBreakMode = .byTruncatingMiddle
        self.deviceMotionDataLabel.lineBreakMode = .byTruncatingMiddle
        
        self.accelerometerDataLabel.adjustsFontSizeToFitWidth = true
        self.gyroDataLabel.adjustsFontSizeToFitWidth = true
        self.magnetometerDataLabel.adjustsFontSizeToFitWidth = true
        self.deviceMotionDataLabel.adjustsFontSizeToFitWidth = true
        
        /*
        var greet4Height = accelerometerDataLabel.optimalHeight
        accelerometerDataLabel.frame = CGRect(x: accelerometerDataLabel.frame.origin.x, y: accelerometerDataLabel.frame.origin.y, width: accelerometerDataLabel.frame.width, height: greet4Height)
        */

        self.motionManager = CMMotionManager()
        
        self.motionManager.startAccelerometerUpdates()
        self.motionManager.startGyroUpdates()
        self.motionManager.startMagnetometerUpdates()
        self.motionManager.startDeviceMotionUpdates()
        
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if self.timer != nil {
            self.timer.invalidate()
            self.timer = nil
        }
        self.motionManager.stopAccelerometerUpdates()
        self.motionManager.stopGyroUpdates()
        self.motionManager.stopMagnetometerUpdates()
        self.motionManager.stopDeviceMotionUpdates()
    }
    
    @objc func update() {
        if let accelerometerData = motionManager.accelerometerData {
            print("\n Accelerometer Data:\n")
            print(accelerometerData)
            
            self.accelerometerDataLabel.text = "\n X: \(accelerometerData.acceleration.x)"
                 + " " + "\n Y: \(accelerometerData.acceleration.y)"
                 + " " + "\n Z: \(accelerometerData.acceleration.z)"
        }
        
        if let gyroData = motionManager.gyroData {
            print("\n Gyro Data:\n")
            print(gyroData)
            
            self.gyroDataLabel.text = "\n X: \(gyroData.rotationRate.x)"
                + " " + "\n Y: \(gyroData.rotationRate.y)"
                + " " + "\n Z: \(gyroData.rotationRate.z)"
            
        }
        
        if let magnetometerData = motionManager.magnetometerData {
            print("\n magnetometer Data:\n")
            print(magnetometerData)
            
            self.magnetometerDataLabel.text = "\n X: \(magnetometerData.magneticField.x)"
                + " " + "\n Y: \(magnetometerData.magneticField.y)"
                + " " + "\n Z: \(magnetometerData.magneticField.z)"
        }
        
        if let deviceMotion = motionManager.deviceMotion {
            print("Device Data:\n")
            print(deviceMotion)
            
            /*
            var rotationRateNUserAcceleration = "\nMagneticField:\n \(deviceMotion.magneticField)"
                + "\n RotationRate:\n \(deviceMotion.rotationRate)"
                + "\n UserAcceleration:\n \(deviceMotion.userAcceleration)" as String
            */
            
            self.deviceMotionDataLabel.text = "Attitude:\n \(deviceMotion.attitude)"
                + " Gravity:\n \(deviceMotion.gravity)"
                + "\n Heading:\n \(deviceMotion.heading)"
                + "\n MagneticField:\n \(deviceMotion.magneticField)"
                + "\n RotationRate:\n \(deviceMotion.rotationRate)"
                + "\n UserAcceleration:\n \(deviceMotion.userAcceleration)" as String
            
            print("Attitude:")
            print(deviceMotion.attitude)
            
            print("Gravity:")
            print(deviceMotion.gravity)
            
            print("Heading:")
            print(deviceMotion.heading)
            
            print("MagneticField:")
            print(deviceMotion.magneticField)
            
            print("RotationRate:")
            print(deviceMotion.rotationRate)
            
            print("UserAcceleration:")
            print(deviceMotion.userAcceleration)
        }
    }
}

extension UILabel {
    var optimalHeight : CGFloat {
        get
        {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.font = self.font
            label.text = self.text
            label.sizeToFit()
            return label.frame.height
        }
        
    }
}

