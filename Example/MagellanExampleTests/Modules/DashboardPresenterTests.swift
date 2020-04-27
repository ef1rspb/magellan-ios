//
/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import RobinHood
import XCTest
@testable import Magellan
@testable import MagellanExample

final class DashboardPresenterTests: XCTestCase {
    
    var presenter: DashboardMapPresenter!
    var coordinator: DashboardMapCoordinatorProtocolMock!
    var mapView: MapViewProtocolMock!
    var listView: MapListViewProtocolMock!
    var view: DashboardMapViewProtocolMock!
    var service: MagellanServicePrototcolMock!
    
    var categoties: [Magellan.Category] {
        return [
            Magellan.Category(id: 1, name: "1"),
            Magellan.Category(id: 2, name: "2"),
            Magellan.Category(id: 3, name: "3"),
            Magellan.Category(id: 4, name: "4"),
        ]
    }
    
    var places: [Place] {
        return [
            Place(id: 1, name: "first", type: "one", lat: 1, lon: 1),
            Place(id: 2, name: "second", type: "one", lat: 2, lon: 2)
        ]
    }
    
    var placeInfo: PlaceInfo {
        return PlaceInfo(id: 1,
                        name: "name",
                        type: "type",
                        coordinates: Coordinates(lat: 1, lon: 1),
                        address: "addr",
                        phoneNumber: "phone",
                        openHours: "open",
                        website: "website",
                        facebook: "fb",
                        logoUuid: "logoUiid",
                        promoImageUuid: "promoUiid",
                        distance: "dist")
    }
    
    override func setUp() {
        super.setUp()
        service = MagellanServicePrototcolMock()
        coordinator = DashboardMapCoordinatorProtocolMock()
        mapView = MapViewProtocolMock()
        mapView.underlyingCoordinatesHash = "hash"
        mapView.underlyingZoom = 1
        listView = MapListViewProtocolMock()
        view = DashboardMapViewProtocolMock()
        
        service.getCategoriesRunCompletionInCompletionClosure = { _, completion in
            completion(.success(self.categoties))
            return BaseOperation<Void>()
        }
        
        presenter = DashboardMapPresenter(service: service)
        
        presenter.view = view
        presenter.mapView = mapView
        presenter.listView = listView
        presenter.coordinator = coordinator
        
        mapView.presenter = presenter
        listView.presenter = presenter
        view.presenter = presenter
        
        coordinator.presenter = presenter
    }
    
    override func tearDown() {
        super.tearDown()
        presenter = nil
        coordinator = nil
        mapView = nil
        listView = nil
        view = nil
        service = nil
    }
    
    func testSelectCategory() {
        // arrange
        service.getPlacesWithRunCompletionInCompletionClosure = { _, _, completion in
            completion(.success(PlacesResponse(locations: self.places, clusters: [])))
            return BaseOperation<Void>()
        }
        
        // act
        presenter.select(category: "category")
        
        // assert
        XCTAssertTrue(mapView.reloadDataCalled)
        XCTAssertTrue(listView.reloadDataCalled)
    }
    
    func testSearch() {
        // arrange
        service.getPlacesWithRunCompletionInCompletionClosure = { _, _, completion in
            completion(.success(PlacesResponse(locations: self.places, clusters: [])))
            return BaseOperation<Void>()
        }
        
        // act
        presenter.search(with: "text")
        
        // assert
        XCTAssertTrue(mapView.reloadDataCalled)
        XCTAssertTrue(listView.reloadDataCalled)
    }
    
    func testShowDetails() {
        // arrange
        let viewModel = PlaceViewModel(place: self.places.first!)
        
        service.getPlaceWithRunCompletionInCompletionClosure = { _, _, completion in
            completion(.success(self.placeInfo))
            return BaseOperation<Void>()
        }
        
        // act
        presenter.showDetails(place: viewModel)
        
        // assert
        XCTAssertTrue(view.showLoadingCalled)
        XCTAssertTrue(view.hideLoadingCalled)
        XCTAssertTrue(coordinator.showDetailsForCalled)
        XCTAssertTrue(mapView.showPlaceCalled)
    }
}
