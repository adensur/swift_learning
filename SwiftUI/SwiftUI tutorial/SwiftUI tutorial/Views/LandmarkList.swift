//
//  LandmarkList.swift
//  SwiftUI tutorial
//
//  Created by Maksim Gaiduk on 07/06/2023.
//

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        }
    }
    var body: some View {
        List {
            Toggle(isOn: $showFavoritesOnly) {
                Text("Favorites only")
            }
            ForEach(filteredLandmarks) { landmark in
//                NavigationLink {
                LandmarkRow(landmark: landmark)
//                } label: {
//                    LandmarkRow(landmark: landmark)
//                }.isDetailLink(false)
            }
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList().environmentObject(ModelData())
    }
}
