//
//  SocialController.swift
//  uicollectionview
//
//  Created by Tushar Tapadia on 12/08/20.
//  Copyright © 2020 Tushar Tapadia. All rights reserved.
//

import UIKit


class SocialViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    fileprivate let youtubeCellId = "youtubeCellId"
    fileprivate let instagramCellId = "instagramCellId"
    fileprivate let upcomingEventsCellId = "upcomingEventsCellId"
   
    

    
 
    override func viewDidLoad() {
        super.viewDidLoad()
       
      
        setupCollectionView()
       
//        }
    }
    
    
    
    
    
    
    fileprivate func setupCollectionView(){
//        refreshControl.addTarget(self, action: #selector(refreshSocial), for: UIControl.Event.valueChanged)
//        collectionView.refreshControl = refreshControl
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(YoutubeCollectionViewCell.self, forCellWithReuseIdentifier: youtubeCellId)
        collectionView.register(InstagramCollectionViewCell.self, forCellWithReuseIdentifier: instagramCellId)
        collectionView.register(UpcomingEventsCollectionViewCell.self, forCellWithReuseIdentifier: upcomingEventsCellId)
        
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: upcomingEventsCellId, for: indexPath) as! UpcomingEventsCollectionViewCell
            cell.socialViewController = self
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: instagramCellId, for: indexPath) as! InstagramCollectionViewCell
            cell.socialViewController = self
          
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: youtubeCellId, for: indexPath) as! YoutubeCollectionViewCell
            cell.socialViewController = self
           
            return cell
        default:
            return UICollectionViewCell()
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item{
        case 0:
            return CGSize(width: view.frame.width, height: 250)
        case 1:
            return CGSize(width: view.frame.width, height: 305)
        case 2:
            return CGSize(width: view.frame.width, height: 180)
        default:
            return CGSize(width: view.frame.width, height: 200)
        }
    }
}
