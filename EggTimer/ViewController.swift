
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = [
        "Soft": 10,
        "Medium":5,
        "Hard":7
    ]
    var secondsPassed = 0
    var totalSeconds = 0
    
    var timer = Timer()
    var player: AVAudioPlayer! //playing the alarm sound when the timer is done
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func keyPressed(
        _ sender: UIButton
    ) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalSeconds = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(
                updateTimer
            ),
            userInfo: nil,
            repeats: true
        )
    }
    func playAlarm() {
        
        let url = Bundle.main.url(
            forResource: "alarm_sound",
            withExtension: "mp3"
        )
        player = try! AVAudioPlayer(
            contentsOf: url!
        )
        player.play()
    }
    
    @objc func updateTimer(){
        
        if secondsPassed < totalSeconds{
            let progres = Double(
                secondsPassed
            )/Double(
                totalSeconds
            )
            progressBar.progress = Float(
                progres
            )
            
            print(
                progres
            )
            
            print(
                "\(secondsPassed) seconds"
            )
            secondsPassed += 1
        }
        else{
            timer.invalidate()
            titleLabel.text = "Done!"
            progressBar.progress = 1.0
            playAlarm()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
