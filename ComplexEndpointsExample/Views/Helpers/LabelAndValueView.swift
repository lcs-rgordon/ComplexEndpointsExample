//
//  LabelAndValueView.swift
//  ComplexEndpointsExample
//
//  Created by Russell Gordon on 2025-05-25.
//

import SwiftUI

struct LabelAndValueView: View {
    
    // MARK: Stored properties
    let label: String
    let value: String
    
    // MARK: Computed properties
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(label)
                    .bold()
                Spacer()
            }
            Text(value)
        }
    }
}

#Preview {
    LabelAndValueView(label: "Full name", value: "Margaret Eleanor Atwood")
        .padding()
}
