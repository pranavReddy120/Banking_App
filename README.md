# Banking_App
## Software: XCode , IOS 14 pro simulator 
https://developer.apple.com/xcode/resources/

This is an IOS app that shows the user different financial information from their account. 
The app is biometric-locked, and users will only have access once there is a matching FaceId or TouchId input recognized. 
    
<img src="https://github.com/pranavReddy120/Banking_App/blob/main/Version_2_Images/LoginScreen.png" width="200" height="400" />  <img src="https://github.com/pranavReddy120/Banking_App/blob/main/Version_2_Images/FaceID_Prompt.png" width="200" height="400" /> 



The dashboard screen shows the user's total balance as a bolded title, and underneath it shows an image of their card, with the 3 most recent activities listed below that. 
In this app, there are 2 different bank cards belonging to the user, each with their own unique Recent Activity List. If the user swipes across the card image on the screen, the other card will show, along with its corresponding recent activities. 


<img src="https://github.com/pranavReddy120/Banking_App/blob/main/Version_2_Images/Card1_dash.png" width="200" height="400" /> <img src="https://github.com/pranavReddy120/Banking_App/blob/main/Version_2_Images/Card2_dash.png" width="200" height="400" /> 


On the transaction page, the user can choose to either make a new purchase or a new deposit. If a new purchase is selected, a dropdown will appear prompting the user to input a Destination and Amount and the card they want to charge the purchase to. Once the save transaction button is pressed, the balance is then updated and the new transaction will appear in the history. 

<img src="https://github.com/pranavReddy120/Banking_App/blob/main/Version_2_Images/Card2_History.png" width="200" height="400" /> <img src="https://github.com/pranavReddy120/Banking_App/blob/main/Version_2_Images/Purchase_Dropdown.png" width="200" height="400" /> <img src="https://github.com/pranavReddy120/Banking_App/blob/main/Version_2_Images/Updated_Card2_History.png" width="200" height="400" /> 

The new deposit is the same, only this time there is no Destination prompted as it is auto-assigned to Deposit. The amount is then added to the balance and the information appears in green in the transaction history. 

<img src="https://github.com/pranavReddy120/Banking_App/blob/main/Version_2_Images/Card1_History.png" width="200" height="400" /> <img src="https://github.com/pranavReddy120/Banking_App/blob/main/Version_2_Images/Deposit_Dropdown.png" width="200" height="400" /> <img src="https://github.com/pranavReddy120/Banking_App/blob/main/Version_2_Images/Updated_Card1_History.png" width="200" height="400" /> 

UserDefaults is used to save the balance changes so it is up to date with each relaunch. Saving of the recent activity list is currently in progress, but will most likely require use of MongoDB integration. 

<img src="https://github.com/pranavReddy120/Banking_App/blob/main/Version_2_Images/Updated_Card1_Dash.png" width="200" height="400" /> <img src="https://github.com/pranavReddy120/Banking_App/blob/main/Version_2_Images/Updated_Card2_Dash.png" width="200" height="400" /> 

The profile tab currently has no information and will be created after MongoDB integration. 


Resources: 
- https://www.youtube.com/watch?v=nGmrtPNuE2Q&t=435s 
- https://www.youtube.com/watch?v=8MLdq9kotII
- https://www.youtube.com/watch?v=EKAVB_56RIU
- https://www.mongodb.com/docs/realm/sdk/swift/swiftui-tutorial/
