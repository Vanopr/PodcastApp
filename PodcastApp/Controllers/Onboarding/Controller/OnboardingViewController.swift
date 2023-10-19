//
//  OnboardingViewController.swift
//  PodcastApp
//
//  Created by Aleksandr Garipov on 27.09.2023.
//
import UIKit

class OnboardingViewController: UIPageViewController {
    
    //MARK: - Properties
    
    let pageControllers = [PageViewController(pageType: .first),
                           PageViewController(pageType: .second),
                           PageViewController(pageType: .last),]
    
    //MARK: - UI Elements
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageControllers.count
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    //MARK: - Life Cycle
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingPageViewController()
        view.addSubview(pageControl)
        setupLayout()
    }
    
    //MARK: - Methods
    
    private func settingPageViewController() {
        dataSource = self
        delegate = self
        guard let firstVC = pageControllers.first else { return }
        setViewControllers([firstVC], direction: .forward, animated: true)
    }
    
    private func setupLayout() {
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
        }
    }
    
    private func updatePageControl(toPageIndex pageIndex: Int) {
        pageControl.currentPage = pageIndex
    }
    
    //MARK: - Actions
    
    func scrollNextViewController() {
        if let currentViewController = self.viewControllers?.first,
           let currentIndex = pageControllers.firstIndex(of: currentViewController as! PageViewController) {
            var nextIndex = currentIndex + 1
            if nextIndex > pageControllers.count - 1 {
                nextIndex = 0
            }
            let nextPageController = pageControllers[nextIndex]
            self.setViewControllers([nextPageController], direction: .forward, animated: true)
            updatePageControl(toPageIndex: nextIndex)
        }
    }
}

//MARK: - UIPageViewControllerDataSource

extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pageControllers.firstIndex(of: viewController as! PageViewController) else { return nil }
        
        let nextIndex = currentIndex + 1
        if nextIndex < pageControllers.count {
            return pageControllers[nextIndex]
        } else {
            return pageControllers[0]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pageControllers.firstIndex(of: viewController as! PageViewController) else { return nil }
        let previousIndex = currentIndex - 1
        if previousIndex >= 0 {
            return pageControllers[previousIndex]
        } else {
            return pageControllers[pageControllers.count - 1]
        }
    }
}

//MARK: - UIPageViewControllerDelegate

extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed,
            let currentViewController = pageViewController.viewControllers?.first,
           let currentIndex = pageControllers.firstIndex(of: currentViewController as! PageViewController) {
            pageControl.currentPage = currentIndex
        }
    }
}
