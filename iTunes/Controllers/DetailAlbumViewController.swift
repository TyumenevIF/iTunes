//
//  DetailAlbumViewController.swift
//  iTunes
//
//  Created by Ilyas Tyumenev on 02.05.2022.
//

import UIKit

class DetailAlbumViewController: UIViewController {
    
    private var detailAlbumView: DetailAlbumView = {
        DetailAlbumView()
    }()

    var album: Album?
    var songs = [Song]()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupDelegate()
        setupModel()
        fetchSongs(album: album)
    }
    
    override func loadView() {
        self.view = detailAlbumView
    }
    
    private func configureViewController() {
        self.view.backgroundColor = .white
    }
    
    private func setupDelegate() {
        detailAlbumView.collectionView.delegate = self
        detailAlbumView.collectionView.dataSource = self
    }
    
    private func setupModel() {
        guard let album = album else { return }
        detailAlbumView.albumNameLabel.text = album.collectionName
        detailAlbumView.artistNameLabel.text = album.artistName
        detailAlbumView.trackCountLabel.text = "\(album.trackCount) track(s):"
        detailAlbumView.releaseDateLabel.text = setupDateFormat(date: album.releaseDate)
        
        guard let url = album.artworkUrl100 else { return }
        setupImage(urlString: url)
    }
    
    private func setupDateFormat(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        
        guard let backendDate = dateFormatter.date(from: date) else { return ""}
        
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd-MM-yyyy"
        let date = formatDate.string(from: backendDate)
        return date
    }
    
    private func setupImage(urlString: String?) {
        if let url = urlString {
            NetworkRequest.shared.requestData(urlString: url) { [weak self] result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    self?.detailAlbumView.albumLogo.image = image
                case .failure(let error):
                    self?.detailAlbumView.albumLogo.image = nil
                    print("No album logo" + error.localizedDescription)
                }
            }
        } else {
            detailAlbumView.albumLogo.image = nil
        }
    }
    
    private func fetchSongs(album: Album?) {
        guard let album = album else { return }
        let idAlbum = album.collectionId
        let urlString = "https://itunes.apple.com/lookup?id=\(idAlbum)&entity=song"
        
        NetworkDataFetch.shared.fetchSongs(urlString: urlString) { [weak self] (songModel, error) in
            if error == nil {
                guard let songModel = songModel else { return }
                self?.songs = songModel.results
                self?.detailAlbumView.collectionView.reloadData()
            } else {
                print(error?.localizedDescription as Any)
                self?.alert(title: "Error", message: error!.localizedDescription)
            }
        }
    }
}

// MARK: - CollectionView Delegate
extension DetailAlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SongsCollectionViewCell
        let song = songs[indexPath.row].trackName
        cell.nameSongLabel.text = song
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 20)
    }
}
