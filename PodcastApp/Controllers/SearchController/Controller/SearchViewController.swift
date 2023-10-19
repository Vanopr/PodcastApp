//
//  SearchViewController.swift
//  PodcastApp
//
//  Created by Sergey on 25.09.2023.
//
import UIKit
import SnapKit
import PodcastIndexKit

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let podcastIndexKit = PodcastIndexKit()
    let searchCollectionView = SearchCollectionView()
    let searchView = SearchView()
    let searchResultView = SearchResultView()
    var categoriesArray: CategoriesResponse? {
        didSet {
            searchCollectionView.categoriesCollectionView.reloadData()
        }
    }
    
    private var podcasts: PodcastArrayResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.searchBar.delegate = self
        fetchData()
        setupBackgroundColor()
        setupSearch()
        setupView()
        searchCollectionView.seeAllButton.addTarget(self, action: #selector(seeAllAction), for: .touchUpInside)
        hideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupBackgroundColor() {
        view.backgroundColor = .white
        let gradientLayer = CAGradientLayer()
        let colors = [UIColor.redSearch, UIColor.hexadecimal]
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupView() {
        searchResultView.isHidden = true
        searchCollectionView.isHidden = false
        setupMainCollectionView()
        searchView.searchBar.text = nil
        navigationController?.navigationBar.isHidden = true
    }
    private func setupSearch() {
        view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(50)
        }
    }
    
    private func setupMainCollectionView() {
        view.addSubview(searchCollectionView)
        setupCollectionViewDelegate(searchCollectionView.genresCollectionView)
        setupCollectionViewDelegate(searchCollectionView.categoriesCollectionView)
        searchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom)
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    private func setupSearchResults() {
        view.addSubview(searchResultView)
        setupCollectionViewDelegate(searchResultView.collectionView)
        searchResultView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

    private func setupCollectionViewDelegate(_ collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func fetchData() {
        Task {
            do {
                let categories = try await podcastIndexKit.categoriesService.list()
                categoriesArray = categories
            } catch {
                print("Произошла ошибка: \(error)")
            }
        }
    }
    
    private func fetchDataForSearch(text: String) {
        Task {
            do {
                let data = try await podcastIndexKit.searchService.search(byTerm: text)
                podcasts = data
                searchResultView.collectionView.reloadData()
            } catch {
                print("Произошла ошибка: \(error)")
            }
        }
    }
    
    private func hideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func seeAllAction() {
        let vc = TopGenresViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true) // Этот метод скроет клавиатуру
    }
    
    @objc private func liked(sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: searchResultView.collectionView)
        if let indexPath = searchResultView.collectionView.indexPathForItem(at: point) {
            guard let id = podcasts?.feeds?[indexPath.row].id else { return }
            if  sender.tintColor == UIColor.gray {
                sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                sender.tintColor = UIColor.red
                LikedPodcast.shared.likedPodcasts.append(id)
                print(LikedPodcast.shared.likedPodcasts)
            } else {
                sender.setImage(UIImage(systemName: "heart"), for: .normal)
                sender.tintColor = UIColor.gray
                LikedPodcast.shared.likedPodcasts.removeAll{$0 == id}
                print(LikedPodcast.shared.likedPodcasts)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == searchCollectionView.genresCollectionView {
            return 10
        } else if collectionView == searchCollectionView.categoriesCollectionView {
            return categoriesArray?.count ?? 0
        } else {
            return podcasts?.feeds?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == searchCollectionView.genresCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
            cell.configure(with: TopGenresModel.topGenres[indexPath.row])
            return cell
        } else if collectionView == searchCollectionView.categoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
            cell.configure(with: categoriesArray?.feeds?[indexPath.row].name ?? "")
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PodcastCell", for: indexPath) as! PodcastCell
            let podcast = podcasts?.feeds?[indexPath.row]
            FetchImage.shared.loadImageFromURL(urlString: podcast?.image ?? "") { image in
                let resizedImage = FetchImage.resizeImage(image: image, targetSize: CGSize(width: 50, height: 50))
                DispatchQueue.main.async {
                    cell.setupPodcastCell(
                        titleLeft: podcast?.title ?? "",
                        titleRight: podcast?.author ?? "",
                        descriptionLeft: podcast?.categories?.values.joined(separator: " & ") ?? "",
                        descriptionRight: "Right",
                        image: resizedImage,
                        cellType: .podcast)
                    cell.checkmarkButton.addTarget(self, action: #selector(self.liked(sender:)), for: .touchUpInside)
                    cell.ifLiked(id: podcast?.id ?? 0)
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == searchResultView.collectionView {
            return CGSize(width: collectionView.layer.frame.width, height: 72)
        } else {
            let width = (view.frame.width - 64 - 10)/2
            let height = 0.57 * width
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == searchCollectionView.genresCollectionView {
            let viewController = GenreResultViewController()
            viewController.genre = TopGenresModel.topGenres[indexPath.row]
            navigationController?.pushViewController(viewController, animated: true)
        } else if collectionView == searchCollectionView.categoriesCollectionView {
            let viewController = AllTrandingsPodcasts()
            viewController.name =  categoriesArray?.feeds?[indexPath.row].name ?? ""
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            let podcast = podcasts?.feeds?[indexPath.row]
            let vc = ChannelViewController()
            vc.podcast = podcast
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchResultView.isHidden = true
            searchCollectionView.isHidden = false
            setupMainCollectionView()
        } else {
            searchCollectionView.isHidden = true
            searchResultView.isHidden = false
            setupSearchResults()
            fetchDataForSearch(text: searchText)
        }
    }
    
}
