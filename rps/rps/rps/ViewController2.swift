//
//  ViewController2.swift
//  rps
//
//  Created by IŞIL VARDARLI on 8.07.2023.
//

import UIKit

class ViewController2: UIViewController {
    
    var myChoise:String?
    var playerScore:Int=0
    var computerScore:Int=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*if let savedPlayerMove = UserDefaults.standard.string(forKey: "PlayerMove") {
                    
            lblMyMove.text = savedPlayerMove
                }
        if let savedComputerMove = UserDefaults.standard.string(forKey: "ComputerMove") {
                    
            lblPcMove.text = savedComputerMove
                }*/
        if myChoise != nil{
            playGame()
        }

    }

    @IBOutlet weak var lblMyMove: UILabel!
    
    @IBOutlet weak var lblPcMove: UILabel!
    
    @IBOutlet weak var lblResult: UILabel!
    
    enum Sign: Int {
        case rock = 1, paper, scissors
        
        var description: String {
            switch self {
            case .rock:
                return "Taş"
            case .paper:
                return "Kağıt"
            case .scissors:
                return "Makas"
            }
        }
        
        func beats(_ opponent: Sign) -> Bool {
            return (self == .rock && opponent == .scissors) ||
                   (self == .paper && opponent == .rock) ||
                   (self == .scissors && opponent == .paper)
        }
    }

    func getPlayerInput() -> Sign? {
       guard let input = myChoise, let choice = Int(input), let sign = Sign(rawValue: choice) else {
            return nil
        }
        return sign
    }

    func getComputerSign() -> Sign {
        let randomChoice = Int.random(in: 1...3)
        return Sign(rawValue: randomChoice)!
    }

    func playGame() {

        if let playerChoice = getPlayerInput() {
            let computerChoice = getComputerSign()
            
            lblMyMove.text=playerChoice.description
            lblPcMove.text=computerChoice.description
            if playerChoice == computerChoice {
                lblResult.text = "Berabere! Tekrar deneyin."
            } else if playerChoice.beats(computerChoice) {
                lblResult.text = "Tebrikler, kazandınız!"
                playerScore+=1
            } else {
                lblResult.text = "Üzgünüm, kaybettiniz."
                computerScore+=1
                
            }
            NotificationCenter.default.post(name: NSNotification.Name("UpdateScoresNotification"), object: nil)
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newResults" {
            let destinationVC = segue.destination as! ViewController
            destinationVC.playerScore += playerScore
            destinationVC.computerScore += computerScore
        }
    }
    /*override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            // UserDefaults'a  kaydet
            UserDefaults.standard.set(lblMyMove.text, forKey: "PlayerMove")
            UserDefaults.standard.set(lblPcMove.text, forKey: "ComputerMove")
        }*/
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            UserDefaults.standard.set(playerScore, forKey: "PlayerScore")
            UserDefaults.standard.set(computerScore, forKey: "ComputerScore")
        }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            if let savedPlayerScore = UserDefaults.standard.value(forKey: "PlayerScore") as? Int {
                playerScore = savedPlayerScore
            }
            
            if let savedComputerScore = UserDefaults.standard.value(forKey: "ComputerScore") as? Int {
                computerScore = savedComputerScore
            }
            
        }
    
}
