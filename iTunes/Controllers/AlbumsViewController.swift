//
//  AlbumsViewController.swift
//  iTunes
//
//  Created by Ilyas Tyumenev on 01.05.2022.
//

import UIKit

class AlbumsViewController: UIViewController {
    
    private var albumsView: AlbumsView = {
        AlbumsView()
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    var albums = [Album]()
    var timer: Timer?

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupDelegate()
        setupNavigationBar()
        setupSearchController()
    }
    
    override func loadView() {
        self.view = albumsView
    }
    
    private func configureViewController() {
        self.view.backgroundColor = .white
    }
    
    private func setupDelegate() {
        albumsView.tableView.delegate = self
        albumsView.tableView.dataSource = self
        searchController.searchBar.delegate = self
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Albums"
        navigationItem.searchController = searchController
        let userInfoButton = createCustomButton(selector: #selector(userInfoButtonTapped))
        navigationItem.rightBarButtonItem = userInfoButton
    }
    
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    @objc private func userInfoButtonTapped() {
        let userInfoViewController = UserInfoViewController()
        navigationController?.pushViewController(userInfoViewController, animated: true)
    }
    
    private func fetchAlbums(albumName: String) {

        let urlString = "https://itunes.apple.com/search?term=\(albumName)&entity=album&attribute=albumTerm"

        NetworkDataFetch.shared.fetchAlbum(urlString: urlString) { [weak self] (albumModel, error) in
            if error == nil {
                guard let albumModel = albumModel else { return }
                if albumModel.results != [] {
                    let sortedAlbums = albumModel.results.sorted { firstItem, secondItem in
                        return firstItem.collectionName.compare(secondItem.collectionName) == ComparisonResult.orderedAscending
                    }
                    self?.albums = sortedAlbums
                    self?.albumsView.tableView.reloadData()
                } else {
                    self?.alert(title: "Error", message: "Album not found. Add some words.")
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension AlbumsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumsTableViewCell
        let album = albums[indexPath.row]
        cell.configureAlbumCell(album: album)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AlbumsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailAlbumViewController = DetailAlbumViewController()
        let album = albums[indexPath.row]
        detailAlbumViewController.album = album
        detailAlbumViewController.title = album.artistName
        navigationController?.pushViewController(detailAlbumViewController, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension AlbumsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        if text != "" {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                self?.fetchAlbums(albumName: text!)
            })
        }
    }
}
