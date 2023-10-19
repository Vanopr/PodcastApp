//
//  MainViewController.swift
//  PodcastApp
//
//  Created by Sergey on 25.09.2023.
//

import UIKit
import PodcastIndexKit

class MainViewController: UIViewController {
    private let podcastIndexKit = PodcastIndexKit()
    private let mainCollectionView = MainCollection()
    private let mainProfileView = MainProfileView()
    private let mainSeeAllView = MainSeeAllView()
    private let categoryArray = AppCategoryModel.categoryNames
    private var podcasts: PodcastArrayResponse? {
        didSet {
            mainCollectionView.bottomVerticalCollectionView.reloadData()
        }
    }
    private var categoriesArray: CategoriesResponse? {
        didSet {
            mainCollectionView.topHorizontalCollectionView1.reloadData()
        }
    }
    
    private var combinedCategoriesArray: [PodcastArrayResponse]? {
        didSet {
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
        mainCollectionView.bottomVerticalCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fetchData()
        //        fetchDataForCombinedCategories()
        setupCollectionViewDelegate(mainCollectionView.topHorizontalCollectionView1)
        setupCollectionViewDelegate(mainCollectionView.topHorizontalCollectionView2)
        setupCollectionViewDelegate(mainCollectionView.bottomVerticalCollectionView)
        setupMainProfileView()
        setupMainSeeAllView()
        setupMainCollectionView()
        configureSeeAllButtons()
        makeFirstCellActive()
    }
    
    
    
    private func setupMainCollectionView() {
        view.addSubview(mainCollectionView)
        mainCollectionView.snp.makeConstraints { make in
            make.top.equalTo(mainSeeAllView.snp.bottom)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    private func setupMainProfileView() {
        view.addSubview(mainProfileView)
        mainProfileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(view).offset(32)
            make.trailing.equalTo(view).inset(32)
            make.height.equalTo(50)
        }
    }
    
    private func setupMainSeeAllView() {
        view.addSubview(mainSeeAllView)
        mainSeeAllView.snp.makeConstraints { make in
            make.top.equalTo(mainProfileView.snp.bottom).offset(35)
            make.leading.equalTo(view).offset(32)
            make.trailing.equalTo(view).inset(32)
            make.height.equalTo(44)
        }
    }
    
    
    private func configureSeeAllButtons() {
        mainSeeAllView.seeAllButton.addTarget(self, action: #selector(seeAllButtonWasTapped), for: .touchUpInside)
    }
    
    @objc func seeAllButtonWasTapped() {
        let viewController = AllCategoriesController()
        viewController.categoriesArray = categoriesArray
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private  func setupCollectionViewDelegate(_ collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    private func fetchData() {
        Task {
            do {
                //MARK: - Cписок категорий
                let categories = try await podcastIndexKit.categoriesService.list()
                //MARK: - Популярные по подкасты
                let popular = try await podcastIndexKit.podcastsService.trendingPodcasts()
                categoriesArray = categories
                podcasts = popular
            } catch {
                print("Произошла ошибка: \(error)")
            }
        }
    }
    
    private func fetchDataForSelected(name: String) {
        Task {
            do {
                if name == categoryArray[0] {
                    let data = try await podcastIndexKit.podcastsService.trendingPodcasts()
                    podcasts = data
                } else if name == categoryArray[1] {
                    let data = try await podcastIndexKit.recentService.recentFeeds(max: 20)
                    podcasts = data
                } else {
                    //MARK: - Недавние Подкасты
                    let data = try await podcastIndexKit.podcastsService.trendingPodcasts(cat: name)
                    podcasts = data
                }
            } catch {
                print("Произошла ошибка: \(error)")
            }
        }
    }
    //Получение сколько подкастов в комбинированных категориях: Всегда 40!
    //    private func fetchDataForCombinedCategories() {
    //        var array: [PodcastArrayResponse] = []
    //        for i in 0...AppCategoryModel.combinedCategories.count - 1 {
    //            Task {
    //                do {
    //                    let nameArray = AppCategoryModel.splitCategories()
    //                    let data = try await podcastIndexKit.podcastsService.trendingPodcasts(cat: nameArray[i])
    //                    array.append(data)
    //                    combinedCategoriesArray = array
    //                } catch {
    //                    print("Произошла ошибка: \(error)")
    //                }
    //            }
    //        }
    //            mainCollectionView.topHorizontalCollectionView1.reloadData()
    //    }
    
    @objc private func liked(sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: mainCollectionView.bottomVerticalCollectionView)
        if let indexPath = mainCollectionView.bottomVerticalCollectionView.indexPathForItem(at: point) {
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
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainCollectionView.bottomVerticalCollectionView {
            return podcasts?.feeds?.count ?? 1
        } else {
            return 11
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainCollectionView.topHorizontalCollectionView1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            let imageName = AppCategoryModel.combinedCategoriesImages[indexPath.row]
            let combinedCategoryName = AppCategoryModel.combinedCategories[indexPath.row]
            cell.setupCategoryCell(
                topLbl: combinedCategoryName,
                //                bottomLbl: combinedCategoriesArray?[indexPath.row].feeds?.count ?? 0,
                bottomLbl: 40,
                image: UIImage(named: imageName))
            
            if indexPath.row % 2 == 0 {
                cell.layer.backgroundColor = UIColor.palePink.withAlphaComponent(0.5).cgColor
            } else {
                cell.layer.backgroundColor = UIColor.ghostWhite.withAlphaComponent(0.5).cgColor
            }
            return cell
        } else if collectionView == mainCollectionView.topHorizontalCollectionView2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryNameCell", for: indexPath) as! CategoryNameCell
            let name = categoryArray[indexPath.row]
            cell.setupCategoryNameCell(with: name)
            return cell
        } else if collectionView == mainCollectionView.bottomVerticalCollectionView {
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
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == mainCollectionView.topHorizontalCollectionView1 {
            return CGSize(width: 144, height: 200)
        } else if collectionView == mainCollectionView.topHorizontalCollectionView2 {
            let text = AppCategoryModel.categoryNames[indexPath.row]
            let cellWidth = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)]).width + 40
            return CGSize(width: cellWidth, height: 44)
        } else if collectionView == mainCollectionView.bottomVerticalCollectionView {
            return CGSize(width: collectionView.layer.frame.width, height: 72)
        }
        return CGSize(width: 144, height: 72)
    }
    
    func makeFirstCellActive() {
        let firstIndexPath = IndexPath(item: 0, section: 0)
        mainCollectionView.topHorizontalCollectionView2.selectItem(at: firstIndexPath, animated: false, scrollPosition: .centeredHorizontally)
    }
    ////     Отступы с лева, c ними консоль ругается...
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        if collectionView == mainCollectionView.bottomVerticalCollectionView {
    //            return UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
    //        } else {
    //            return UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
    //        }
    //    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == mainCollectionView.topHorizontalCollectionView2 {
            fetchDataForSelected(name: categoryArray[indexPath.row])
        } else if collectionView == mainCollectionView.topHorizontalCollectionView1 {
            let viewController = AllTrandingsPodcasts()
            let categoryArray = AppCategoryModel.splitCategories()
            viewController.name = categoryArray[indexPath.row]
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            let podcast = podcasts?.feeds?[indexPath.row]
            let vc = ChannelViewController()
            vc.podcast = podcast
            self.navigationController?.pushViewController(vc, animated: true)

        }
    }
}
