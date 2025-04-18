//
//  PageControlsVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class PageControlsVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

enum Pages: CaseIterable {
    case pageZero
    case pageOne
    case pageTwo
    case pageThree
    
    var name: String {
        switch self {
        case .pageZero:
            return "This is page zero"
        case .pageOne:
            return "This is page one"
        case .pageTwo:
            return "This is page two"
        case .pageThree:
            return "This is page three"
        }
    }
    
    var index: Int {
        switch self {
        case .pageZero:
            return 0
        case .pageOne:
            return 1
        case .pageTwo:
            return 2
        case .pageThree:
            return 3
        }
    }
}

class HorizontalPageVC: UIPageViewController, UIPageViewControllerDataSource {
    let pages: [Pages] = Pages.allCases
    var vcList: [UIViewController] = []
    private var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        self.setupViewControllers()
    }
    
    func setupViewControllers() {
        for index in 0..<pages.count {
            if let viewController = viewController(at: index) {
                vcList.append(viewController)
            }
        }
        if let initialViewController = vcList.first {
            setViewControllers([initialViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = vcList.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = currentIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        return vcList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = vcList.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = currentIndex + 1
        guard nextIndex < vcList.count else {
            return nil
        }
        return vcList[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
    
    func viewController(at index: Int) -> UIViewController? {
        let page = pages[index]
        let viewController = UIViewController()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 350, height: 300))
        label.text = page.name
        label.textAlignment = .center
        viewController.view.addSubview(label)
        switch page {
        case .pageZero:
            label.textColor = .white
            viewController.view.backgroundColor = .red
        case .pageOne:
            label.textColor = .white
            viewController.view.backgroundColor = .blue
        case .pageTwo:
            label.textColor = .black
            viewController.view.backgroundColor = .green
        case .pageThree:
            label.textColor = .black
            viewController.view.backgroundColor = .yellow
        }
        return viewController
    }
}

class VerticalPageVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    let pages: [Pages] = Pages.allCases
    var vcList: [UIViewController] = []
    private var currentIndex: Int = 0
    private var pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        setupViewControllers()
        setupPageControl()
    }

    func setupViewControllers() {
        for index in 0..<pages.count {
            if let viewController = viewController(at: index) {
                vcList.append(viewController)
            }
        }
        if let initialViewController = vcList.first {
            setViewControllers([initialViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    func setupPageControl() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = currentIndex
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        pageControl.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        pageControl.backgroundColor = .black
        NSLayoutConstraint.activate([
            pageControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 50)
        ])
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = vcList.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = currentIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        return vcList[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = vcList.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = currentIndex + 1
        guard nextIndex < vcList.count else {
            return nil
        }
        return vcList[nextIndex]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }

    func viewController(at index: Int) -> UIViewController? {
        let page = pages[index]
        let viewController = UIViewController()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 350, height: 300))
        label.text = page.name
        label.textAlignment = .center
        viewController.view.addSubview(label)
        switch page {
        case .pageZero:
            label.textColor = .white
            viewController.view.backgroundColor = .red
        case .pageOne:
            label.textColor = .white
            viewController.view.backgroundColor = .blue
        case .pageTwo:
            label.textColor = .black
            viewController.view.backgroundColor = .green
        case .pageThree:
            label.textColor = .black
            viewController.view.backgroundColor = .yellow
        }
        return viewController
    }

    // MARK: - UIPageViewControllerDelegate
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            // Update the current index when the transition to a new page is completed
            if let currentViewController = pageViewController.viewControllers?.first,
               let newIndex = vcList.firstIndex(of: currentViewController) {
                currentIndex = newIndex
                pageControl.currentPage = newIndex
            }
        }
    }
}
