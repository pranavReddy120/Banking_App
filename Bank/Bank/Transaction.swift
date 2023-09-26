//
//  Transaction.swift
//  Bank
//
//  Created by Pranav Reddy on 2023-09-24.
//

import SwiftUI

struct Transaction: View {
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            Text("Transactions")
        }
    }
}

struct Transaction_Previews: PreviewProvider {
    static var previews: some View {
        Transaction()
    }
}
