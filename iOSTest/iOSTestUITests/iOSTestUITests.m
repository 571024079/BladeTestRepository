//
//  iOSTestUITests.m
//  iOSTestUITests
//
//  Created by Handlecar on 2017/3/15.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"
#import "ViewController.h"

@interface iOSTestUITests : XCTestCase
{
@private
    AppDelegate    *app_delegate;
    ViewController *calc_view_controller;
    UIView             *calc_view;
    
}
@end

@implementation iOSTestUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    
    
    app_delegate         = [[UIApplication sharedApplication] delegate];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    calc_view_controller = [storyboard instantiateViewControllerWithIdentifier:@"CalcViewController"];
    calc_view            = calc_view_controller.view;
} 

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}
- (void) testAppDelegate {
    XCTAssertNotNil(app_delegate, @"Cannot find the application delegate");
}

/* testAddition performs a chained addition test.
 * The test has two parts:
 * 1. Check: 6 + 2 = 8.
 * 2. Check: display + 2 = 10.
 */
- (void) testAddition {
    [calc_view_controller press:[calc_view viewWithTag: 6]];  // 6
    [calc_view_controller press:[calc_view viewWithTag:13]];  // +
    [calc_view_controller press:[calc_view viewWithTag: 2]];  // 2
    [calc_view_controller press:[calc_view viewWithTag:12]];  // =
    XCTAssertTrue([[calc_view_controller.displayField text] isEqualToString:@"8"], @"Part 1 failed.");
    
    [calc_view_controller press:[calc_view viewWithTag:13]];  // +
    [calc_view_controller press:[calc_view viewWithTag: 2]];  // 2
    [calc_view_controller press:[calc_view viewWithTag:12]];  // =
    XCTAssertTrue([[calc_view_controller.displayField text] isEqualToString:@"10"], @"Part 2 failed.");
}

/* testSubtraction performs a simple subtraction test.
 * Check: 6 - 2 = 4.
 */
- (void) testSubtraction {
    [calc_view_controller press:[calc_view viewWithTag: 6]];  // 6
    [calc_view_controller press:[calc_view viewWithTag:14]];  // -
    [calc_view_controller press:[calc_view viewWithTag: 2]];  // 2
    [calc_view_controller press:[calc_view viewWithTag:12]];  // =
    XCTAssertTrue([[calc_view_controller.displayField text] isEqualToString:@"4"], @"");
}

/* testDivision performs a simple division test.
 * Check: 25 / 4 = 6.25.
 */
- (void) testDivision {
    [calc_view_controller press:[calc_view viewWithTag: 2]];  // 2
    [calc_view_controller press:[calc_view viewWithTag: 5]];  // 5
    [calc_view_controller press:[calc_view viewWithTag:16]];  // /
    [calc_view_controller press:[calc_view viewWithTag: 4]];  // 4
    [calc_view_controller press:[calc_view viewWithTag:12]];  // =
    XCTAssertTrue([[calc_view_controller.displayField text] isEqualToString:@"6.25"], @"");
}

/* testMultiplication performs a simple multiplication test.
 * Check: 19 x 8 = 152.
 */
- (void) testMultiplication {
    [calc_view_controller press:[calc_view viewWithTag: 1]];  // 1
    [calc_view_controller press:[calc_view viewWithTag: 9]];  // 9
    [calc_view_controller press:[calc_view viewWithTag:15]];  // x
    [calc_view_controller press:[calc_view viewWithTag: 8]];  // 8
    [calc_view_controller press:[calc_view viewWithTag:12]];  // =
    XCTAssertTrue([[calc_view_controller.displayField text] isEqualToString:@"152"], @"");
}

/* testDelete tests the functionality of the D (Delete) key.
 * 1. Enter the number 1987 into the (id<UIApplicationDelegate>).
 * 2. Delete each digit, and test the display to ensure
 *    the correct display contains the expected value after each D press.
 */
- (void) testDelete {
    [calc_view_controller press:[calc_view viewWithTag: 1]];  // 1
    [calc_view_controller press:[calc_view viewWithTag: 9]];  // 9
    [calc_view_controller press:[calc_view viewWithTag: 8]];  // 8
    [calc_view_controller press:[calc_view viewWithTag: 7]];  // 7
    XCTAssertTrue([[calc_view_controller.displayField text] isEqualToString:@"1987"], @"Part 1 failed.");
    
    [calc_view_controller press:[calc_view viewWithTag:19]];  // D (delete)
    XCTAssertTrue([[calc_view_controller.displayField text] isEqualToString:@"198"],  @"Part 2 failed.");
    
    [calc_view_controller press:[calc_view viewWithTag:19]];  // D (delete)
    XCTAssertTrue([[calc_view_controller.displayField text] isEqualToString:@"19"],   @"Part 3 failed.");
    
    [calc_view_controller press:[calc_view viewWithTag:19]];  // D (delete)
    XCTAssertTrue([[calc_view_controller.displayField text] isEqualToString:@"1"],    @"Part 4 failed.");
    
    [calc_view_controller press:[calc_view viewWithTag:19]];  // D (delete)
    XCTAssertTrue([[calc_view_controller.displayField text] isEqualToString:@"0"],    @"Part 5 failed.");
}

/* testClear tests the functionality of the C (Clear).
 * 1. Clear the display.
 *  - Enter the calculation 25 / 4.
 *  - Press C.
 *  - Ensure the display contains the value 0.
 * 2. Perform corrected computation.
 *  - Press 5, =.
 *  - Ensure the display contains the value 5.
 * 3. Ensure pressign C twice clears all.
 *  - Enter the calculation 19 x 8.
 *  - Press C (clears the display).
 *  - Press C (clears the operand).
 *  - Press +, 2, =.
 *  - Ensure the display contains the value 2.
 */
- (void) testClear {
    [calc_view_controller press:[calc_view viewWithTag: 2]];  // 2
    [calc_view_controller press:[calc_view viewWithTag: 5]];  // 5
    [calc_view_controller press:[calc_view viewWithTag:16]];  // /
    [calc_view_controller press:[calc_view viewWithTag: 4]];  // 4
    [calc_view_controller press:[calc_view viewWithTag:11]];  // C (clear)
    XCTAssertTrue([[calc_view_controller.displayField text] isEqualToString:@"0"], @"Part 1 failed.");
    
    [calc_view_controller press:[calc_view viewWithTag: 5]];  // 5
    [calc_view_controller press:[calc_view viewWithTag:12]];  // =
    XCTAssertTrue([[calc_view_controller.displayField text] isEqualToString:@"5"], @"Part 2 failed.");
    
    [calc_view_controller press:[calc_view viewWithTag: 1]];  // 1
    [calc_view_controller press:[calc_view viewWithTag: 9]];  // 9
    [calc_view_controller press:[calc_view viewWithTag:15]];  // x
    [calc_view_controller press:[calc_view viewWithTag: 8]];  // 8
    [calc_view_controller press:[calc_view viewWithTag:11]];  // C (clear)
    [calc_view_controller press:[calc_view viewWithTag:11]];  // C (all clear)
    [calc_view_controller press:[calc_view viewWithTag:13]];  // +
    [calc_view_controller press:[calc_view viewWithTag: 2]];  // 2
    [calc_view_controller press:[calc_view viewWithTag:12]];  // =
    XCTAssertTrue([[calc_view_controller.displayField text] isEqualToString:@"2"], @"Part 3 failed.");
}

@end
