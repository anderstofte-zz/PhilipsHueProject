//
//  PushLinkVC.swift
//  PhilipsHueProject
//
//  Created by ISSD on 01/06/2018.
//  Copyright © 2018 dk.anderstofte. All rights reserved.
//

import UIKit

class PushLinkVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        countDownUntilTimeout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var progressView: UIProgressView!
    
    func countDownUntilTimeout() {
        let timeout: Float = 30
        
        var timeLeft = timeout
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            
            timeLeft -= 1
            let progress = timeLeft / timeout
            self.progressView.progress = progress
            
            if timeLeft == 0 {
                self.timeOutAlert()
                timer.invalidate()
            }
        }
    }
    
    func timeOutAlert() {
        
        let alertController = UIAlertController(title: "Timeout", message: "The button on the bridge was not pressed.", preferredStyle: .alert)
        
        let retryAction  = UIAlertAction(title: "Retry", style: .default) { (action) in
            
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
            
        }
        
        alertController.addAction(retryAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

}
