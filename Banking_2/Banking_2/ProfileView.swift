import SwiftUI
import Charts
import SwiftUICharts

struct Item: Identifiable {
    var id = UUID()
    let type: String
    let value: Int
}

struct ProfileView: View {
    @EnvironmentObject var dataManager: DataManager // Assuming DataManager holds your history data
    
    var body: some View {
        ZStack {
//            Color(.black)
//                .opacity(0.8)
//                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    if !dataManager.history.isEmpty {
                        createChart(data: dataManager.history, title: "Card 1 Purchase Total")
                    } else {
                        Text("No Card 1 data available.")
                    }
                    
                    if !dataManager.card2History.isEmpty {
                        createChart(data: dataManager.card2History, title: "Card 2 Purchase Total", removeNegativeValues: true)
                    } else {
                        Text("No Card 2 data available.")
                    }
                }
                
            }
        }
    }
    
    
    func createChart(data: [Purchase], title: String, removeNegativeValues: Bool = false) -> some View {
        // Create a dictionary to group data by day and calculate the total amount for each day
        var dailyData: [String: Int] = [:]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Change the date format to group by day
        
        for purchase in data {
            let dayString = dateFormatter.string(from: purchase.timestamp)
            
            if purchase.destination == "Deposit" {
                // Subtract deposit amount if the title is "Deposit"
                dailyData[dayString, default: 0] -= purchase.amount
            } else {
                dailyData[dayString, default: 0] += purchase.amount
            }
        }
        
        // Optionally, filter out negative values
        if removeNegativeValues {
            dailyData = dailyData.filter { $0.value >= 0 }
        }
        
        // Sort the data by day and create chart data
        let chartData: [Item] = dailyData.sorted { $0.key < $1.key }.map { (day, totalAmount) in
            return Item(type: day, value: totalAmount)
        }
        
        return VStack {
            Text(title)
                .font(.title)
                .padding()
                .bold()
            
            Chart(chartData) { item in
                BarMark(
                    x: .value("Day", item.type), // Change the label to "Day"
                    y: .value("Total Amount", item.value)
                )
            }
            .frame(height: 200)
            .padding()
        }
        .background(Color.clear) // Make the VStack background transparent
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
                .environmentObject(DataManager()) // Provide DataManager instance for preview
        }
    }
}
