//
//  ViewController.swift
//  ContactList
//
//  Created by Aaron Cleveland on 7/19/21.
//

import UIKit

struct Contact {
    var name: String
    var number: String
}

protocol ViewControllerDelegate {
    func contactCreated(name: String, number: String)
}

class ViewController: UIViewController, ViewControllerDelegate {
    
    let person1 = Contact(name: "Aaron", number: "7736175037")
    let person2 = Contact(name: "Sarah", number: "1112223333")
    let person3 = Contact(name: "John", number: "4445556666")
    lazy var mockData: [Contact] = [person1, person2, person3]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        constraints()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addContactButtonTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func constraints() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func contactCreated(name: String, number: String) {
        let person = Contact(name: name, number: number)
        mockData.append(person)
        print(mockData)
        tableView.reloadData()
    }
    
    @objc func addContactButtonTapped() {
        let vc = ContactDetailViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        present(vc, animated: true)
    }
}

extension ViewController: UITableViewDelegate {}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as! ContactTableViewCell
        let name = mockData[indexPath.row]
        cell.textLabel?.text = name.name
        cell.detailTextLabel?.text = name.number
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            mockData.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

