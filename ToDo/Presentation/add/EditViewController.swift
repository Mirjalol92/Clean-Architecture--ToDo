//
//  AddViewController.swift
//  ToDo
//
//  Created by Ali on 2022/11/17.
//

import UIKit

class EditViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate{
    
    @InjetViewModel
    var viewModel: EditViewModel?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextView!
    @IBOutlet weak var doneBtn: UIButton!
    
    var comingData: ToDoData? = nil
    var isDeleting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayouts()
        setNavigation()
    }
    
    func setLayouts(){
        viewModel?.setToDoData(comingData)
        view.backgroundColor = .white
        detailTextField.borderColor = .systemGray4
        detailTextField.borderWidthPreset = .border1
        titleTextField.delegate = self
        detailTextField.delegate = self
    }
    
    func setNavigation(){
        var title = "Adding"
        if comingData != nil {
            title = "Editing"
            doneBtn.setTitle("Delete", for: .normal)
            doneBtn.backgroundColor = .green
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editClicked))
            setData(comingData!)
            viewModel?.updateIsDeleting(value: true)
        }
        navigationItem.title = title
        navigationItem.backButtonTitle?.removeAll()
    }
    
    func setData(_ data: ToDoData){
        titleTextField.isEnabled = false
        detailTextField.isEditable = false
        titleTextField.text = data.title
        detailTextField.text = data.detail
    }
    
    @objc func editClicked(){
        doneBtn.setTitle("Done", for: .normal)
        doneBtn.backgroundColor = .blue
        titleTextField.isEnabled = true
        detailTextField.isEditable = true
        viewModel?.updateIsDeleting(value: false)
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        let title = titleTextField.text ?? ""
        let detail = detailTextField.text ?? ""
        if title.isEmpty || detail.isEmpty{
            let alert = UIAlertController(
                title: "Alert",
                message: "Please fill the all the field",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            viewModel?.manageToDoData(title: title, detail: detail)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField{
            detailTextField.becomeFirstResponder()
        }else{
            detailTextField.resignFirstResponder()
        }
        return false
    }
}
