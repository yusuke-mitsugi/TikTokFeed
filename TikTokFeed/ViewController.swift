//
//  ViewController.swift
//  TikTokFeed
//
//  Created by Yusuke Mitsugi on 2020/07/18.
//  Copyright © 2020 Yusuke Mitsugi. All rights reserved.
//

import UIKit

struct VideoModel {
    let caption: String
    let userName: String
    let audioTruckName: String
    let videoFileName: String
    let videoFileFormat: String
}

class ViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    private var data = [VideoModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0..<10 {
            let model = VideoModel(caption: "This is an animal",
                                   userName: "@sanJungle",
                                   audioTruckName: "animal video song",
                                   videoFileName: "start",
                                   videoFileFormat: "mov")
            data.append(model)
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        //マージン
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifire)
        collectionView?.isPagingEnabled = true
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
}



extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifire, for: indexPath) as! VideoCollectionViewCell
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
}


extension ViewController: VideoCollectionViewCellDelegate {
    func didTapLikeButton(with model: VideoModel) {
        print("like button tapped")
    }
    
    func didTapProfileButton(with model: VideoModel) {
        print("profile button tapped")
    }
    
    func didTapCommentButton(with model: VideoModel) {
        print("comment button tapped")
    }
    
    func didTapShareButton(with model: VideoModel) {
        print("share button tapped")
    }
}
