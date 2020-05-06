// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

@testable import Magellan













class DashboardMapCoordinatorProtocolMock: DashboardMapCoordinatorProtocol {
    var presenter: DashboardMapPresenterProtocol?

}
// MARK: -
// MARK: -
class DashboardMapViewProtocolMock: DashboardMapViewProtocol {
    var presenter: DashboardMapPresenterProtocol {
        get { return underlyingPresenter }
        set(value) { underlyingPresenter = value }
    }
    var underlyingPresenter: DashboardMapPresenterProtocol!
    var isSetup: Bool {
        get { return underlyingIsSetup }
        set(value) { underlyingIsSetup = value }
    }
    var underlyingIsSetup: Bool!
    var controller: UIViewController {
        get { return underlyingController }
        set(value) { underlyingController = value }
    }
    var underlyingController: UIViewController!
    var loadingPresenter: UIViewController?

    //MARK: - showLoading

    var showLoadingCallsCount = 0
    var showLoadingCalled: Bool {
        return showLoadingCallsCount > 0
    }
    var showLoadingClosure: (() -> Void)?

    func showLoading() {
        showLoadingCallsCount += 1
        showLoadingClosure?()
    }

    //MARK: - hideLoading

    var hideLoadingCallsCount = 0
    var hideLoadingCalled: Bool {
        return hideLoadingCallsCount > 0
    }
    var hideLoadingClosure: (() -> Void)?

    func hideLoading() {
        hideLoadingCallsCount += 1
        hideLoadingClosure?()
    }

}
// MARK: -
// MARK: -
class LocationDetailsPresenterDelegateMock: LocationDetailsPresenterDelegate {

    //MARK: - dismiss

    var dismissCallsCount = 0
    var dismissCalled: Bool {
        return dismissCallsCount > 0
    }
    var dismissClosure: (() -> Void)?

    func dismiss() {
        dismissCallsCount += 1
        dismissClosure?()
    }

}
// MARK: -
// MARK: -
class MagellanServicePrototcolMock: MagellanServicePrototcol {

    //MARK: - getCategories

    var getCategoriesRunCompletionInCompletionCallsCount = 0
    var getCategoriesRunCompletionInCompletionCalled: Bool {
        return getCategoriesRunCompletionInCompletionCallsCount > 0
    }
    var getCategoriesRunCompletionInCompletionReceivedArguments: (queue: DispatchQueue, completion: CategoriesCompletionBlock)?
    var getCategoriesRunCompletionInCompletionReturnValue: Operation!
    var getCategoriesRunCompletionInCompletionClosure: ((DispatchQueue, @escaping CategoriesCompletionBlock) -> Operation)?

    func getCategories(runCompletionIn queue: DispatchQueue, completion: @escaping CategoriesCompletionBlock) -> Operation {
        getCategoriesRunCompletionInCompletionCallsCount += 1
        getCategoriesRunCompletionInCompletionReceivedArguments = (queue: queue, completion: completion)
        return getCategoriesRunCompletionInCompletionClosure.map({ $0(queue, completion) }) ?? getCategoriesRunCompletionInCompletionReturnValue
    }

    //MARK: - getPlace

    var getPlaceWithRunCompletionInCompletionCallsCount = 0
    var getPlaceWithRunCompletionInCompletionCalled: Bool {
        return getPlaceWithRunCompletionInCompletionCallsCount > 0
    }
    var getPlaceWithRunCompletionInCompletionReceivedArguments: (placeId: Int, queue: DispatchQueue, completion: PlaceInfoCompletionBlock)?
    var getPlaceWithRunCompletionInCompletionReturnValue: Operation!
    var getPlaceWithRunCompletionInCompletionClosure: ((Int, DispatchQueue, @escaping PlaceInfoCompletionBlock) -> Operation)?

    func getPlace(with placeId: Int, runCompletionIn queue: DispatchQueue, completion: @escaping PlaceInfoCompletionBlock) -> Operation {
        getPlaceWithRunCompletionInCompletionCallsCount += 1
        getPlaceWithRunCompletionInCompletionReceivedArguments = (placeId: placeId, queue: queue, completion: completion)
        return getPlaceWithRunCompletionInCompletionClosure.map({ $0(placeId, queue, completion) }) ?? getPlaceWithRunCompletionInCompletionReturnValue
    }

    //MARK: - getPlaces

    var getPlacesWithRunCompletionInCompletionCallsCount = 0
    var getPlacesWithRunCompletionInCompletionCalled: Bool {
        return getPlacesWithRunCompletionInCompletionCallsCount > 0
    }
    var getPlacesWithRunCompletionInCompletionReceivedArguments: (request: PlacesRequest, queue: DispatchQueue, completion: PlacesCompletionBlock)?
    var getPlacesWithRunCompletionInCompletionReturnValue: Operation!
    var getPlacesWithRunCompletionInCompletionClosure: ((PlacesRequest, DispatchQueue, @escaping PlacesCompletionBlock) -> Operation)?

