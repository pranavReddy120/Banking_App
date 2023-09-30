import SwiftUI
import Firebase
import Combine

class DataManager: ObservableObject {
    @Published var history: [Purchase] = []
    @Published var card2History: [Purchase] = [] // Add card2History
    
    init() {
        fetchPurchase(choice: "1") // Fetch data from "Purchases" initially
        fetchPurchase(choice:  "2")
    }
    
    func fetchPurchase(choice: String) {
        history.removeAll()
        card2History.removeAll()
        
        let db = Firestore.firestore()
        var ref: CollectionReference
        
        if choice == "1" {
            ref = db.collection("Purchases")
        } else if choice == "2" {
            ref = db.collection("Card_2_Purchases")
        } else {
            fatalError("Invalid choice")
        }
        
        // Fetch data for "Purchases" or "Card_2_Purchases"
        ref.order(by: "id", descending: true).getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let amount = data["amount"] as? Int ?? 0
                    let destination = data["destination"] as? String ?? ""
                    
                    // Parse the timestamp from the Firestore data
                    let timestamp = data["timestamp"] as? TimeInterval ?? 0.0
                    let date = Date(timeIntervalSince1970: timestamp)
                    
                    let pur = Purchase(id: id, amount: amount, destination: destination, timestamp: date)
                    
                    if choice == "1" {
                        self.history.append(pur)
                    } else if choice == "2" {
                        self.card2History.append(pur)
                    }
                }
            }
        }
    }

    
    func addPur(dest: String, am: Int, choice: String) {
        let db = Firestore.firestore()
        var ref: CollectionReference?
        
        if choice == "1" {
            ref = db.collection("Purchases")
        } else if choice == "2" {
            ref = db.collection("Card_2_Purchases")
        } else {
            fatalError("Invalid choice")
        }
        
        if let validRef = ref {
            let currentCount = (choice == "1") ? history.count : card2History.count
            let newId = String(currentCount + 1)
            
            // Record the current timestamp as a Unix timestamp
            let timestamp = Date().timeIntervalSince1970
            
            let docRef = validRef.document(newId)
            
            docRef.setData(["id": newId, "destination": dest, "amount": am, "timestamp": timestamp]) { error in
                if let error = error {
                    print("Error adding document: \(error.localizedDescription)")
                } else {
                    print("Document added successfully!")
                    
                    self.fetchPurchase(choice: "1")
                    self.fetchPurchase(choice: "2")
                }
            }
        }
    }
}
