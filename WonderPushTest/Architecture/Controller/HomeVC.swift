//
//  HomeVC.swift
//  WonderPushTest
//
//  Created by hitesh on 05/02/20.
//  Copyright © 2020 hitesh. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    static let identifier = "HomeVC"
    @IBOutlet weak var btnCheckBox: DesignableButton!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var pickerGenderSelection: UIPickerView!
    private var genderArray = ["<empty>", "male", "female"]
    private var isPushEnabled = false {
        didSet {
            if isPushEnabled {
                // subscribe to push notifications
                NotificationCenter.default.post(name: NotificationNames.RegisterNotification, object: nil)
                WonderPushHandler.subscribe()
            } else {
                // unsubscribe from push notifications
                WonderPushHandler.unsubscribe()
            }
        }
    }
    
    // MARK:- View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }
    
    private func setUI(){
        
        print("WonderPushHandler.isSubscribed : \(WonderPushHandler.isSubscribed)")
        
        btnCheckBox.setImage(WonderPushHandler.isSubscribed ? .selectionImage : nil, for: .normal)
        lblGender.text = WonderPushHandler.gender
    }

    // MARK:- IBActions
    @IBAction func onTapPushNotification(_ sender: UIButton) {
        if btnCheckBox.currentImage == .selectionImage {
            // notifications are now off
            btnCheckBox.setImage(nil, for: .normal)
            isPushEnabled = false
        } else {
            // notifications are now on
            btnCheckBox.setImage(.selectionImage, for: .normal)
            isPushEnabled = true
        }
    }
    
    @IBAction func onTapSelectGender(_ sender: UIButton) {
        pickerGenderSelection.isHidden = !pickerGenderSelection.isHidden
    }
    
}

extension HomeVC : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblGender.text = genderArray[row]
        WonderPushHandler.setGender(genderArray[row])
    }
}
