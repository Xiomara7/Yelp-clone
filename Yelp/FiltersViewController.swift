//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Xiomara on 10/26/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
    @objc optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String:AnyObject])
}

class FiltersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    weak var delegate: FiltersViewControllerDelegate?
    
    var categories: [[String:String]]!
    var switchStates = [Int:Bool]()
    
    var sectionTitles = ["", "Distance", "Sort By", "Categories"]
    
    var expanded = false
    var expandedSections: [[String]]!
    var collapsedSections = ["", "Auto", "Best Match", "See All"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        categories = yelpCategories()
        expandedSections = [[],
                            ["Auto", "0.3 miles", "1 mile", "5 miles"],
                            ["Best Match", "Distance", "Highest Rated"]
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSearchButton(_ sender: AnyObject) {
        
        var filters = [String: AnyObject]()
        var selectedCategories = [String]()
        
        for (row, isSelected) in  switchStates {
            if isSelected {
                selectedCategories.append(categories[row]["code"]!)
            }
        }
        
        if selectedCategories.count > 0 {
            filters["categories"] = selectedCategories as AnyObject?
        }
        
        delegate?.filtersViewController?(
            filtersViewController: self,
            didUpdateFilters: filters
        )
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPath(for: switchCell)!
        
        switchStates[indexPath.row] = value
    }
    
    func yelpCategories() -> [[String:String]] {
        return [
            ["name": "American (Traditional)", "code": "tradamerican"],
            ["name": "Barbeque", "code": "bbq"],
            ["name": "Breakfast & Brunch", "code": "breakfast_brunch"],
            ["name": "Burgers", "code": "burgers"],
            ["name": "Puerto Rican", "code": "puertorican"],
            ["name": "Korean", "code": "korean"],
            ["name": "Latin American", "code": "latin"],
            ["name": "Mexican", "code": "mexican"],
            ["name": "Tacos", "code": "tacos"],
            ["name": "New Mexican Cuisine", "code": "newmexican"],
            ["name": "Salad", "code": "salad"],
            ["name": "Sandwiches", "code": "sandwiches"],
            ["name": "Soup", "code": "soup"],
            ["name": "Southern", "code": "southern"],
            ["name": "Spanish", "code": "spanish"],
            ["name": "Steakhouses", "code": "steak"],
            ["name": "Sushi Bars", "code": "sushi"]
        ]
    }
}

extension FiltersViewController: UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
        
        if sectionTitles[indexPath.section] == "Categories" {
            cell.switchLabel.text = categories[indexPath.row]["name"]
        } else {
            cell.switchLabel.text = expanded ? expandedSections[indexPath.section][indexPath.row]
                                             : collapsedSections[indexPath.section]
        }
        
        cell.delegate = self
        cell.onSwitch.isOn = switchStates[indexPath.row] ?? false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
 
        // Change value of expanded to true/false accordingly
        expanded = !expanded
        
        tableView.reloadData()
        tableView.reloadSections(NSIndexSet(index: indexPath.section) as IndexSet, with: UITableViewRowAnimation.fade)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sectionTitles[section] {
            case "Categories":
                return categories.count
            default:
                return expanded ? expandedSections[section].count : 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
}
