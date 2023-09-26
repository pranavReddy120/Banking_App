# Banking_App
## Software: XCode , IOS 14 pro simulator 
https://developer.apple.com/xcode/resources/

This is an IOS app that shows the user different financial information from their account. 
The app is biometric-locked, and users will only have access once there is a matching FaceId or TouchId input recognized. 
    
<img src="https://github.com/pranavReddy120/Banking_App/blob/main/Images/Login_Page.png" width="200" height="400" />  <img src="https://github.com/pranavReddy120/Banking_App/blob/main/Images/FaceID.png" width="200" height="400" /> 



The dashboard screen shows the user's total balance as a bolded title, and underneath it shows an image of their card, with the 3 most recent activities listed below that. 


<img src="https://github.com/pranavReddy120/Banking_App/blob/main/Images/Dashboard.png" width="200" height="400" /> 

In this app, there are 3 different credit cards belonging to the user, each with their own unique Recent Activity List. If the user swipes across the credit card image on the screen, the other card will show, along with its corresponding recent activities. 

<img src="https://github.com/pranavReddy120/Banking_App/blob/main/Images/creditCard_2.png" width="200" height="400" />  <img src="https://github.com/pranavReddy120/Banking_App/blob/main/Images/creditCard_3.png" width="200" height="400" /> 


On the transaction page, the user can choose to either make a new purchase or a new deposit. If a new purchase is selected, a dropdown will appear prompting the user to input a Destination and Amount and the card they want to charge the purchase to. Once the save transaction button is pressed, the balance is then updated and the new transaction will appear in the recent activity list. 

<img src="https://github.com/pranavReddy120/Banking_App/blob/main/Images/Transaction.png" width="200" height="400" /> <img src="https://github.com/pranavReddy120/Banking_App/blob/main/Images/Purchase_dropdown.png" width="200" height="400" /> <img src="https://github.com/pranavReddy120/Banking_App/blob/main/Images/Updated_dash.png" width="200" height="400" /> 

The new deposit is the same, only this time there is no Destination prompted as it is auto-assigned to Deposit. The amount is then added to the balance and the information appears in green in the recent activity list. 

<img src="https://github.com/pranavReddy120/Banking_App/blob/main/Images/Deposit_dropdown.png" width="200" height="400" /> <img src="https://github.com/pranavReddy120/Banking_App/blob/main/Images/Updated_dash_2.png" width="200" height="400" /> 

UserDefaults is used to save the balance changes so it is up to date with each relaunch. Saving of the recent activity list is currently in progress, but will most likely require use of MongoDB integration. 

<img src="https://github.com/pranavReddy120/Banking_App/blob/main/Images/Reload_dash.png" width="200" height="400" /> 

The profile tab currently has no information and will be created after MongoDB integration. 


Resources: 
- https://www.youtube.com/watch?v=nGmrtPNuE2Q&t=435s 
- https://www.youtube.com/watch?v=8MLdq9kotII
- https://www.youtube.com/watch?v=EKAVB_56RIU
- https://www.mongodb.com/docs/realm/sdk/swift/swiftui-tutorial/
