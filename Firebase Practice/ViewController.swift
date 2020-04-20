//
//  ViewController.swift
//  Firebase Practice
//
//  Created by Likhit Garimella on 20/04/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet var name: UITextField!
    @IBOutlet var genre: UITextField!
    @IBOutlet var labelMessage: UILabel!
    
    @IBOutlet var tblArtists: UITableView!
    
    var artistsList = [ArtistModel]()
    
    var refArtists: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
    }
    
    @IBAction func addArtist(_ sender: UIButton) {
        
        addArtist()
        
    }
    
    func addArtist() {
        
        refArtists = Database.database().reference().child("Artists");
        let key = refArtists.childByAutoId().key
        let artist = ["id": key, "artistName": name.text!, "artistGenre": genre.text!]
        refArtists.child(key!).setValue(artist)
        labelMessage.text = "Artist Added"
        
    }
    
    func retrieveData() {
        
        let dataDB = Database.database().reference().child("Artists")
        
        dataDB.observe(.childAdded)   //This means whenever a new entry gets added into the messages database, and this parameter takes a closure
        { (snapshot) in
           
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            
            
        }
        
    }
    
}

// Dismiss keyboard on tapping anywhere
extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}   // #58
