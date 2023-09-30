import SwiftUI
import Firebase

struct NewPurchaseView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var newDest = ""
    @State private var newAmount = ""
    @Binding var showPopup: Bool
    @State private var selectedCard = "1" // Default selection
    @EnvironmentObject var appData: AppData

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select Card").foregroundColor(.blue)) {
                    Picker("Card", selection: $selectedCard) {
                        Text("Card 1").tag("1")
                        Text("Card 2").tag("2")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Transaction Details").foregroundColor(.blue)) {
                    TextField("Name", text: $newDest)
                    TextField("Amount", text: $newAmount)
                        .keyboardType(.decimalPad)
                }
                Button(action: {
                    if let transactionAmount = Double(newAmount) {
                        dataManager.addPur(dest: newDest, am: Int(newAmount) ?? 0, choice: selectedCard)
                        appData.subtractAmount(newAmount)
                        showPopup = false
                    }
                }) {
                    Text("Save")
                        .foregroundColor(.blue)
                       
                }
            }
            .navigationBarItems(trailing:
                Button("Cancel") {
                    showPopup = false
                }
                .foregroundColor(.red)
                .padding(.horizontal, 10)
            )
            Spacer()
        }
    }
}

struct NewPurchaseView_Previews: PreviewProvider {
    @State private static var showPopup = false
    
    static var previews: some View {
        NewPurchaseView(showPopup: $showPopup)
    }
}
