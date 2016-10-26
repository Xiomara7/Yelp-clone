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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        categories = yelpCategories()
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
            ["name": "Afghan", "code": "afghani"],
            ["name": "African", "code": "african"],
            ["name": "Senegalese", "code": "senegalese"],
            ["name": "South African", "code": "southafrican"],
            ["name": "American (New)", "code": "newamerican"],
            ["name": "American (Traditional)", "code": "tradamerican"],
            ["name": "Arabian", "code": "arabian"],
            ["name": "Argentine", "code": "argentine"],
            ["name": "Armenian", "code": "armenian"],
            ["name": "Asian Fusion", "code": "asianfusion"],
            ["name": "Australian", "code": "australian"],
            ["name": "Austrian", "code": "austrian"],
            ["name": "Bangladeshi", "code": "bangladeshi"],
            ["name": "Barbeque", "code": "bbq"],
            ["name": "Basque", "code": "basque"],
            ["name": "Belgian", "code": "belgian"],
            ["name": "Brasseries", "code": "brasseries"],
            ["name": "Brazilian", "code": "brazilian"],
            ["name": "Breakfast & Brunch", "code": "breakfast_brunch"],
            ["name": "British", "code": "british"],
            ["name": "Buffets", "code": "buffets"],
            ["name": "Burgers", "code": "burgers"],
            ["name": "Burmese", "code": "burmese"],
            ["name": "Cafes", "code": "cafes"],
            ["name": "Themed Cafes", "code": "themedcafes"],
            ["name": "Cafeteria", "code": "cafeteria"],
            ["name": "Cajun/Creole", "code": "cajun"],
            ["name": "Cambodian", "code": "cambodian"],
            ["name": "Caribbean", "code": "caribbean"],
            ["name": "Dominican", "code": "dominican"],
            ["name": "Haitian", "code": "haitian"],
            ["name": "Puerto Rican", "code": "puertorican"],
            ["name": "Trinidadian", "code": "trinidadian"],
            ["name": "Catalan", "code": "catalan"],
            ["name": "Cheesesteaks", "code": "cheesesteaks"],
            ["name": "Chicken Shop", "code": "chickenshop"],
            ["name": "Chicken Wings", "code": "chicken_wings"],
            ["name": "Chinese", "code": "chinese"],
            ["name": "Cantonese", "code": "cantonese"],
            ["name": "Dim Sum", "code": "dimsum"],
            ["name": "Hainan", "code": "hainan"],
            ["name": "Shanghainese", "code": "shanghainese"],
            ["name": "Szechuan", "code": "szechuan"],
            ["name": "Comfort Food", "code": "comfortfood"],
            ["name": "Creperies", "code": "creperies"],
            ["name": "Cuban", "code": "cuban"],
            ["name": "Czech", "code": "czech"],
            ["name": "Delis", "code": "delis"],
            ["name": "Diners", "code": "diners"],
            ["name": "Dinner Theater", "code": "dinnertheater"],
            ["name": "Ethiopian", "code": "ethiopian"],
            ["name": "Fast Food", "code": "hotdogs"],
            ["name": "Filipino", "code": "filipino"],
            ["name": "Fish & Chips", "code": "fishnchips"],
            ["name": "Fondue", "code": "fondue"],
            ["name": "Food Court", "code": "food_court"],
            ["name": "Food Stands", "code": "foodstands"],
            ["name": "French", "code": "french"],
            ["name": "Mauritius", "code": "mauritius"],
            ["name": "Reunion", "code": "reunion"],
            ["name": "Gastropubs", "code": "gastropubs"],
            ["name": "German", "code": "german"],
            ["name": "Gluten-Free", "code": "gluten_free"],
            ["name": "Greek", "code": "greek"],
            ["name": "Halal", "code": "halal"],
            ["name": "Hawaiian", "code": "hawaiian"],
            ["name": "Himalayan/Nepalese", "code": "himalayan"],
            ["name": "Hong Kong Style Cafe", "code": "hkcafe"],
            ["name": "Hot Dogs", "code": "hotdog"],
            ["name": "Hot Pot", "code": "hotpot"],
            ["name": "Hungarian", "code": "hungarian"],
            ["name": "Iberian", "code": "iberian"],
            ["name": "Indian", "code": "indpak"],
            ["name": "Indonesian", "code": "indonesian"],
            ["name": "Irish", "code": "irish"],
            ["name": "Italian", "code": "italian"],
            ["name": "Calabrian", "code": "calabrian"],
            ["name": "Sardinian", "code": "sardinian"],
            ["name": "Tuscan", "code": "tuscan"],
            ["name": "Japanese", "code": "japanese"],
            ["name": "Izakaya", "code": "izakaya"],
            ["name": "Ramen", "code": "ramen"],
            ["name": "Teppanyaki", "code": "teppanyaki"],
            ["name": "Korean", "code": "korean"],
            ["name": "Kosher", "code": "kosher"],
            ["name": "Laotian", "code": "laotian"],
            ["name": "Latin American", "code": "latin"],
            ["name": "Colombian", "code": "colombian"],
            ["name": "Salvadoran", "code": "salvadoran"],
            ["name": "Venezuelan", "code": "venezuelan"],
            ["name": "Live/Raw Food", "code": "raw_food"],
            ["name": "Malaysian", "code": "malaysian"],
            ["name": "Mediterranean", "code": "mediterranean"],
            ["name": "Falafel", "code": "falafel"],
            ["name": "Mexican", "code": "mexican"],
            ["name": "Tacos", "code": "tacos"],
            ["name": "Middle Eastern", "code": "mideastern"],
            ["name": "Egyptian", "code": "egyptian"],
            ["name": "Lebanese", "code": "lebanese"],
            ["name": "Modern European", "code": "modern_european"],
            ["name": "Mongolian", "code": "mongolian"],
            ["name": "Moroccan", "code": "moroccan"],
            ["name": "New Mexican Cuisine", "code": "newmexican"],
            ["name": "Nicaraguan", "code": "nicaraguan"],
            ["name": "Noodles", "code": "noodles"],
            ["name": "Pakistani", "code": "pakistani"],
            ["name": "Pan Asian", "code": "panasian"],
            ["name": "Persian/Iranian", "code": "persian"],
            ["name": "Peruvian", "code": "peruvian"],
            ["name": "Pizza", "code": "pizza"],
            ["name": "Polish", "code": "polish"],
            ["name": "Pop-Up Restaurants", "code": "popuprestaurants"],
            ["name": "Portuguese", "code": "portuguese"],
            ["name": "Poutineries", "code": "poutineries"],
            ["name": "Russian", "code": "russian"],
            ["name": "Salad", "code": "salad"],
            ["name": "Sandwiches", "code": "sandwiches"],
            ["name": "Scandinavian", "code": "scandinavian"],
            ["name": "Scottish", "code": "scottish"],
            ["name": "Seafood", "code": "seafood"],
            ["name": "Singaporean", "code": "singaporean"],
            ["name": "Slovakian", "code": "slovakian"],
            ["name": "Soul Food", "code": "soulfood"],
            ["name": "Soup", "code": "soup"],
            ["name": "Southern", "code": "southern"],
            ["name": "Spanish", "code": "spanish"],
            ["name": "Sri Lankan", "code": "srilankan"],
            ["name": "Steakhouses", "code": "steak"],
            ["name": "Supper Clubs", "code": "supperclubs"],
            ["name": "Sushi Bars", "code": "sushi"],
            ["name": "Syrian", "code": "syrian"],
            ["name": "Taiwanese", "code": "taiwanese"],
            ["name": "Tapas Bars", "code": "tapas"],
            ["name": "Tapas/Small Plates", "code": "tapasmallplates"],
            ["name": "Tex-Mex (te", "code": "mex"],
            ["name": "Thai", "code": "thai"],
            ["name": "Turkish", "code": "turkish"],
            ["name": "Ukrainian", "code": "ukrainian"],
            ["name": "Uzbek", "code": "uzbek"],
            ["name": "Vegan", "code": "vegan"],
            ["name": "Vegetarian", "code": "vegetarian"],
            ["name": "Vietnamese", "code": "vietnamese"],
            ["name": "Waffles", "code": "waffles"],
            ["name": "Wraps", "code": "wraps"]
        ]
    }
}

extension FiltersViewController: UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
        
        cell.switchLabel.text = categories[indexPath.row]["name"]
        cell.delegate = self
        
        cell.onSwitch.isOn = switchStates[indexPath.row] ?? false
        
        return cell
    }
}
