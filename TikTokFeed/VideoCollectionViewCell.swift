//
//  VideoCollectionViewCell.swift
//  TikTokFeed
//
//  Created by Yusuke Mitsugi on 2020/07/18.
//  Copyright © 2020 Yusuke Mitsugi. All rights reserved.
//

import UIKit
import AVFoundation

protocol VideoCollectionViewCellDelegate: AnyObject {
    func didTapLikeButton(with model: VideoModel)
    func didTapProfileButton(with model: VideoModel)
    func didTapCommentButton(with model: VideoModel)
    func didTapShareButton(with model: VideoModel)
}

class VideoCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "VideoCollectionViewCell"
    //Labels
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    private let audioLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    //Buttons
    private let profileButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        return button
    }()
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        return button
    }()
    private let commentButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "text.bubble.fill"), for: .normal)
        return button
    }()
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for: .normal)
        return button
    }()
    
    private let videoContainer = UIView()
    
    //Delegate
    weak var delegate: VideoCollectionViewCellDelegate?
    
    //subviews
    var player: AVPlayer?
    
    private var model: VideoModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .red
        contentView.clipsToBounds = true
        addSubviews()
    }
    
    
    
    
    private func addSubviews() {
        contentView.addSubview(videoContainer)
        
        contentView.addSubview(userNameLabel)
        contentView.addSubview(captionLabel)
        contentView.addSubview(audioLabel)
        
        contentView.addSubview(likeButton)
        contentView.addSubview(profileButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(shareButton)
        //add Actions
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(didTapProfileButton), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        
         videoContainer.clipsToBounds = true
        contentView.sendSubviewToBack(videoContainer)
    }
    
    
    
    @objc private func didTapLikeButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapLikeButton(with: model)
    }
    @objc private func didTapCommentButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapCommentButton(with: model)
    }
    @objc private func didTapShareButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapShareButton(with: model)
    }
    @objc private func didTapProfileButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapProfileButton(with: model)
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        videoContainer.frame = contentView.bounds
        //Buttons
        let size = contentView.frame.size.width/7
        let width = contentView.frame.size.width
        let height = contentView.frame.size.height-100
        shareButton.frame = CGRect(x: width-size, y: height-size, width: size, height: size)
        commentButton.frame = CGRect(x: width-size, y: height-(size*2)-10, width: size, height: size)
        likeButton.frame = CGRect(x: width-size, y: height-(size*3)-10, width: size, height: size)
        profileButton.frame = CGRect(x: width-size, y: height-(size*4)-10, width: size, height: size)
        //Labels
        audioLabel.frame = CGRect(x: 5, y: height-30, width: width-size-10, height: 50)
        captionLabel.frame = CGRect(x: 5, y: height-80, width: width-size-10, height: 50)
        userNameLabel.frame = CGRect(x: 5, y: height-120, width: width-size-10, height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     override func prepareForReuse() {
        super.prepareForReuse()
        captionLabel.text = nil
        userNameLabel.text = nil
        audioLabel.text = nil
    }
    
    
    
    public func configure(with model: VideoModel) {
        self.model = model
        configureVideo()
        //Labels
        captionLabel.text = model.caption
        userNameLabel.text = model.userName
        audioLabel.text = model.audioTruckName
    }
    
    
    
    
    private func configureVideo() {
        guard let model = model else {
            return
        }
        guard let path = Bundle.main.path(forResource: model.videoFileName,
                                          ofType: model.videoFileFormat) else {
                                            print("ビデオが見れない")
                                            return
        }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerView = AVPlayerLayer()
        playerView.player = player
        playerView.frame = contentView.bounds
        playerView.videoGravity = .resizeAspectFill
        videoContainer.layer.addSublayer(playerView)
        player?.volume = 0
        player?.play()
    }
    
}
