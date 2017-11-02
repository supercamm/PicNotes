//  ViewController.swift

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
    UITextFieldDelegate{
    
    // instance vars
    @IBOutlet weak var addFoodsTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pencil: UIButton!
    @IBOutlet weak var x: UIButton!
    
    var foods:[String] = []
    var cellStyleForEditing: UITableViewCellEditingStyle = .none
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // nsuserdefaults setUp
        foods = defaults.stringArray(forKey: "foods") ?? [String]()
        setUpTableView()
    }
    
    func setUpTableView() {
        tableView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        tableView.layer.shadowOpacity = 0.5
        tableView.layer.shadowRadius = 5
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = false
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "tableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.setCellData(foods[indexPath.item], title: foods[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        swap(&foods[sourceIndexPath.row], &foods[destinationIndexPath.row])
        defaults.set(foods, forKey: "foods")
        tableView.reloadData()
    }
    
    // swipe to delete cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            foods.remove(at: indexPath.row)
            defaults.set(foods, forKey: "foods")
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return cellStyleForEditing
    }
    
    @IBAction func enableEditting(_ sender: Any) {
        if(cellStyleForEditing == .none) {
            cellStyleForEditing = .delete
        } else {
            cellStyleForEditing = .none
        }
        tableView.setEditing(cellStyleForEditing != .none, animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        insertNewFoodTitle()
    }
    
    func insertNewFoodTitle() {
        foods.append(addFoodsTextField.text!)
        let indexPath = IndexPath(row: foods.count - 1, section: 0)
        
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        defaults.set(foods, forKey: "foods")
        tableView.endUpdates()
        
        // set textFeild back to empty string
        addFoodsTextField.text = ""
        view.endEditing(true)
    }
}

