//
//  ViewController.swift
//  rps
//
//  Created by IŞIL VARDARLI on 8.07.2023.
//

import UIKit

class ViewController: UIViewController {
    var playerScore: Int = 0
    var computerScore: Int = 0

    @IBAction func btnDelete(_ sender: Any) {
        playerScore = 0
         computerScore = 0
         lblMyScore.text = "My Score: 0"
         lblPcScore.text = "Computer Score: 0"}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(updateScores), name: NSNotification.Name("UpdateScoresNotification"), object: nil)
        updateScores()
        lblMyScore.text = "My Score: \(playerScore)"
        lblPcScore.text = "Computer Score: \(computerScore)"
    }
    @objc func updateScores() {
        lblMyScore.text = "My Score: \(playerScore)"
        lblPcScore.text = "Computer Score: \(computerScore)"
    }
    @IBOutlet weak var lblPcScore: UILabel!
    @IBOutlet weak var lblMyScore: UILabel!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "rtonext"{
            let gidilecekVC = segue.destination as! ViewController2
            gidilecekVC.myChoise = "1"
                
            }
            else if segue.identifier == "ptonext"{
                let gidilecekVC = segue.destination as! ViewController2
                gidilecekVC.myChoise = "2"
                
            }
            else if segue.identifier == "stonext"{
                let gidilecekVC = segue.destination as! ViewController2
                gidilecekVC.myChoise = "3"
                
            }
         else if segue.identifier == "vctovc2" {
            let gidilecekVC = segue.destination as! ViewController2
             
            gidilecekVC.myChoise = nil
            gidilecekVC.computerScore = computerScore
            gidilecekVC.playerScore = playerScore
            
        }
        
    }
    
}

