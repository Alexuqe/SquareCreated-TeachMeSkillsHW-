    //
    //  ViewController.swift
    //  SquareCreated
    //
    //  Created by Sasha on 10.12.24.
    //

import UIKit

class ViewController: UIViewController {

    private let spacing: CGFloat = 5
    private var currentX: CGFloat = 0
    private var currentY: CGFloat = 0

    let button = UIButton()

    private let safeScreen: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        elementConfig()
    }

    func elementConfig() {
        configureButton()
        configureSafeScreen()
    }

    private func configureSafeScreen() {
        view.addSubview(safeScreen)
        constraintsSafeScreen()
    }

    private func configureButton() {
        var configure = UIButton.Configuration.filled()
        configure.title = "Tap Me"
        configure.baseBackgroundColor = .systemGray4
        configure.baseForegroundColor = .white
        configure.cornerStyle = .capsule
        configure.titleAlignment = .center

        button.configuration = configure
        button.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(button)
        constraintsButton()

        button.addTarget(self, action: #selector(createSquare), for: .touchUpInside)
    }

    @objc func createSquare() {
        let newView = UIView()
        newView.backgroundColor = .gray
        newView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newView)

        let safeAreaWidth = safeScreen.frame.width
        let safeAreaHeight = safeScreen.frame.height
        let squareSize = safeScreen.frame.width / 5

        if currentX + (squareSize + spacing) >= safeAreaWidth {
            currentX = 0
            currentY += squareSize + spacing
        }

        if currentY + (squareSize + spacing) > safeAreaHeight {
            return
        }

        NSLayoutConstraint.activate([
            newView.leadingAnchor.constraint(equalTo: safeScreen.leadingAnchor, constant: currentX),
            newView.topAnchor.constraint(equalTo: safeScreen.topAnchor, constant: currentY),
            newView.heightAnchor.constraint(equalToConstant: squareSize),
            newView.widthAnchor.constraint(equalToConstant: squareSize)
        ])

        currentX += squareSize + spacing
    }

    private func constraintsSafeScreen() {
        NSLayoutConstraint.activate([
            safeScreen.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            safeScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            safeScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            safeScreen.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -40)
        ])
    }


    private func constraintsButton() {
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 180),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }


}

#Preview {
    let view = ViewController()
    view
}

