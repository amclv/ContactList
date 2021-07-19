//
//  ContactDetailViewController.swift
//  ContactList
//
//  Created by Aaron Cleveland on 7/19/21.
//

import UIKit

class ContactDetailViewController: UIViewController, UITextFieldDelegate {

    var delegate: ViewControllerDelegate?
    
    lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .lightGray
        tf.placeholder = "NAME"
        tf.heightAnchor.constraint(equalToConstant: 44).isActive = true
        tf.layer.cornerRadius = 5
        return tf
    }()
    
    lazy var phoneNumberTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .lightGray
        tf.placeholder = "PHONE NUMBER"
        tf.heightAnchor.constraint(equalToConstant: 44).isActive = true
        tf.layer.cornerRadius = 5
        return tf
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SAVE CONTACT", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(saveContactTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 32
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        nameTextField.delegate = self
        phoneNumberTextField.delegate = self
        
        constraints()
    }
    
    private func constraints() {
        verticalStack.addArrangedSubview(nameTextField)
        verticalStack.addArrangedSubview(phoneNumberTextField)
        verticalStack.addArrangedSubview(saveButton)
        view.addSubview(verticalStack)
        NSLayoutConstraint.activate([
            verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            verticalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func saveContactTapped() {
        guard let name = nameTextField.text,
              let number = phoneNumberTextField.text else { return }
        
        delegate?.contactCreated(name: name, number: number)
        dismiss(animated: true, completion: nil)
    }
}
