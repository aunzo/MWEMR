import UIKit
import Material

class SuggestionViewController: UIViewController {
    
    
    @IBOutlet weak var otherCommentTextField: TextField!
    @IBOutlet var personalityGroupButton: [UIButton]!
    @IBOutlet var communicationGroupButton: [UIButton]!
    @IBOutlet var attentivenessGroupButton: [UIButton]!
    @IBOutlet var skillGroupButton: [UIButton]!
    @IBOutlet var CleanOfMedGroupButton: [UIButton]!
    @IBOutlet var cleanOfAircarftGroupButton: [UIButton]!
    @IBOutlet var overallGroupButton: [UIButton]!
    
    var personality = SuggestionsResult()
    var communication = SuggestionsResult()
    var attentiveness = SuggestionsResult()
    var skill = SuggestionsResult()
    var CleanOfMed = SuggestionsResult()
    var cleanOfAircarft = SuggestionsResult()
    var overall = SuggestionsResult()
    
    var profile = Customer()
    let vm = caseResultViewModel()
    let username = UserDefaults.standard.object(forKey: "username")

    override func viewDidLoad() {
        super.viewDidLoad()
        profile = CustomerSingleton.sharedInstance.customerProfile
        let vm = caseResultViewModel()
        if vm.loadSuggestion().comment != "" {
          self.otherCommentTextField.text = vm.loadSuggestion().comment
        }
        
        if vm.loadSuggestion().suggestion.count != 0 {
            for suggestion in vm.loadSuggestion().suggestion {
                let sugId = suggestion.id
                let score = suggestion.score
                var button = personalityGroupButton
                if sugId == 203 {
                    button = personalityGroupButton
                    self.personality = suggestion
                }else if sugId == 204 {
                    button = communicationGroupButton
                    self.communication = suggestion
                }else if sugId == 205 {
                    button = attentivenessGroupButton
                    self.attentiveness = suggestion
                }else if sugId == 206 {
                    button = skillGroupButton
                    self.skill = suggestion
                }else if sugId == 207 {
                    button = CleanOfMedGroupButton
                    self.CleanOfMed = suggestion
                }else if sugId == 208 {
                    button = cleanOfAircarftGroupButton
                    self.cleanOfAircarft = suggestion
                }else if sugId == 209 {
                    button = overallGroupButton
                    self.overall = suggestion
                }
                
                for b in button! {
                    if b.tag == score {
                        b.setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
                    }
                }
            }
        }
        
//        self.otherCommentTextField.text = oldSugess.comment
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.saveSuggestionClick(sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SuggestionViewController {
    
    @IBAction func closeView(sender: AnyObject) {
        self.saveSuggestionClick(sender: self)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func personalityClick(sender: AnyObject) {
        for button in personalityGroupButton {
            if button.tag == sender.tag {
                button.setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
                
            }else{
                button.setImage(UIImage(named: "nonfilled"), for: UIControlState.normal)
            }
        }
        
        self.personality.id = 203
        self.personality.score = sender.tag
    }
    @IBAction func communicationClick(sender: AnyObject) {
        for button in communicationGroupButton {
            if button.tag == sender.tag {
                button.setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
            }else{
                button.setImage(UIImage(named: "nonfilled"), for: UIControlState.normal)
            }
        }
        
        self.communication.id = 204
        self.communication.score = sender.tag
    }
    @IBAction func attentivenessClick(sender: AnyObject) {
        for button in attentivenessGroupButton {
            if button.tag == sender.tag {
                button.setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
            }else{
                button.setImage(UIImage(named: "nonfilled"), for: UIControlState.normal)
            }
        }
        
        self.attentiveness.id = 205
        self.attentiveness.score = sender.tag
    }
    @IBAction func skillClick(sender: AnyObject) {
        for button in skillGroupButton {
            if button.tag == sender.tag {
                button.setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
            }else{
                button.setImage(UIImage(named: "nonfilled"), for: UIControlState.normal)
            }
        }
        
        self.skill.id = 206
        self.skill.score = sender.tag
    }
    @IBAction func CleanOfMedClick(sender: AnyObject) {
        for button in CleanOfMedGroupButton {
            if button.tag == sender.tag {
                button.setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
            }else{
                button.setImage(UIImage(named: "nonfilled"), for: UIControlState.normal)
            }
        }
        
        self.CleanOfMed.id = 207
        self.CleanOfMed.score = sender.tag
    }
    @IBAction func cleanOfAircarftClick(sender: AnyObject) {
        for button in cleanOfAircarftGroupButton {
            if button.tag == sender.tag {
                button.setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
            }else{
                button.setImage(UIImage(named: "nonfilled"), for: UIControlState.normal)
            }
        }
        
        self.cleanOfAircarft.id = 208
        self.cleanOfAircarft.score = sender.tag
    }
    @IBAction func overallClick(sender: AnyObject) {
        for button in overallGroupButton {
            if button.tag == sender.tag {
                button.setImage(UIImage(named: "checkmark"), for: UIControlState.normal)
            }else{
                button.setImage(UIImage(named: "nonfilled"), for: UIControlState.normal)
            }
        }
        
        self.overall.id = 209
        self.overall.score = sender.tag
    }
    @IBAction func saveSuggestionClick(sender: AnyObject) {
        var suggestion = [SuggestionsResult]()

        if self.personality.score != 0 { suggestion.append(self.personality) }
        if self.communication.score != 0 { suggestion.append(self.communication) }
        if self.attentiveness.score != 0 { suggestion.append(self.attentiveness) }
        if self.skill.score != 0 { suggestion.append(self.skill) }
        if self.CleanOfMed.score != 0 { suggestion.append(self.CleanOfMed) }
        if self.cleanOfAircarft.score != 0 { suggestion.append(self.cleanOfAircarft) }
        if self.overall.score != 0 { suggestion.append(self.overall) }
        
        let vm = caseResultViewModel()
        vm.saveSuggestion(suggestion: suggestion, comment: self.otherCommentTextField.text!)
        
        
        if sender is UIBarButtonItem || sender is UIButton {
            let alert = UIAlertController(title: "Completed", message: "Thank you for you suggestion", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (alert) in
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    @IBAction func clearSuggestionClick(sender: AnyObject) {
        let alert = UIAlertController(title: "Clear Suggestion", message: "Do You want to clear all suggestion?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: { (alert) in
           
        }))
        
        alert.addAction(UIAlertAction(title: "Clear", style: UIAlertActionStyle.destructive, handler: { (alert) in
            for button in self.personalityGroupButton {
                button.setImage(UIImage(named: "nonfilled"), for: UIControlState.normal)
            }
            
            
            self.personality.score = 0
            for button in self.communicationGroupButton {
                button.setImage(UIImage(named: "nonfilled"), for: UIControlState.normal)
            }
            
            
            self.communication.score = 0
            for button in self.attentivenessGroupButton {
                button.setImage(UIImage(named: "nonfilled"), for: UIControlState.normal)
            }
            
            
            self.attentiveness.score = 0
            for button in self.skillGroupButton {
                button.setImage(UIImage(named: "nonfilled"), for: UIControlState.normal)
            }
            
            
            self.skill.score = 0
            for button in self.CleanOfMedGroupButton {
                button.setImage(UIImage(named: "nonfilled"), for: UIControlState.normal)
            }
            
            
            self.CleanOfMed.score = 0
            for button in self.cleanOfAircarftGroupButton {
                button.setImage(UIImage(named: "nonfilled"), for: UIControlState.normal)
            }
            
            
            self.cleanOfAircarft.score = sender.tag
            for button in self.overallGroupButton {
                button.setImage(UIImage(named: "nonfilled"), for: UIControlState.normal)
            }
            
            
            self.overall.score = 0
            
            let vm = caseResultViewModel()
            vm.clearSuggestion()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
