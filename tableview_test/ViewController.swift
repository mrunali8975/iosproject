//
//  ViewController.swift
//  tableview_test
//
//  Created by user214343 on 2/3/22.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var data: [String?] = []
    var people: [NSManagedObject] = []
    var a : String?
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var namelist: UITableView!
    
    @IBAction func buttonclick(_ sender: Any) {
        a = textfield.text
        data.append(a)
        namelist.reloadData()
        textfield.text = ""
        
        if let values = a{
            save(name: values)
            getvalue()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getvalue()
    }
    @objc func addtab()
    {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
        guard let detailVC = storyboard.instantiateViewController(identifier: "detailsViewController") as? DetailsViewController else {
            print("ViewController not found")
            return
        }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        namelist.delegate = self
        namelist.dataSource = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addtab))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addtab))
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return people	.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
    
        let person = people[indexPath.row]
            
            cell.textLabel?.text =
              person.value(forKeyPath: "name") as? String
        return cell
    }
    
    func save(name: String) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "Entity",
                                   in: managedContext)!
      
      let person = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      // 3
      person.setValue(name, forKeyPath: "name")
      person.setValue(11, forKeyPath: "rollno")

      // 4
      do {
        try managedContext.save()
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    func getvalue(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          
          let managedContext =
            appDelegate.persistentContainer.viewContext
          
          //2
          let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Entity")
          
          //3
          do {
            people = try managedContext.fetch(fetchRequest)
              namelist.reloadData()
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }    }

}

