//
//  MovieSummaryViewController.swift
//  App
//
//  Created by Daniel de Souza Ribas on 12/05/22.
//

import UIKit

class MovieSummaryViewController: UIViewController {

    @IBOutlet weak var movieSummaryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    private func setupTableView() {
        movieSummaryTableView.delegate = self
        movieSummaryTableView.dataSource = self
        movieSummaryTableView.register(MovieSummaryTableViewCell.getNib(), forCellReuseIdentifier: MovieSummaryTableViewCell.identifier)
    }
}

extension MovieSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieSummaryTableViewCell.identifier, for: indexPath) as! MovieSummaryTableViewCell
        
        cell.label.text = "Linha: \(indexPath)"
        
        return cell
    }
    
}

extension MovieSummaryViewController: UITableViewDelegate {
    
}
