//
//  NoteEditorVC.swift
//  NotesApp
//
//  Created by Yaz Burrell on 7/1/20.
//  Copyright © 2020 Yaz Burrell. All rights reserved.
//

import UIKit

class NoteEditorVC: UIViewController {
    
    @IBOutlet weak var categoryTextField: UITextField!
    
    @IBOutlet weak var noteTextView: UITextView!
    
    
    var note: Note?
    
    var userDidSave: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        
        let doneBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        
        navigationItem.rightBarButtonItem = doneBarButtonItem
        
        if let note = self.note {
            noteTextView.text = note.body
            navigationItem.title = "Edit Note"
            
            categoryTextField.isUserInteractionEnabled = false
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        noteTextView.becomeFirstResponder()
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if userDidSave == false  {
            
            saveNote()
            
        }
    }

    func saveNote() {
        guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                noteTextView.text.isEmpty == false
            else { return }
          let context = appDelegate.persistentContainer.viewContext
          
          if let note = self.note {
              
              note.body = noteTextView.text
              
              } else {
              
                let newNote = Note(context: context)
              newNote.body = noteTextView.text
            
                let category = Category(context: context)
                category.name = categoryTextField.text
                newNote.category = category
            
          }
          
          appDelegate.saveContext()
    }
    
    
    @objc func didTapDone(){
        print("done")
        
        saveNote()
        
        userDidSave = true
        
      navigationController?.popViewController(animated: true)
    }

}