    func getPlaces(with request: PlacesRequest, runCompletionIn queue: DispatchQueue, completion: @escaping PlacesCompletionBlock) -> Operation {
        getPlacesWithRunCompletionInCompletionCallsCount += 1
        getPlacesWithRunCompletionInCompletionReceivedArguments = (request: request, queue: queue, completion: completion)
        return getPlacesWithRunCompletionInCompletionClosure.map({ $0(request, queue, completion) }) ?? getPlacesWithRunCompletionInCompletionReturnValue
    }

}
// MARK: -
// MARK: -
class MapCoordinatorProtocolMock: MapCoordinatorProtocol {

    //MARK: - showDetails

    var showDetailsForCallsCount = 0
    var showDetailsForCalled: Bool {
        return showDetailsForCallsCount > 0
    }
    var showDetailsForReceivedPlaceInfo: PlaceInfo?
    var showDetailsForClosure: ((PlaceInfo) -> Void)?

    func showDetails(for placeInfo: PlaceInfo) {
        showDetailsForCallsCount += 1
        showDetailsForReceivedPlaceInfo = placeInfo
        showDetailsForClosure?(placeInfo)
    }

}
// MARK: -
// MARK: -
class MapListPresenterProtocolMock: MapListPresenterProtocol {
    var categories: [PlaceCategory] = []
    var places: [PlaceViewModel] = []
    var view: MapListViewProtocol?
    var output: MapListOutputProtocol?
    var delegate: MapListPresenterDelegate?

    //MARK: - showDetails

    var showDetailsPlaceCallsCount = 0
    var showDetailsPlaceCalled: Bool {
        return showDetailsPlaceCallsCount > 0
    }
    var showDetailsPlaceReceivedPlace: PlaceViewModel?
    var showDetailsPlaceClosure: ((PlaceViewModel) -> Void)?

    func showDetails(place: PlaceViewModel) {
        showDetailsPlaceCallsCount += 1
        showDetailsPlaceReceivedPlace = place
        showDetailsPlaceClosure?(place)
    }

    //MARK: - select

    var selectCategoryCallsCount = 0
    var selectCategoryCalled: Bool {
        return selectCategoryCallsCount > 0
    }
    var selectCategoryReceivedCategory: String?
    var selectCategoryClosure: ((String) -> Void)?

    func select(category: String) {
        selectCategoryCallsCount += 1
        selectCategoryReceivedCategory = category
        selectCategoryClosure?(category)
    }

    //MARK: - search

    var searchWithCallsCount = 0
    var searchWithCalled: Bool {
        return searchWithCallsCount > 0
    }
    var searchWithReceivedText: String?
    var searchWithClosure: ((String) -> Void)?

    func search(with text: String) {
        searchWithCallsCount += 1
        searchWithReceivedText = text
        searchWithClosure?(text)
    }

    //MARK: - dismiss

    var dismissCallsCount = 0
    var dismissCalled: Bool {
        return dismissCallsCount > 0
    }
    var dismissClosure: (() -> Void)?

    func dismiss() {
        dismissCallsCount += 1
        dismissClosure?()
    }

    //MARK: - expand

    var expandCallsCount = 0
    var expandCalled: Bool {
        return expandCallsCount > 0
    }
    var expandClosure: (() -> Void)?

    func expand() {
        expandCallsCount += 1
        expandClosure?()
    }

    //MARK: - didUpdate

    var didUpdateCategoriesCallsCount = 0
    var didUpdateCategoriesCalled: Bool {
        return didUpdateCategoriesCallsCount > 0
    }
    var didUpdateCategoriesReceivedCategories: [PlaceCategory]?
    var didUpdateCategoriesClosure: (([PlaceCategory]) -> Void)?

    func didUpdate(categories: [PlaceCategory]) {
        didUpdateCategoriesCallsCount += 1
        didUpdateCategoriesReceivedCategories = categories
        didUpdateCategoriesClosure?(categories)
    }

    //MARK: - didUpdate

    var didUpdatePlacesCallsCount = 0
    var didUpdatePlacesCalled: Bool {
        return didUpdatePlacesCallsCount > 0
    }
    var didUpdatePlacesReceivedPlaces: [PlaceViewModel]?
    var didUpdatePlacesClosure: (([PlaceViewModel]) -> Void)?

    func didUpdate(places: [PlaceViewModel]) {
        didUpdatePlacesCallsCount += 1
        didUpdatePlacesReceivedPlaces = places
        didUpdatePlacesClosure?(places)
    }

