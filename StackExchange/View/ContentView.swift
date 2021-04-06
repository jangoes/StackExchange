//
//  ContentView.swift
//  StackExchange
//
//  Created by John Ellie Go on 4/5/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TopQuestionsView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
