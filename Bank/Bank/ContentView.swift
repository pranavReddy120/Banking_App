import LocalAuthentication
import SwiftUI
import Foundation
import Combine
@main
struct BankApp: App {
    @StateObject private var appData = AppData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appData) // Inject appData as an environment object
        }
    }
}
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
    
    func subtractAmount(_ amount: Double) {
        totalBalance -= amount
    }
    
    func addAmount(_ amount: Double){
        totalBalance += amount
    }
}
struct ContentView: View {
    @State private var isUnlocked = false
    @EnvironmentObject var appData: AppData
    @State private var fakeCreditCards: [(imageName: String, cardName: String, recentActivities: [(title: String, amount: String)])] = [
        ("fake_credit_card", "Card 1", [
            ("Amazon", "-$200"),
            ("Netflix", "-$15"),
            ("Deposit", "+$500")
        ]),
        ("fake_credit_card_2", "Card 2", [
            ("E-Transfer", "+$225"),
            ("Gas Station", "-$30"),
            ("Dinner", "-$60")
        ]),
        ("fake_credit_card_3", "Card 3", [
            ("Electronics Store", "-$500"),
            ("Clothing Store", "-$100"),
            ("Movie Tickets", "-$25")
        ])
    ]
    
    
    init() {
        // Customize the appearance of the navigation bar
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white, // Text color
            .font: UIFont.systemFont(ofSize: 24) // Font size and style
        ]
    }
    var body: some View {
        if isUnlocked {
            // Show the tab bar after authentication
            TabView {
                // Dashboard Tab
                DashboardView(fakeCreditCards: $fakeCreditCards)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Dashboard")
                    }
                // Transactions Tab
                TransactionsView(fakeCreditCards: $fakeCreditCards)
                    .tabItem {
                        Image(systemName: "creditcard.fill")
                        Text("Transactions")
                    }
                // Profile Tab
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.circle.fill")
                        Text("Profile")
                    }
            }
            .onAppear() {
                UITabBar.appearance().unselectedItemTintColor = UIColor.white
            }
            .background(Color(red: 6 / 255, green: 32 / 255, blue: 70 / 255)) // Set the tab bar's background color
        } else {
            // Show the login screen when not authenticated
            LoginView(authenticate: authenticate)
        }
    }
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "This is for security reasons") { success, authenticationError in
                if success {
                    // Authentication successful
                    isUnlocked = true
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct DashboardView: View {
    @Binding var fakeCreditCards: [(imageName: String, cardName: String, recentActivities: [(title: String, amount: String)])]
    @State private var selectedCardIndex = 0 // Track the selected card index
    @EnvironmentObject var appData: AppData
    
    
    var body: some View {
        ZStack {
            Color(red: 6 / 255, green: 32 / 255, blue: 70 / 255) // Background color
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(String(format: "$%.2f", appData.totalBalance)) // Display total balance
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
                    .padding(.top, 50)
                //Card swipe display
                TabView(selection: $selectedCardIndex) {
                    ForEach(0..<fakeCreditCards.count, id: \.self) { index in
                        Image(fakeCreditCards[index].imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 400, height: 400)
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                Text("Recent Activity")
                    .foregroundColor(.white)
                    .font(.title2)
                // Display the recent activities for the selected card
                let recentActivities = fakeCreditCards[selectedCardIndex].recentActivities.prefix(3) // Show only the most recent 3 items
                ForEach(recentActivities.indices, id: \.self) { activityIndex in
                    ExpenseRow(
                        title: recentActivities[activityIndex].title,
                        amount: recentActivities[activityIndex].amount,
                        color: .red
                    )
                    .padding(5)
                }
                Spacer(minLength: 100)
            }
            .background(Color(red: 6 / 255, green: 32 / 255, blue: 70 / 255)) // Set the background color
        }
    }
}
struct ExpenseRow: View {
    var title: String
    var amount: String
    var color: Color // Color parameter for text color
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(title == "Deposit" || title == "E-Transfer" ? .green : color) // Use green color for "Deposit" and "E-Transfer," otherwise use the provided color parameter
                .font(.headline)
            Spacer()
            Text(amount)
                .foregroundColor(amount.hasPrefix("+") ? .green : color) // Use green color if amount starts with '+', otherwise use the provided color parameter
                .font(.headline)
                .padding(.trailing, 20) // Add some spacing from the right edge
        }
        .padding(.horizontal) // Add horizontal padding to the entire row
    }
}
struct TransactionsView: View {
    @Binding var fakeCreditCards: [(imageName: String, cardName: String, recentActivities: [(title: String, amount: String)])]
    @State private var isCreatingTransaction = false
    @State private var isCreatingDeposit = false
    @State private var selectedCardIndex = 0
    @State private var transactionAmount = ""
    @State private var transactionDestination = ""
    var body: some View {
        ZStack {
                    Color(red: 6 / 255, green: 32 / 255, blue: 70 / 255)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Button("New Purchase") {
                            isCreatingTransaction.toggle()
                        }
                        .buttonStyle(PrimaryButtonStyle()) // Apply custom button style
                        .padding(.top, 20)
                        
                        Button("New Deposit") {
                            isCreatingDeposit.toggle()
                        }
                        .buttonStyle(PrimaryButtonStyle()) // Apply custom button style
                        .padding(.top, 20)
                        
                        Spacer()
                    }
                }
        .sheet(isPresented: $isCreatingTransaction) {
            NewTransactionView(selectedCardIndex: $selectedCardIndex, destination: $transactionDestination, amount: $transactionAmount, fakeCreditCards: $fakeCreditCards)
        }
        .sheet(isPresented: $isCreatingDeposit) {
            NewDepositView(selectedCardIndex: $selectedCardIndex, amount: $transactionAmount, fakeCreditCards: $fakeCreditCards)
        }
    }
}
struct NewDepositView: View {
    @Binding var selectedCardIndex: Int
    @Binding var amount: String
    @EnvironmentObject var appData: AppData
    @Binding var fakeCreditCards: [(imageName: String, cardName: String, recentActivities: [(title: String, amount: String)])]
    // Add the presentation mode
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select Card")) {
                    Picker("Card", selection: $selectedCardIndex) {
                        ForEach(0..<fakeCreditCards.count, id: \.self) { index in
                            Text(fakeCreditCards[index].cardName)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Deposit Amount")) {
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                }
                Button("Save Deposit") {
                    if let depositAmount = Double(amount) {
                        appData.addAmount(depositAmount)
                        
                        // Add the deposit transaction to the list
                        fakeCreditCards[selectedCardIndex].recentActivities.insert(("Deposit", "+$\(depositAmount)"), at: 0)
                        // Ensure there are only three items in the recent deposit activity list
                        if fakeCreditCards[selectedCardIndex].recentActivities.count > 3 {
                            fakeCreditCards[selectedCardIndex].recentActivities.removeLast()
                        }
                        // Dismiss the sheet
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarItems(trailing:
                                    Button("Cancel") {
                                        // Dismiss the sheet without saving the transaction
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                    .foregroundColor(.red)
                                    .padding(.horizontal, 10)
            )
            Spacer()
        }
    }
}
struct NewTransactionView: View {
    @Binding var selectedCardIndex: Int
    @Binding var destination: String
    @Binding var amount: String
    @EnvironmentObject var appData: AppData
    @Binding var fakeCreditCards: [(imageName: String, cardName: String, recentActivities: [(title: String, amount: String)])]
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select Card")) {
                    Picker("Card", selection: $selectedCardIndex) {
                        ForEach(0..<fakeCreditCards.count, id: \.self) { index in
                            Text(fakeCreditCards[index].cardName)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Transaction Details")) {
                    TextField("Destination", text: $destination)
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                }
                Button("Save Transaction") {
                    if let transactionAmount = Double(amount) {
                        appData.subtractAmount(transactionAmount)
                        let newTransaction = (title: destination, amount: "-$\(amount)")
                        fakeCreditCards[selectedCardIndex].recentActivities.insert(newTransaction, at: 0)
                        if fakeCreditCards[selectedCardIndex].recentActivities.count > 3 {
                            fakeCreditCards[selectedCardIndex].recentActivities.removeLast()
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarItems(trailing:
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.red)
                .padding(.horizontal, 10)
            )
            Spacer()
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Add a slight animation on press
    }
}

struct ProfileView: View {
    var body: some View {
        ZStack {
            Color(red: 6 / 255, green: 32 / 255, blue: 70 / 255) // Background color
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Profile View")
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
                    .padding(.top, 50)
            }
        }
    }
}
struct LoginView: View {
    var authenticate: () -> Void
    var body: some View {
        ZStack {
            Color(red: 6 / 255, green: 32 / 255, blue: 70 / 255) // Background color
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("PY Bank") // Move this line to the top
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.top, 20) // Adjust top padding for centering
                Spacer(minLength: 10)
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                Text("Welcome Bob")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                Button("Login") {
                    authenticate()
                }
                .padding(.horizontal, 60)
                .padding(.vertical, 15)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                Spacer()
            }
        }
    }
}
struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

