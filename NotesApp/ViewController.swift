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
        
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        
        performSegue(withIdentifier: "segue.Main.notesListToNoteEditor", sender: nil)
        
//        let alert = UIAlertController(title: "Add note", message: nil, preferredStyle: .alert)
//        alert.addTextField()
        
//        let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
//
//            guard let noteBody = alert.textFields?.first?.text,
//                let appDelegate = UIApplication.shared.delegate as? AppDelegate
//                else { return }
//
//            let context = appDelegate.persistentContainer.viewContext
//
//            let newNote = Note(context: context)
//            newNote.body = noteBody
//
//            appDelegate.saveContext()
//
//            self.notes.append(newNote)
//            self.tableView.reloadData()
//
//        }
        
//        alert.addAction(saveAction)
//        present(alert, animated: true)
    }
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        cell.selectionStyle = .none
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as? NoteCell else { return UITableViewCell() }
        
        let note = notes[indexPath.row]
        
        cell.populate(with: note)
    
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let note = notes[indexPath.row]

        performSegue(withIdentifier: "segue.Main.notesListToNoteEditor", sender: note)
        
//        let alert = UIAlertController(title: "Edit note", message: nil, preferredStyle: .alert)
//        alert.addTextField { (textField) in
//            textField.text = note.body
//        }
//
//        let updateAction = UIAlertAction(title: "Update", style: .default) { (_) in
//            guard
//                let updatedNoteBody = alert.textFields?.first?.text,
//                let appDelegate =  UIApplication.shared.delegate as? AppDelegate
//                else { return }
//
//            note.body = updatedNoteBody
//            appDelegate.saveContext()
//            self.loadNotes()
//
//
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//
//        alert.addAction(cancelAction)
//        alert.addAction(updateAction)
//
//        DispatchQueue.main.async {
//            self.present(alert, animated: true)
//
//        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let note = notes[indexPath.row]
        
        context.delete(note)
        appDelegate.saveContext()
        
        do {
            try note.validateForDelete()
            context.delete(note)
            try context.save()
            
            notes.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let noteEditorVC = segue.destination as? NoteEditorVC, let note = sender as? Note {
            
            noteEditorVC.note = note
        }
    }
}
