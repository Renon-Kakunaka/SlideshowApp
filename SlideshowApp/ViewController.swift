//
//  ViewController.swift
//  SlideshowApp
//
//  Created by Kakunaka Renon on 2021/06/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var season: UIImageView! //スライドショー
    @IBOutlet weak var changeButton: UIButton! //再生/停止
    @IBOutlet weak var goButton: UIButton! //進む
    @IBOutlet weak var backButton: UIButton! //戻る
   
    
    
    var timer: Timer!
    var timer_sec: Float = 0
       
    let imagename: [UIImage] = [
           UIImage(named: "spring.jpg")!,
           UIImage(named: "summer.jpg")!,
           UIImage(named: "autumn.jpg")!,
           UIImage(named: "winter.jpg")!
           
       ]
       var changeimgno: Int = 0
      
       override func viewDidLoad() {
           super.viewDidLoad()
        let imageview  = imagename[0]
        season.image = imageview
       }

       @objc func updateTimer(_ timer: Timer){
           self.timer_sec += 2.0
       }

    //進むボタン
    @IBAction func go(_ sender: Any) {
        if changeimgno == 0 {
            changeimgno = 1
     } else if changeimgno == 1 {
               changeimgno = 2
    } else if changeimgno == 2 {
               changeimgno = 3
    } else if changeimgno == 3 {
               changeimgno = 0
    }
       season.image = imagename[changeimgno]
    
  }
           
    //戻るボタン
    @IBAction func back(_ sender: Any) {
        if changeimgno == 3 {
            changeimgno = 2
    } else if changeimgno == 2 {
               changeimgno = 1
   } else if changeimgno == 1 {
               changeimgno = 0
   } else if changeimgno == 0 {
               changeimgno = 3
   }
       season.image = imagename[changeimgno]
        
 }
    
    //再生/停止ボタン
    @IBAction func playstop(_ sender: Any) {
        if self.timer == nil {
           self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changename), userInfo: nil, repeats: true) //再生
                   changeButton.setTitle("停止", for: .normal)
    goButton.isEnabled = false //進むボタンタップ不可
    backButton.isEnabled = false //戻るボタンタップ不可
                   
    } else {
        self.timer.invalidate() //停止
        self.timer = nil
                   changeButton.setTitle("再生", for: .normal)
    goButton.isEnabled = true //進むボタンタップ可能
    backButton.isEnabled = true //戻るボタンタップ可能
    }
        
  }
    
    @objc func changename() {
        changeimgno += 1 //次の画像をスライドショー
        if (changeimgno == imagename.count){
            changeimgno = 0
               } //最後まで行ったら最初の画像に
               season.image = imagename[changeimgno]

    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let resultViewController:ResultViewController = segue.destination as! ResultViewController
            
          resultViewController.show = season.image!
            self.timer_sec = 0
            
        if self.timer != nil {
           self.timer.invalidate()
           self.timer = nil
                changeButton.setTitle("再生", for: .normal)
     goButton.isEnabled = true //進むボタンタップ可能
     backButton.isEnabled = true //戻るボタンタップ可能
     }
  }

        @IBAction func unwind(_ segue: UIStoryboardSegue) {
  }
}
