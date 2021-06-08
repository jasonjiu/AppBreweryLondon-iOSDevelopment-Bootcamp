//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        title = K.appName
        navigationItem.hidesBackButton = true
        
        loadMessage()
    }
    
    func loadMessage(){
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener{ (querrySnapshot, error) in
            self.messages = []
            if let e  = error{
                print("there was an issue get data from firebase. \(e)")
            }else{
                if let snapShotDocument = querrySnapshot?.documents {
                    for doc in snapShotDocument {
                        
                        let data = doc.data()
                        if let msgSender = data[K.FStore.senderField] as? String,
                           let msgBody = data[K.FStore.bodyField] as? String{
                            let newMsg = Message(sender: msgSender, body: msgBody)
                            self.messages.append(newMsg)
                            
                            DispatchQueue.main.async {
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.reloadData()
                                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if  let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email{
            db.collection(K.FStore.collectionName)
                .addDocument(data: [K.FStore.senderField: messageSender, K.FStore.bodyField: messageBody, K.FStore.dateField: Date().timeIntervalSince1970])
                { (error) in
                    if let e = error{
                        print("There was an issue saving data with firestore,\(e)")
                    }
                    else{
                        print("Successfully saved data")
                    }
                }
            self.messageTextfield.text = ""
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
}

extension ChatViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLabel.text = message.body
        
        // message from current user
        if message.sender == Auth.auth().currentUser?.email{
            cell.avatarImage?.isHidden = false
            cell.leftAvatarImage.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.purple)
        } // message from other user
        else{
            cell.avatarImage?.isHidden = true
            cell.leftAvatarImage.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
      
        return cell
    }
}


