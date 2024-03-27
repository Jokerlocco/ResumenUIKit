//
//  ViewController.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 13/3/24.
//

import UIKit

private let totalNumberOfLessonsToLoad = 8

class MainViewController: UIViewController {
    
    // Vamos a crear un índice súper básico y rápido para poder cargar las lecciones fácilmente, y ver su resultado:
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view = UIView()
        view.backgroundColor = .black
        view.addSubview(stackView)
        configureConstraints()
        createLessonButtonsAndAddThemToStackView()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func createLessonButtonsAndAddThemToStackView() {
        for lesson in 1...totalNumberOfLessonsToLoad {
            var configuration = UIButton.Configuration.borderedTinted()
            configuration.title = "Lección \(lesson)"
            configuration.baseForegroundColor = .systemYellow
            configuration.baseBackgroundColor = .systemRed
            let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
                self.presentLesson(lesson: lesson)
            }))
            button.tag = lesson
            stackView.addArrangedSubview(button)
        }
    }
    
    private func presentLesson(lesson: Int) {
        var viewControllerBase = UIViewController()
        
        switch(lesson) {
        case 1:
            viewControllerBase.view = L1IntroductionView()
        case 2:
            viewControllerBase.view = L2ButtonsView()
        case 3:
            viewControllerBase.view = L3UILabelView()
        case 4:
            viewControllerBase.view = L4UIImageViewView()
        case 5:
            viewControllerBase.view = TableOfDevices()
        case 6:
            viewControllerBase.view = L6UIStackView()
        case 7:
            viewControllerBase.view = CollectionOfDevices()
        case 8:
            viewControllerBase = ViewControllerA()
        default:
            viewControllerBase = UIViewController()
        }
        
        viewControllerBase.view.backgroundColor = .white
        present(viewControllerBase, animated: true)
    }
    
}

