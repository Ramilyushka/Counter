//
//  ViewController.swift
//  Counter
//
//  Created by Наиль on 17/03/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var historyTextView: UITextView!
    
    @IBOutlet weak var increaseCounterButton: UIButton!
    @IBOutlet weak var decreaseCounterButton: UIButton!
    @IBOutlet weak var resetCounterButton: UIButton!
    
    private var counter: Int = 0 //значение счетчика
    
    private enum CounterChange //для фиксации действия со счетчиком для отображения истории изменений
    {
        case increase
        case discrease
        case error
        case reset
    }
    
    private func historyChange (_ change: CounterChange) //добавляем текст в историю
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY HH:mm:ss"

        let date = dateFormatter.string(from: Date())
        
        switch change {
        case .increase:
            historyTextView.text += "\(date): значение изменено на +1\n"
        case .discrease:
            historyTextView.text += "\(date): значение изменено на -1\n"
        case .error:
            historyTextView.text += "\(date): попытка уменьшить значение счётчика ниже 0\n"
        case .reset:
            historyTextView.text += "\(date) значение сброшено\n"
//        default:
//            historyLabel.text += "\(date) неизвестная ошибка"
        }
        
    }
    
    private var counterChange = CounterChange.reset
    
    @IBAction func increaseCounterButtonClick(_ sender: Any) {
        counter += 1
        
        counterChange = CounterChange.increase
        updateCounterLabelAndHistory()
    }
    
    @IBAction func decreaseCounterButtonClick(_ sender: Any) {
        counter -= 1
        counterChange = CounterChange.discrease
        if counter < 0 {
            counter = 0
            counterChange = CounterChange.error
        }
        updateCounterLabelAndHistory()
    }
    
    @IBAction func resetCounterButtonClick(_ sender: Any) {
        counter = 0
        counterChange = CounterChange.reset
        updateCounterLabelAndHistory()
    }
    
    private func updateCounterLabelAndHistory () {
        counterLabel.text = "\(counter)" //в задании неоднозначно описан текст лейбла, то ли просто число то ли "Значение счетчика:[число]"
        
        historyChange(counterChange)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateCounterLabelAndHistory()
        
        historyTextView.showsVerticalScrollIndicator = true
        historyTextView.text = "История изменений:\n"
        
        // Do any additional setup after loading the view.
    }
}
