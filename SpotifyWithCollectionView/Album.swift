//
//  Album.swift
//  SpotifyWithCollectionView
//
//  Created by Macbook on 28.08.2022.
//

import Foundation

struct Album {
    
    var songId:Int?
    var songImageName:String?
    var singer:String?
    
    init(songId: Int, songImageName: String, singer: String) {
        self.songId = songId
        self.songImageName = songImageName
        self.singer = singer
    }
}
