//
//  ViewController.swift
//  SpliTimer
//
//  Created by Enddle Zheng on 4/16/19.
//  Copyright © 2019 Enddle Zheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainTimerMili: UILabel!
    @IBOutlet weak var mainTimerSec: UILabel!
    @IBOutlet weak var mainTimerMin: UILabel!
    
    @IBOutlet weak var mainTimerBtn: UIButton!
    
    @IBOutlet weak var timer1Btn: UIButton!
    @IBOutlet weak var timer1Min: UILabel!
    @IBOutlet weak var timer1Sec: UILabel!
    
    @IBOutlet weak var timer2Btn: UIButton!
    @IBOutlet weak var timer2Min: UILabel!
    @IBOutlet weak var timer2Sec: UILabel!
    
    @IBOutlet weak var timer3Btn: UIButton!
    @IBOutlet weak var timer3Min: UILabel!
    @IBOutlet weak var timer3Sec: UILabel!
    
    @IBOutlet weak var timer4Btn: UIButton!
    @IBOutlet weak var timer4Min: UILabel!
    @IBOutlet weak var timer4Sec: UILabel!
    
    @IBOutlet weak var timer5Btn: UIButton!
    @IBOutlet weak var timer5Min: UILabel!
    @IBOutlet weak var timer5Sec: UILabel!
    
    var mainTime = 0
    var splitTime:[Int] = [0]
    
    var splitBtn:[UIButton?] = []
    var splitSecLabel:[UILabel?] = []
    var splitMinLabel:[UILabel?] = []
    
    var timer = Timer()
    var mainTimerState = 0
    
    var currentSplit:Int = 0
    
    
    func mainTimerStart() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.action), userInfo: nil, repeats: true)
        mainTimerBtn.setTitle("■", for: .normal)
        mainTimerState = 1
    }
    
    func mainTimerPause() {
        timer.invalidate()
        mainTimerBtn.setTitle("↻", for: .normal)
        mainTimerState = 2
    }
    
    func mainTimerReset() {
        timer.invalidate()
        
        mainTime = 0
        updateMain()
        
        splitTime = [0,0,0,0,0]
        for i in 0..<splitTime.count {
            updateSplit(n: i)
        }
        
        mainTimerBtn.setTitle("▶", for: .normal)
        mainTimerState = 0
    }
    
    @IBAction func mainTimerAction(_ sender: Any) {
        switch mainTimerState {
        case 0:
            mainTimerStart()
            break
        case 1:
            mainTimerPause()
            break
        case 2:
            mainTimerReset()
            break
        default:
            print("ERROR: mainTimerState = \(mainTimerState)")
        }
    }
    
    @objc func action() {
        mainTime += 1
        
        updateMain()
        
        splitTime[currentSplit] += 1
        
        updateSplit(n: currentSplit)
    }
    
    func updateMain() {
        
        let mili = ("00" + String(mainTime)).suffix(2)
        let sec = ("00" + String(mainTime / 100 % 60)).suffix(2)
        let min = ("00" + String(mainTime / 6000)).suffix(2)
        
        mainTimerMili.text = String(mili)
        mainTimerSec.text = String(sec)
        mainTimerMin.text = String(min)
    }
    
    func updateSplit(n: Int) {
        
        let time = splitTime[n]
        
        let sec = ("00" + String(time / 100 % 60)).suffix(2)
        let min = ("00" + String(time / 6000)).suffix(2)
        
        self.splitSecLabel[n]?.text = String(sec)
        self.splitMinLabel[n]?.text = String(min)
    }
    
    @IBAction func switchSplit(sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
        }
        
        currentSplit = button.tag
        
        for i in 0..<splitBtn.count {
            splitBtn[i]?.alpha = 1
        }
        
        button.alpha = 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initSplit()
    }
    
    func initSplit() {
        
        splitTime = [0,0,0,0,0]
        splitSecLabel = [timer1Sec,timer2Sec,timer3Sec,timer4Sec,timer5Sec]
        splitMinLabel = [timer1Min,timer2Min,timer3Min,timer4Min,timer5Min]
        splitBtn = [timer1Btn,timer2Btn,timer3Btn,timer4Btn,timer5Btn]
    }


}

