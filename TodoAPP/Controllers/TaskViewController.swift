//
//  TaskViewController.swift
//  TodoAPP
//
//  Created by Martin Nasierowski on 03/06/2020.
//  Copyright © 2020 Martin Nasierowski. All rights reserved.
//

import RealmSwift
import UIKit

final class TaskViewController: UIViewController {
    
    weak var delegate: TodosViewController?
    
    // MARK: - Variables
    fileprivate let realm = try! Realm()
        
    fileprivate lazy var nameTextField: UITextField! = {
        let nameTextField = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: nameTextField.frame.height))
        nameTextField.leftView = paddingView
        nameTextField.rightView = paddingView
        nameTextField.leftViewMode = UITextField.ViewMode.always
        nameTextField.rightViewMode = UITextField.ViewMode.always
        nameTextField.layer.cornerRadius = 10
        nameTextField.layer.borderColor = UIColor.lightGray.cgColor
        nameTextField.layer.borderWidth = 0.5
        return nameTextField
    }()
    
    fileprivate var nameLabel: UILabel! = {
        let label = UILabel()
        label.text = "Name"
        return label
    }()
    
    fileprivate var datePicker: UIDatePicker! = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.addTarget(self, action: #selector(TaskViewController.dateChanged(datePicker:)), for: .valueChanged)
        return dp
    }()
    
    fileprivate lazy var dateTextField: UITextField! = {
        let dateTextField = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: dateTextField.frame.height))
        dateTextField.leftView = paddingView
        dateTextField.rightView = paddingView
        dateTextField.leftViewMode = UITextField.ViewMode.always
        dateTextField.rightViewMode = UITextField.ViewMode.always
        dateTextField.layer.cornerRadius = 10
        dateTextField.layer.borderColor = UIColor.lightGray.cgColor
        dateTextField.layer.borderWidth = 0.5
        dateTextField.inputView = datePicker
        return dateTextField
    }()
    
    fileprivate var dateLabel: UILabel! = {
       let label = UILabel()
       label.text = "Date"
       return label
    }()
    
    fileprivate var categoryPicker: UIPickerView! = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    fileprivate lazy var categoryTextField: UITextField! = {
        let categoryTextField = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: categoryTextField.frame.height))
        categoryTextField.leftView = paddingView
        categoryTextField.rightView = paddingView
        categoryTextField.leftViewMode = UITextField.ViewMode.always
        categoryTextField.rightViewMode = UITextField.ViewMode.always
        categoryTextField.layer.cornerRadius = 10
        categoryTextField.layer.borderColor = UIColor.lightGray.cgColor
        categoryTextField.layer.borderWidth = 0.5
        categoryTextField.inputView = categoryPicker
        return categoryTextField
    }()
    
    fileprivate var categoryLabel: UILabel! = {
          let label = UILabel()
          label.text = "Category"
          return label
    }()
    
    // MARK: - Init
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigation()
        configureUI()
        configureTapGesture()
        configureCategoryPicker()
        
        print(Category.allCases)
    }
    
    // MARK: - UI
    
    fileprivate func configureNavigation() {
        title = "Add task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addTask))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem?.tintColor = .white

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor =  .systemBlue
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    fileprivate func configureUI() {
        view.addSubview(nameTextField)
        view.addSubview(nameLabel)
        view.addSubview(dateTextField)
        view.addSubview(dateLabel)
        view.addSubview(categoryTextField)
        view.addSubview(categoryLabel)
        
        nameTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor , bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: view.frame.size.height * 0.1, paddingBottom: 0, paddingLeft: 50, paddingRight: 50, width: 0, height: 35)
        
        nameLabel.anchor(top: nil, bottom: nameTextField.topAnchor, left: nameTextField.leftAnchor, right: nil, paddingTop: 0, paddingBottom: 5, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        dateLabel.anchor(top: nameTextField.bottomAnchor, bottom: nil, left: nameTextField.leftAnchor, right: nameTextField.rightAnchor, paddingTop: 20, paddingBottom: 5, paddingLeft: 0, paddingRight: 0, width: 0, height: 35)
        
        dateTextField.anchor(top: dateLabel.bottomAnchor, bottom: nil, left: nameTextField.leftAnchor, right: dateLabel.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 35)
        
        categoryLabel.anchor(top: dateTextField.bottomAnchor, bottom: nil, left: nameTextField.leftAnchor, right: nil, paddingTop: 20, paddingBottom: 5, paddingLeft: 0, paddingRight: 0, width: 0, height: 35)
        
        categoryTextField.anchor(top: categoryLabel.bottomAnchor, bottom: nil, left: nameTextField.leftAnchor, right: dateTextField.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 35)
    }
    
    // MARK: - Methods
    
    fileprivate func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TaskViewController.viewTapp(gestureRecoginzer:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    fileprivate func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
   }
    
    @objc fileprivate func viewTapp(gestureRecoginzer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc fileprivate func dateChanged(datePicker: UIDatePicker) {
        dateTextField.text = datePicker.date.toMediumString()
    }
    
    fileprivate func checkAndDisplayError(textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        if text.count <= 0 {
           textField.attributedPlaceholder = NSAttributedString(string: "Please fill this field", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
           return false
        }
        return true
    }
    
    @objc fileprivate func addTask() {
        guard checkAndDisplayError(textField: nameTextField) else { return }
        guard checkAndDisplayError(textField: dateTextField) else { return }
        guard checkAndDisplayError(textField: categoryTextField) else { return }

        let task = Task()
        
        if let date =  dateTextField.text?.fromMediumDateStringToDate() {
            task.date = date
        } else {
            dateTextField.text = ""
            dateTextField.attributedPlaceholder = NSAttributedString(string: "Please fill with correct data", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            return
        }
        
        let categories: [String] = Category.allCases.map { $0.description }
        if categories.contains(categoryTextField.text ?? "") {
            task.category = categoryTextField.text!
        } else {
            categoryTextField.text = ""
            categoryTextField.attributedPlaceholder = NSAttributedString(string: "Please fill with correct data", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            return
        }
        task.name = nameTextField.text!
        
        
        do {
            try realm.write {
                realm.add(task)
            }
        } catch let error as NSError {
            let failureAlert = UIAlertController(title: "Something went wrong", message: "", preferredStyle: .alert)
            failureAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            let retryAction =  UIAlertAction(title: "Retry", style: .default) {
                UIAlertAction in
                self.addTask()
            }
            
            failureAlert.addAction(retryAction)
                
            self.present(failureAlert, animated: true)
            print(error.localizedDescription)
        }
        
        navigationController?.popViewController(animated: true)
        delegate?.showSuccessInfo()

    }
    @objc fileprivate func cancel() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UIPicker
extension TaskViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.allCases.count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       categoryTextField.text = Category(rawValue: row)?.description
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Category(rawValue: row)?.description
   }
    
    fileprivate func configureCategoryPicker() {
        categoryPicker.delegate = self
    }
}