    //MARK: - loadingComplete

    var loadingCompleteWithRetryClosureCallsCount = 0
    var loadingCompleteWithRetryClosureCalled: Bool {
        return loadingCompleteWithRetryClosureCallsCount > 0
    }
    var loadingCompleteWithRetryClosureReceivedArguments: (error: Error?, retryClosure: () -> Void)?
    var loadingCompleteWithRetryClosureClosure: ((Error?, @escaping () -> Void) -> Void)?

    func loadingComplete(with error: Error?, retryClosure: @escaping () -> Void) {
        loadingCompleteWithRetryClosureCallsCount += 1
        loadingCompleteWithRetryClosureReceivedArguments = (error: error, retryClosure: retryClosure)
        loadingCompleteWithRetryClosureClosure?(error, retryClosure)
    }

}
// MARK: -
// MARK: -
class MapListViewProtocolMock: MapListViewProtocol {
    var presenter: MapListPresenterProtocol {
        get { return underlyingPresenter }
        set(value) { underlyingPresenter = value }
    }
    var underlyingPresenter: MapListPresenterProtocol!
    var isSetup: Bool {
        get { return underlyingIsSetup }
        set(value) { underlyingIsSetup = value }
    }
    var underlyingIsSetup: Bool!
    var controller: UIViewController {
        get { return underlyingController }
        set(value) { underlyingController = value }
    }
    var underlyingController: UIViewController!

    //MARK: - reloadPlaces

    var reloadPlacesCallsCount = 0
    var reloadPlacesCalled: Bool {
        return reloadPlacesCallsCount > 0
    }
    var reloadPlacesClosure: (() -> Void)?

    func reloadPlaces() {
        reloadPlacesCallsCount += 1
        reloadPlacesClosure?()
    }

    //MARK: - reloadCategories

    var reloadCategoriesCallsCount = 0
    var reloadCategoriesCalled: Bool {
        return reloadCategoriesCallsCount > 0
    }
    var reloadCategoriesClosure: (() -> Void)?

    func reloadCategories() {
        reloadCategoriesCallsCount += 1
        reloadCategoriesClosure?()
    }

    //MARK: - showErrorState

    var showErrorStateCallsCount = 0
    var showErrorStateCalled: Bool {
        return showErrorStateCallsCount > 0
    }
    var showErrorStateReceivedRetryClosure: (() -> Void)?
    var showErrorStateClosure: ((@escaping () -> Void) -> Void)?

    func showErrorState(_ retryClosure: @escaping () -> Void) {
        showErrorStateCallsCount += 1
        showErrorStateReceivedRetryClosure = retryClosure
        showErrorStateClosure?(retryClosure)
    }

}
// MARK: -
// MARK: -
class MapPresenterProtocolMock: MapPresenterProtocol {
    var view: MapViewProtocol?
    var coordinator: MapCoordinatorProtocol?
    var output: MapOutputProtocol?
    var categories: [PlaceCategory] = []
    var places: [PlaceViewModel] = []
    var position: Coordinates {
        get { return underlyingPosition }
        set(value) { underlyingPosition = value }
    }
    var underlyingPosition: Coordinates!

    //MARK: - showDetails

    var showDetailsPlaceCallsCount = 0
    var showDetailsPlaceCalled: Bool {
        return showDetailsPlaceCallsCount > 0
    }
    var showDetailsPlaceReceivedPlace: PlaceViewModel?
    var showDetailsPlaceClosure: ((PlaceViewModel) -> Void)?

    func showDetails(place: PlaceViewModel) {
        showDetailsPlaceCallsCount += 1
        showDetailsPlaceReceivedPlace = place
        showDetailsPlaceClosure?(place)
    }

    //MARK: - load

    var loadCallsCount = 0
    var loadCalled: Bool {
        return loadCallsCount > 0
    }
    var loadClosure: (() -> Void)?

    func load() {
        loadCallsCount += 1
        loadClosure?()
    }

    //MARK: - select

    var selectPlaceCallsCount = 0
    var selectPlaceCalled: Bool {
        return selectPlaceCallsCount > 0
    }
    var selectPlaceReceivedPlace: PlaceViewModel?
    var selectPlaceClosure: ((PlaceViewModel) -> Void)?

    func select(place: PlaceViewModel) {
        selectPlaceCallsCount += 1
        selectPlaceReceivedPlace = place
        selectPlaceClosure?(place)
    }

    //MARK: - select

    var selectCategoryCallsCount = 0
    var selectCategoryCalled: Bool {
        return selectCategoryCallsCount > 0
    }
    var selectCategoryReceivedCategory: String?
    var selectCategoryClosure: ((String) -> Void)?

