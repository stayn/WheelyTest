//
//  CrazyDataTableViewController.swift
//  WheelyTest
//
//  Created by Anastasia Loginova on 12.04.17.
//  Copyright © 2017 Anastasia Loginova. All rights reserved.
//

import UIKit

class CrazyDataTableViewController: UITableViewController {
    public var crazyData = [Crazy]() {
        didSet {
            DispatchQueue.main.async{
                UIView.transition(with: self.tableView,
                                          duration: 0.35,
                                          options: .transitionCrossDissolve,
                                          animations:
                    { () -> Void in
                        self.tableView.reloadData()
                },
                                          completion: nil);
            }
        }
    }
    
    var refreshTimer: Timer?
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    override func viewDidLoad() {
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.center = view.center;
        
        super.viewDidLoad()
        
        fetchData { (crazyData) -> () in
            self.crazyData = crazyData
        }
        
        // Self-sizing table cells
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = CGFloat(Constants.estimatedRowHeight)
        
        view.addSubview(activityIndicator)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        refreshTimer?.invalidate()
        refreshTimer = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // Autorefreshing in 15 seconds
        runAutoTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crazyData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! CrazyDataTableViewCell
        
        let item = crazyData[indexPath.row]
        
        cell.crazyItem = item

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueIdentifier
        {
            guard let detailVC = segue.destination as? DetailViewController else {
                fatalError("\(Constants.segueFatalError)\(segue.destination)")
            }
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let crazyItemToBeDetailed = crazyData[indexPath.row]
                detailVC.crazyItem = crazyItemToBeDetailed
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func refreshButtonWasPressed(_ sender: UIBarButtonItem) {
        refreshData()
        sender.isEnabled = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            sender.isEnabled = true
        }
    }
    
    
    // MARK: - Private Functions
    
    private func runAutoTimer() {
        refreshTimer = Timer.scheduledTimer(timeInterval: Constants.refreshTimeInterval,
                                            target: self,
                                            selector: #selector(refreshData),
                                            userInfo: nil,
                                            repeats: true)
    }
    
    @objc private func refreshData() {
        // Spinner shoud spin when refreshing data
        activityIndicator.startAnimating()
        refreshTimer?.invalidate()
        crazyData.removeAll()
        fetchData { (crazyData) -> () in
            self.crazyData = crazyData
        }
        // Runs timer again for auto-refreshing
        runAutoTimer()
    }
}

//MARK: - Data Fetching

private extension CrazyDataTableViewController {
    func fetchData(completionHandler: @escaping (_ crazyData: [Crazy]) -> ()) {
        var crazyData = [Crazy]()
        let requestURL = URLRequest(url: URL(string: Constants.url)!)
        let task = URLSession.shared.dataTask(with: requestURL) { (data, _, _) in
            defer {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
            }
            if let data = data,
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as! [[String: AnyObject]] {
                for json in jsonData {
                    let crazyItem = Crazy(json: json)
                    crazyData.append(crazyItem!)
                }
                completionHandler(crazyData)
            }
        }
        task.resume()
    }
}
