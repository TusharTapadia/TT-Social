//
//  TwitterCollectionViewCell.swift
//  uicollectionview
//
//  Created by Tushar Tapadia on 12/08/20.
//  Copyright © 2020 Tushar Tapadia. All rights reserved.
//

import Foundation
import UIKit


class UpcomingEventsCollectionViewCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private let cellId = "cellID"
    weak var socialViewController: SocialViewController?

    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Upcoming Events"
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.textColor = .white
        return label
    }()
    
    lazy var eventsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(TwitterCell.self, forCellWithReuseIdentifier: cellId)
        return cv
    }()
    
    lazy var seperatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TwitterCell
        cell.imageView = UIImageView(image: UIImage(named: "logo"))
        cell.eventName.text = "Twitter"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: frame.height - 44)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        socialViewController?.presentImage(event: upcomingEvents[indexPath.item])
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if #available(iOS 13.0, *) {
            eventsCollectionView.backgroundColor = .systemBackground
            seperatorLineView.backgroundColor = .quaternaryLabel
        }
        setupLayout()
    }
    
    fileprivate func setupLayout(){
        addSubview(titleLabel)
        titleLabel.anchorWithConstants(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        addSubview(eventsCollectionView)
        eventsCollectionView.anchorWithConstants(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
        addSubview(seperatorLineView)
        _ = seperatorLineView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.7)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    @objc func fetchUpcomingEvents() {
//        ref = Database.database().reference()
//        ref?.child("Upcoming Events").observe(.childAdded, with: { (snapshot) in
//            var event = UpcomingEvent()
//            let imageName = snapshot.childSnapshot(forPath: "Image Url").value as? String
//            if let actualImageName = imageName {
//                event.imageUrl = actualImageName
//            }
//            let name = snapshot.childSnapshot(forPath: "Name").value as? String
//            if let actualName = name {
//                event.name = actualName
//            }
//            let desc = snapshot.childSnapshot(forPath: "eventDescription").value as? String
//            if let actualDesc = desc {
//                event.eventDescription = actualDesc
//            }
//            let location = snapshot.childSnapshot(forPath: "eventLocation").value as? String
//            if let actualLocation = location {
//                event.eventLocation = actualLocation
//            }
//            let phone = snapshot.childSnapshot(forPath: "eventPhone").value as? String
//            if let actualPhone = phone {
//                print(actualPhone)
//                event.eventPhone = actualPhone
//            }
//            let url = snapshot.childSnapshot(forPath: "eventUrl").value as? String
//            if let actualurl = url {
//                event.eventLink = actualurl
//            }
//            self.upcomingEvents.insert(event, at: 0)
//            self.eventsCollectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
//            self.checkEmpty()
//        })
//
//        ref?.child("Upcoming Events").observe(.childRemoved, with: { (snapshot) in
//            if let name = snapshot.childSnapshot(forPath: "Name").value as? String {
//                for x in 0..<self.upcomingEvents.count{
//                    if self.upcomingEvents[x].name == name{
//                        self.upcomingEvents.remove(at: x)
//                        self.eventsCollectionView.deleteItems(at: [IndexPath(item: x, section: 0)])
//                        self.checkEmpty()
//                        break
//                    }
//                }
//            }
//        })
//
//        ref?.child("Upcoming Events").observe(.childChanged, with: { (snapshot) in
//            if let newImage = snapshot.childSnapshot(forPath: "Image Url").value as? String, let newName = snapshot.childSnapshot(forPath: "Name").value as? String{
//                for x in 0..<self.upcomingEvents.count{
//                    if self.upcomingEvents[x].imageUrl == newImage{
//                        self.upcomingEvents[x].name = newName
//                        self.eventsCollectionView.reloadItems(at: [IndexPath(item: x, section: 0)])
//                        break
//                    }else if self.upcomingEvents[x].name == newName{
//                        self.upcomingEvents[x].imageUrl = newImage
//                        self.eventsCollectionView.reloadItems(at: [IndexPath(item: x, section: 0)])
//                        break
//                    }
//                }
//            }
//        })
//    }
//
//    func checkEmpty(){
//        if self.upcomingEvents.count == 0{
//            let view = UIView()
//            let label = UILabel()
//            label.text = "No Upcoming Events."
//            label.font = UIFont.boldSystemFont(ofSize: 14)
//            label.textColor = .lightGray
//            label.textAlignment = .center
//            view.addSubview(label)
//            label.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
//            self.eventsCollectionView.backgroundView = view
//            return
//        }else{
//            self.eventsCollectionView.backgroundView = nil
//        }
//    }
//}
//
//extension UpcomingEventsCollectionViewCell: Themed {
//
//    func applyTheme(_ theme: AppTheme) {
//        eventsCollectionView.backgroundColor = theme.backgroundColor
//        titleLabel.textColor = theme.titleTextColor
//        seperatorLineView.backgroundColor = theme.separatorColor
//    }
//}
}