    func select(category: String) {
        selectCategoryCallsCount += 1
        selectCategoryReceivedCategory = category
        selectCategoryClosure?(category)
    }

    //MARK: - search

    var searchWithCallsCount = 0
    var searchWithCalled: Bool {
        return searchWithCallsCount > 0
    }
    var searchWithReceivedText: String?
    var searchWithClosure: ((String) -> Void)?

    func search(with text: String) {
        searchWithCallsCount += 1
        searchWithReceivedText = text
        searchWithClosure?(text)
    }

    //MARK: - reset

    var resetCallsCount = 0
    var resetCalled: Bool {
        return resetCallsCount > 0
    }
    var resetClosure: (() -> Void)?

    func reset() {
        resetCallsCount += 1
        resetClosure?()
    }

}
// MARK: -
// MARK: -
class MapViewProtocolMock: MapViewProtocol {
    var presenter: MapPresenterProtocol {
        get { return underlyingPresenter }
        set(value) { underlyingPresenter = value }
    }
    var underlyingPresenter: MapPresenterProtocol!
    var contentView: UIView {
        get { return underlyingContentView }
        set(value) { underlyingContentView = value }
    }
    var underlyingContentView: UIView!
    var contentInsets: UIEdgeInsets {
        get { return underlyingContentInsets }
        set(value) { underlyingContentInsets = value }
    }
    var underlyingContentInsets: UIEdgeInsets!
    var preferredContentHeight: CGFloat {
        get { return underlyingPreferredContentHeight }
        set(value) { underlyingPreferredContentHeight = value }
    }
    var underlyingPreferredContentHeight: CGFloat!
    var observable: ViewModelObserverContainer<ContainableObserver> {
        get { return underlyingObservable }
        set(value) { underlyingObservable = value }
    }
    var underlyingObservable: ViewModelObserverContainer<ContainableObserver>!
    var isSetup: Bool {
        get { return underlyingIsSetup }
        set(value) { underlyingIsSetup = value }
    }
    var underlyingIsSetup: Bool!
    var controller: UIViewController {
        get { return underlyingController }
        set(value) { underlyingController = value }
    }
    var underlyingController: UIViewController!
    var loadingPresenter: UIViewController?

    //MARK: - show

    var showPlaceCallsCount = 0
    var showPlaceCalled: Bool {
        return showPlaceCallsCount > 0
    }
    var showPlaceReceivedPlace: PlaceViewModel?
    var showPlaceClosure: ((PlaceViewModel) -> Void)?

    func show(place: PlaceViewModel) {
        showPlaceCallsCount += 1
        showPlaceReceivedPlace = place
        showPlaceClosure?(place)
    }

    //MARK: - reloadData

    var reloadDataCallsCount = 0
    var reloadDataCalled: Bool {
        return reloadDataCallsCount > 0
    }
    var reloadDataClosure: (() -> Void)?

    func reloadData() {
        reloadDataCallsCount += 1
        reloadDataClosure?()
    }

    //MARK: - setContentInsets

    var setContentInsetsAnimatedCallsCount = 0
    var setContentInsetsAnimatedCalled: Bool {
        return setContentInsetsAnimatedCallsCount > 0
    }
    var setContentInsetsAnimatedReceivedArguments: (contentInsets: UIEdgeInsets, animated: Bool)?
    var setContentInsetsAnimatedClosure: ((UIEdgeInsets, Bool) -> Void)?

    func setContentInsets(_ contentInsets: UIEdgeInsets, animated: Bool) {
        setContentInsetsAnimatedCallsCount += 1
        setContentInsetsAnimatedReceivedArguments = (contentInsets: contentInsets, animated: animated)
        setContentInsetsAnimatedClosure?(contentInsets, animated)
    }

    //MARK: - showLoading

    var showLoadingCallsCount = 0
    var showLoadingCalled: Bool {
        return showLoadingCallsCount > 0
    }
    var showLoadingClosure: (() -> Void)?

    func showLoading() {
        showLoadingCallsCount += 1
        showLoadingClosure?()
    }

    //MARK: - hideLoading

    var hideLoadingCallsCount = 0
    var hideLoadingCalled: Bool {
        return hideLoadingCallsCount > 0
    }
    var hideLoadingClosure: (() -> Void)?

    func hideLoading() {
        hideLoadingCallsCount += 1
        hideLoadingClosure?()
    }

}
// MARK: -
// MARK: -
class UserLocationServiceProtocolMock: UserLocationServiceProtocol {
    var currentLocation: Coordinates?
    var delegaet: UserLocationServiceDelegate?

}
// MARK: -
// MARK: -
