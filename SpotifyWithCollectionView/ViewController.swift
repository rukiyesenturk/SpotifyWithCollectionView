//
//  ViewController.swift
//  SpotifyWithCollectionView
//
//  Created by Macbook on 28.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var libraryList = [Library]()
    var albumList = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let l1 = Library(songId: 1, songImageName: "karsu", singer: "Karsu")
        let l2 = Library(songId: 2, songImageName: "hafifmuzik", singer: "Hafif Müzik")
        let l3 = Library(songId: 3, songImageName: "easyjazz", singer: "Easy Jazz")
        libraryList.append(l1)
        libraryList.append(l2)
        libraryList.append(l3)
        
        let a1 = Album(songId: 1, songImageName: "jazzclassic", singer: "Jazz Classic")
        let a2 = Album(songId: 2, songImageName: "karsuyakinda", singer: "Karsu")
        let a3 = Album(songId: 3, songImageName: "melikesahin", singer: "Melike Şahin")
        let a4 = Album(songId: 4, songImageName: "mutluturkcesarki", singer: "Mutlu türkçe şarkı")
        let a5 = Album(songId: 5, songImageName: "paintingplaylist", singer: "Painting Playlist")
        albumList.append(a1)
        albumList.append(a2)
        albumList.append(a3)
        albumList.append(a4)
        albumList.append(a5)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "LibraryCell", bundle: nil), forCellWithReuseIdentifier: "libraryCell")
        collectionView.register(UINib(nibName: "AlbumCell", bundle: nil), forCellWithReuseIdentifier: "albumCell")
        
        
        collectionView.register(UINib(nibName: "SectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "sectionHeader")
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)

        collectionView.collectionViewLayout = layout
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return libraryList.count
        }else if section == 1 {
            return albumList.count
        }else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            let library = libraryList[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "libraryCell", for: indexPath) as? LibraryCell else { return UICollectionViewCell() }
            cell.imgLibrary.image = UIImage(named: library.songImageName!)
            cell.lblLibrary.text = library.singer
            return cell
        } else if indexPath.section == 1 {
            let album = albumList[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as? AlbumCell else { return UICollectionViewCell() }
            cell.imgAlbum.image = UIImage(named: album.songImageName!)
            cell.lblAlbum.text = album.singer
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard  kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as? SectionHeader else {
            return UICollectionReusableView()
        }
        switch indexPath.section {
        case 1:
            cell.lblSectionHeader.text = "Kaldığın yerden devam et"
            return cell
        default:
            return cell
        }
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Her iki cell için de yüksekliğin farklı olmasını istediğim için indexPath'in section'una göre iki ayrı seçenek veriyorum.
        let gridLayout = collectionViewLayout as! UICollectionViewFlowLayout
        if indexPath.section == 0 {
            let widht = UIScreen.main.bounds.width
            let itemWidht = (widht - gridLayout.sectionInset.left - gridLayout.sectionInset.right - gridLayout.minimumInteritemSpacing) / 2
            return CGSize(width: itemWidht, height: 70)
        }else {
            let widht = UIScreen.main.bounds.width
            let itemWidht = (widht - gridLayout.sectionInset.left - gridLayout.sectionInset.right - gridLayout.minimumInteritemSpacing) / 2
            return CGSize(width: itemWidht, height: itemWidht * 1.35)
        }
    }
    //Header için yer oluşturma
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let gridLayout = collectionViewLayout as! UICollectionViewFlowLayout
        if section == 1 {
            let widht = UIScreen.main.bounds.width
            return CGSize(width: widht - gridLayout.sectionInset.left - gridLayout.sectionInset.right, height: 35)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
}
