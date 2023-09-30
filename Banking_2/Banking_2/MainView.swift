import SwiftUI

struct MainView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var showPopup = false
    @State private var selectedCard = "Card 1" // Default selection
    @State private var showDepositView = false
    
    init() {
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(red: 0.00, green: 0.48, blue: 1.00, alpha: 1.00), .font : UIFont.boldSystemFont(ofSize: 15)], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        
        
//        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .headline)], for: .normal)
    }
    
    var body: some View {
        ZStack {
            Color(red: 6 / 255, green: 32 / 255, blue: 70 / 255)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Button(action: {
                        showDepositView = true
                    }) {
                        Text("Deposit")
                            .foregroundColor(.white)
                            .padding(10) // Increase the padding
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                    
                    Text("History")
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                    
                    Spacer()
                    
                    Button(action: {
                        showPopup.toggle()
                    }) {
                        Text("Purchase")
                            .foregroundColor(.white)
                            .padding(10) // Increase the padding
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    Picker("Select Card", selection: $selectedCard) {
                        Text("Card 1")
                            .tag("Card 1")
                            
                        Text("Card 2")
                            .tag("Card 2")
                           
                        
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(10) // Add padding to the Picker
                    .cornerRadius(10)
                }
                .padding(.horizontal)

                
                Spacer()
                
                ScrollView {
                    ForEach(getSelectedHistory().sorted { $0.timestamp > $1.timestamp }) { purchase in // Sort by timestamp in descending order
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(purchase.destination)")
                                    .foregroundColor(.white)
                                Spacer()
                                Text("\(purchase.amount)")
                                    .foregroundColor(purchase.destination == "Deposit" ? .green : .red)
                            }
                            Text("Timestamp: \(formattedTimestamp(for: purchase.timestamp))")
                                .foregroundStyle(.white)
                        }
                        .padding()
                        .background(Color(red: 6 / 255, green: 32 / 255, blue: 70 / 255))
                        .cornerRadius(10)
                        .padding(.vertical, 5)
                    }
                }
            }
            .padding()
        }
        .sheet(isPresented: $showPopup, content: {
            if selectedCard == "Card 1" {
                NewPurchaseView(showPopup: $showPopup)
                    .environmentObject(dataManager)
            } else {
                NewPurchaseView(showPopup: $showPopup)
                    .environmentObject(dataManager)
            }
        })
        // Show the NewDepositView when showDepositView is true
        .sheet(isPresented: $showDepositView, content: {
            NewDepositView(showPopup: $showDepositView)
                .environmentObject(dataManager)
        })
    }
    
    
    // Function to format timestamp for display
    private func formattedTimestamp(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Customize date format as needed
        return dateFormatter.string(from: date)
    }
    
    // Function to get the selected card's history
    private func getSelectedHistory() -> [Purchase] {
        if selectedCard == "Card 1" {
            return dataManager.history
        } else if selectedCard == "Card 2" {
            return dataManager.card2History
        } else {
            return [] // Handle invalid selections
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(DataManager())
    }
}
