//
//  CircleImage.swift
//  SwiftUI tutorial
//
//  Created by Maksim Gaiduk on 06/06/2023.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    var body: some View {
        image
            .clipShape(Circle())
            .overlay {
            Circle().stroke(.white, lineWidth: 4)
        }.shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: ModelData().landmarks[0].image)
    }
}
