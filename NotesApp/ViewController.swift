//
//  ViewController.swift
//  NotesApp
//
//  Created by Yaz Burrell on 6/25/20.
//  Copyright © 2020 Yaz Burrell. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadNotes()
    }
    
    func loadNotes(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        do {
         let fetchedObjects = try context.fetch(fetchRequest)
            guard let notes = fetchedObjects as? [Note] else { return }
            
            self.notes = notes
            tableView.reloadData()
            
        } catch {
            print(error.localizedDescription)
        }
    }

    @IBAction func didTapAddButton(_ sender: Any) {
        let alert = UIAlertController(title: "Add note", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
            
            guard let noteBody = alert.textFields?.first?.text,
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                else { return }
            
            let context = appDelegate.persistentContainer.viewContext
            
            let newNote = Note(context: context)
            newNote.body = noteBody
           
            appDelegate.saveContext()
            
            self.notes.append(newNote)
            self.tableView.reloadData()
            
        }
        
        alert.addAction(saveAction)
        present(alert, animated: true)
    }
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.body
        cell.textLabel?.numberOfLines = 0
        
        return cell
        
    }
    
    
}
