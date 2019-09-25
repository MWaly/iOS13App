//
//  ListRouter.swift
//
//  Responsible for Navigation decisions and prepartions of different controllers

import Foundation
import UIKit

final class ListRouter {
    
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let interactor: ListInteractorInput
    var presenter: ListPresenterInput
    
    lazy var controller: ListViewController = {
        let identifier = String(describing: ListViewController.self)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! ListViewController
        presenter.router = self
        viewController.presenter = presenter
        return viewController
    }()
    
    public init(interactor: ListInteractorInput = ListInteractor()) {
        self.interactor = interactor
        self.presenter = ListPresenter(interactor: interactor)

    }
    
}

