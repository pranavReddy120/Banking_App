import SwiftUI

class AppData: ObservableObject {
    @Published var totalBalance: Double {
        didSet {
            UserDefaults.standard.set(totalBalance, forKey: "totalBalance")
        }
    }
    
    init() {
        self.totalBalance = UserDefaults.standard.double(forKey: "totalBalance")
        if totalBalance == 0.0 {
            totalBalance = 5000.0
        }
    }
    
    func subtractAmount(_ amount: String) {
        totalBalance -= Double(amount) ?? 0.0
    }
    
    func addAmount(_ amount: String){
        totalBalance += Double(amount) ?? 0.0
    }
}

public struct DashView: View {
    var cardImages = ["Card_1", "Card_2"]
    @State private var selectedTabIndex = 0
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var appData: AppData

    public var body: some View {
        ZStack {
            Color(red: 6 / 255, green: 32 / 255, blue: 70 / 255)
                .ignoresSafeArea()

            VStack {
                Text(String(format: "$%.2f", appData.totalBalance))
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.top)
                    .bold()
                Spacer()
                
                TabView(selection: $selectedTabIndex) {
                    ForEach(0..<cardImages.count, id: \.self) { index in
                        Image(cardImages[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350, height: 250)
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.vertical, 50) // Reduce vertical padding

               
                Text("Recent Activity")
                    .foregroundColor(.white)
                
                Spacer(minLength: 10) // Increase spacing between title and recent activity items
                
                // Display the recent activity text with increased font size and spacing
                let recentPurchases = selectedTabIndex == 0 ? Array(dataManager.history.sorted { $0.timestamp > $1.timestamp }.prefix(4)) : Array(dataManager.card2History.sorted { $0.timestamp > $1.timestamp }.prefix(4))

                ForEach(recentPurchases, id: \.id) { pur in
                    HStack {
                        Text(pur.destination)
                            .foregroundColor(.white)
                            .font(.headline) // Increase font size
                        Spacer()
                        Text("\(pur.amount)")
                            .foregroundColor(pur.destination == "Deposit" ? .green : .red) // Change text color to green for "Deposit"
                            .font(.headline) // Increase font size
                    }
                    .padding(.horizontal, 10) // Reduce horizontal padding
                    .padding(.vertical, 5) // Increase vertical spacing between items
                }

                Spacer(minLength: 50) // Increase spacing between recent activity and the bottom
            }
            .padding(.bottom, 10)
        }
    }
}



#Preview {
    DashView()
        .environmentObject(DataManager()) // Provide a DataManager instance for preview
}
