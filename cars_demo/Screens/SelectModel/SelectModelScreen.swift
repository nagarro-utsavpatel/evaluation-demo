//
//  SelectModelScreen.swift
//  cars_demo
//
//  Created by Utsav Patel on 16/02/2022.
//

import UIKit

class SelectModelScreen: UIViewController, Instantiable {
    // MARK: - implementation UI
    @IBOutlet private var modelListTable: UITableView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    var viewModel: ModelViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureProperties()
        configureLayout()
        configureReactiveBinding()
    }

    // MARK: 
    private func configureProperties() {
        modelListTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        navigationItem.title = "List of Models (\(viewModel.year))"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .automatic
    }

    private func configureLayout() {
        modelListTable.contentInset.bottom = view.safeAreaInsets.bottom
        modelListTable.delegate = self
        modelListTable.dataSource = self
        modelListTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    private func configureReactiveBinding() {
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }

        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.modelListTable.alpha = 0.0
                    })
                } else {
                    self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.modelListTable.alpha = 1.0
                    })
                }
            }
        }

        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.modelListTable.reloadData()
            }
        }

        viewModel.initFetch()
    }

    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel) { [weak self] _ in
            self?.viewModel.backToMake()
        })
        self.present(alert, animated: true, completion: nil)
    }
}

extension SelectModelScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "modelCell", for: indexPath) as? ModelCell else {
            return UITableViewCell()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ModelCell else {
            return
        }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.setup(model: cellVM)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.viewModel.userPressed(at: indexPath)
        return indexPath
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
