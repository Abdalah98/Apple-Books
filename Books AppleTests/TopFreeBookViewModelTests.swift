//
//  TopFreeBookViewModelTests.swift
//  Books AppleTests
//
//  Created by Abdallah on 12/8/21.
//

import XCTest
@testable import Books_Apple

class TopFreeBookViewModelTests: XCTestCase {

    var sut: TopFreeBookViewModel!
 //   var apiServiceMock: APIServiceMock!

    override func setUp() {
        super.setUp()
//        apiServiceMock = APIServiceMock()
//        sut = PhotoListViewModel(apiService: apiServiceMock)
        sut = TopFreeBookViewModel()
    }
    
    override func tearDown() {
        sut = nil
  //      apiServiceMock = nil
        super.tearDown()
    }

    // A test method’s name always begins with test, followed by a description of what it tests.

    // It’s good practice to format the test into given, when and then sections
    // Given: Here, you set up any values needed.
    // In this example, today’s date and a dummy photo object are created.
    
//    func test_fetch_popular_photo() {
//        // When
//        sut.initFetch()
//
//        // Then
//        XCTAssert(apiServiceMock.fetchPopularPhotosIsCalled)
//    }
//
//    func test_fetch_photo_fail() {
//        // Given
//        let error = APIError.notFound
//
//        // When
//        sut.initFetch()
//        apiServiceMock.fetchFail(error: error)
//
//        // Then
//        XCTAssertEqual(sut.alertMessage, error.rawValue)
//    }
//
//    func test_user_press_for_sale_item() {
//        // Given
//        guard let photos = StubGenerator().stubPhotos() else {
//            XCTFail("Failed to generate photos")
//            return
//        }
//
//        let indexPath = IndexPath(row: 0, section: 0)
//
//        apiServiceMock.photos = photos
//
//        sut.initFetch()
//        apiServiceMock.fetchSuccess()
//
//        // When
//        sut.userPressed(at: indexPath)
//
//        // Then
//        XCTAssertTrue(sut.isAllowSegue)
//    }
//
//    func test_user_press_not_for_sale_item() {
//        // Given
//        guard let photos = StubGenerator().stubPhotos() else {
//            XCTFail("Failed to generate photos")
//            return
//        }
//        let indexPath = IndexPath(row: 4, section: 0)
//
//        apiServiceMock.photos = photos
//
//        sut.initFetch()
//        apiServiceMock.fetchSuccess()
//
//        let promise = XCTestExpectation(description: "Alert message is shown")
//        sut.showAlertClosure = {
//            promise.fulfill()
//        }
//
//        // When
//        sut.userPressed(at: indexPath)
//        wait(for: [promise], timeout: 1.0)
//
//        // Then
//        XCTAssertFalse(sut.isAllowSegue)
//        XCTAssertNil(sut.selectedPhoto)
//        XCTAssertEqual(sut.alertMessage, "This item is not for sale")
//    }
//
//    func test_create_cell_view_model() {
//        // Given
//        guard let photos = StubGenerator().stubPhotos() else {
//            XCTFail("Failed to generate photos")
//            return
//        }
//
//        apiServiceMock.photos = photos
//
//        let promise = XCTestExpectation(description: "reload closure triggered")
//        sut.reloadTableViewClosure = { () in
//            promise.fulfill()
//        }
//
//        // When
//        sut.initFetch()
//        apiServiceMock.fetchSuccess()
//        wait(for: [promise], timeout: 1.0)
//
//        // Number of cell view model is equal to the number of photos
//        XCTAssertEqual(sut.numberOfCells, photos.count)
//    }
//
//    func test_populated_state_when_fetching() {
//
//        //Given
//        var state: State? = .empty
//        let promise = XCTestExpectation(description: "Loading state updated to populated")
//        sut.updateLoadingStatus = { [weak sut] in
//            state = sut?.state
//            promise.fulfill()
//        }
//
//        //when fetching
//        sut.initFetch()
//        wait(for: [promise], timeout: 1.0)
//
//        // Assert
//        XCTAssertEqual(state, State.loading)
//
//        // When finished fetching
//        apiServiceMock?.fetchSuccess()
//        XCTAssertEqual(state, State.populated)
//    }
//
//    func test_error_state_when_fetching() {
//
//        //Given
//        var state: State? = .empty
//        let promise = XCTestExpectation(description: "Loading state updated to error")
//        sut.updateLoadingStatus = { [weak sut] in
//            state = sut?.state
//            promise.fulfill()
//        }
//        // Given a failed fetch with a certain failure
//        let error = APIError.permissionDenied
//
//        //when fetching
//        sut.initFetch()
//        wait(for: [promise], timeout: 1.0)
//
//        // Assert
//        XCTAssertEqual(state, State.loading)
//
//        // When finished fetching
//        apiServiceMock?.fetchFail(error: error)
//        XCTAssertEqual(state, State.error)
//    }
//
//    func testGetCellViewModel() {
//        //Given a sut with fetched photos
//        guard let photos = StubGenerator().stubPhotos() else {
//            XCTFail("Failed to generate photos")
//            return
//        }
//
//        apiServiceMock.photos = photos
//
//        sut.initFetch()
//        apiServiceMock.fetchSuccess()
//
//        let indexPath = IndexPath(row: 1, section: 0)
//        let testPhoto = apiServiceMock.photos[indexPath.row]
//
//        // When
//        let vm = sut.getCellViewModel(at: indexPath)
//
//        //Assert
//        XCTAssertEqual(vm.titleText, testPhoto.name)
//    }

    func testCreateCellViewModel() {
        // Given
        let book  = ResultBooks(artistName: "as", id: "2", name: "abd", releaseDate: "22", kind: "apple", artistId: "d", artistUrl: "sd", artworkUrl100: "sd", genres: [], url: "ds", contentAdvisoryRating: "sd")

             let cellViewModel = sut?.createCellViewModel(book: book)

        // Then: This is the section where you’ll assert the result you expect with a message that prints if the test fails.
        XCTAssertEqual(cellViewModel?.name, "\(book.name ?? "")")

    }

}
