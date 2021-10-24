//
//  ViewController.swift
//  CombineApp
//
//  Created by Darinka on 24.10.2021.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var array: [WPPost] = []
    var subscriptions: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        NetworkService()
            .getData()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(_): print("Error")
                }
            } receiveValue: { posts in
                self.array = posts
                self.tableView.reloadData()
            }
            .store(in: &subscriptions)  //& otvechaet za adress v pamati
        
    }
    
    


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .gray
        
        return cell
    }
    
    
    
}
