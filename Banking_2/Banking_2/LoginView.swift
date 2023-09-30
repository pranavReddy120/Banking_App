import SwiftUI
import LocalAuthentication

struct LoginView: View {
    @State private var isAuthenticated = false
    @State private var showDashView = false // Control the visibility of DashView

    var body: some View {
        if isAuthenticated {
            ContentView()
        } else {
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
                    Text("Welcome User")
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

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "This is for security reasons") { success, authenticationError in
                if success {
                    // Authentication succeeded, set isAuthenticated to true
                    isAuthenticated = true
                } else {
                    Text("There was a problem")
                        .foregroundColor(.white)
                }
            }
        } else {
            Text("Phone does not have biometrics")
                .foregroundColor(.white)
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
