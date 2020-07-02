//
//  NoteCell.swift
//  NotesApp
//
//  Created by Yaz Burrell on 7/2/20.
//  Copyright © 2020 Yaz Burrell. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var noteBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func populate(with note: Note) {
        categoryLabel.text = "mock category"
        noteBodyLabel.text = note.body
    }
 

}
