//
//  NoteEditorVC.swift
//  NotesApp
//
//  Created by Yaz Burrell on 7/1/20.
//  Copyright © 2020 Yaz Burrell. All rights reserved.
//

import UIKit

class NoteEditorVC: UIViewController {
    
    @IBOutlet weak var noteTextView: UITextView!
    
    var note: Note?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        
        let doneBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        
        navigationItem.rightBarButtonItem = doneBarButtonItem
        
        if let note = self.note {
            noteTextView.text = note.body
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        noteTextView.becomeFirstResponder()
    }

    @objc func didTapDone(){
        print("done")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        if let note = self.note {
            
            note.body = noteTextView.text
            
            } else {
            
            let newNote = Note(context: context)
            newNote.body = noteTextView.text
        }
        
        appDelegate.saveContext()
        
      
        navigationController?.popViewController(animated: true)
    }

}
