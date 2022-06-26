//
//  LoginAndSiginUITest.swift
//  MovieBookingAppUITests
//
//  Created by MacBook Pro on 20/06/2022.
//

import XCTest
@testable import MovieBookingApp

class LoginAndSiginUITest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
   
    
    func test_loginWithEmail_withIncorrectEmailFormat_returnsError() throws {
        let app = XCUIApplication()
        app.launch()
        
        let elementsQuery = app.scrollViews.otherElements
        let emailTF = elementsQuery.textFields["email"]
        emailTF.tap()
        emailTF.typeText("a@12,")
        elementsQuery.secureTextFields["password"].tap()

        elementsQuery.buttons["Confirm"].tap()
                
        let alert_view = app.otherElements["alert_view"].exists
        XCTAssertTrue(alert_view)
        
    }
    
    func test_loginView_withEmptyInput_returnsError() throws {
        let app = XCUIApplication()
        app.launch()
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.buttons["Confirm"].tap()
                
        let alert_view = app.otherElements["alert_view"].exists
        XCTAssertTrue(alert_view)
    }
    
    func test_loginView_withEmptyPasswordInput_returnsError() throws {
        let app = XCUIApplication()
        app.launch()
        let elementsQuery = app.scrollViews.otherElements
        let emailTF = elementsQuery.textFields["email"]
        emailTF.tap()
        emailTF.typeText("aungkyawmon@gmail.com")
        
        elementsQuery.secureTextFields["password"].tap()
        elementsQuery.buttons["Confirm"].tap()
        
        let alert_view = app.otherElements["alert_view"]
        XCTAssertTrue(alert_view.exists)
    }
    
    
    func test_loginView_withIncorrectPassword_returnsError() throws {
        let app = XCUIApplication()
        app.launch()
        let elementsQuery = app.scrollViews.otherElements
        let emailTF = elementsQuery.textFields["email"]
        emailTF.tap()
        emailTF.typeText("aungkyawmon@gmail.com")
        
        let password = elementsQuery.secureTextFields["password"]
        password.tap()
        password.typeText("123")
        emailTF.tap()
        elementsQuery.buttons["Confirm"].tap()
        
        
        let alert_view = app.otherElements["alert_view"]
        XCTAssert(alert_view.waitForExistence(timeout: 5))
    }
    
    func test_singinWithEmail_withCorrectInput_shouldSuccess() throws {
        
        let app = XCUIApplication()
        app.launch()
        let elementsQuery = app.scrollViews.otherElements
    

        let emailTextField = elementsQuery.textFields["email"]
        emailTextField.tap()
        emailTextField.typeText("aungkyawmon.am@gmail.com")
        //emailTextField.swipeUp()

        let passwordTextField = elementsQuery.secureTextFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText("123456")
        emailTextField.tap()

        
//        let returnButton = app.buttons["Return"]
//        returnButton.tap()
        
        let confirmButton = app.scrollViews.otherElements.staticTexts["Confirm"]
        confirmButton.tap()
        
        let firstCell = app.tables.element(boundBy: 0)
        XCTAssert(firstCell.waitForExistence(timeout: 5))
        
        
    }

}
