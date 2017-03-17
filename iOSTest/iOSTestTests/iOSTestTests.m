//
//  iOSTestTests.m
//  iOSTestTests
//
//  Created by Handlecar on 2017/3/15.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Calculator.h"
@interface iOSTestTests : XCTestCase
{
@private
    Calculator *calculator;
}
@end

@implementation iOSTestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSLog(@"%@ setUp", self.name);
    calculator = [[Calculator alloc] init];
    XCTAssertNotNil(calculator, @"Cannot create Calculator instance");
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    NSLog(@"%@ tearDown", self.name);
}
- (void) testAddition {
    NSLog(@"%@ start", self.name);   // self.name is the name of the test-case method.
    [calculator input:@"6"];
    [calculator input:@"+"];
    [calculator input:@"2"];
    [calculator input:@"="];
    XCTAssertTrue([[calculator displayValue] isEqualToString:@"8"], @"");
    NSLog(@"%@ end", self.name);
}
/* testSubtraction performs a simple subtraction test: 19 - 2 = 17.
 * The test has two parts:
 * 1. Through the input: method, feed the calculator the characters 1, 9, -, 2, and =.
 * 2. Confirm that displayValue is 17.
 */
- (void) testSubtraction {
    NSLog(@"%@ start", self.name);   // Use NSLog to generate additional build-results output.
    [calculator input:@"1"];
    [calculator input:@"9"];
    [calculator input:@"-"];
    [calculator input:@"2"];
    [calculator input:@"="];
    XCTAssertTrue([[calculator displayValue] isEqualToString:@"17"], @"");
    NSLog(@"%@ end", self.name);
}

/* testDivision performs a simple division test: 19 / 8 = 2.375.
 * The test has two parts:
 * 1. Through the input: method, feed the calculator the characters 1, 9, /, 8, and =.
 * 2. Confirm that displayValue is 2.375.
 */
- (void) testDivision {
    NSLog(@"%@ start", self.name);
    [calculator input:@"1"];
    [calculator input:@"9"];
    [calculator input:@"/"];
    [calculator input:@"8"];
    [calculator input:@"="];
    XCTAssertTrue([[calculator displayValue] isEqualToString:@"2.375"], @"");
    NSLog(@"%@ end", self.name);
}

/* testMultiplication performs a simple multiplication test: 6 * 2 = 12.
 * The test has two parts:
 * 1. Through the input: method, feed the calculator the characters 6, *, 2, and =.
 * 2. Confirm that displayValue is 12.
 */
- (void) testMultiplication {
    NSLog(@"%@ start", self.name);
    [calculator input:@"6"];
    [calculator input:@"*"];
    [calculator input:@"2"];
    [calculator input:@"="];
    XCTAssertTrue([[calculator displayValue] isEqualToString:@"12"], @"");
    NSLog(@"%@ end", self.name);
}

/* testSubtractionNegativeResult performs a simple subtraction test with a negative result: 6 - 24 = -18.
 * The test has two parts:
 * 1. Through the input: method, feed the calculator the characters 6, -, 2, 4, and =.
 * 2. Confirm that displayValue is -18.
 */
- (void) testSubtractionNegativeResult {
    NSLog(@"%@ start", self.name);
    [calculator input:@"6"];
    [calculator input:@"-"];
    [calculator input:@"2"];
    [calculator input:@"4"];
    [calculator input:@"="];
    XCTAssertTrue([[calculator displayValue] isEqualToString:@"-18"], @"");
    NSLog(@"%@ end", self.name);
}

/* testClearLastEntry ensures that the clear (C) key clears the last entry when used once.
 */
- (void) testClearLastEntry {
    NSLog(@"%@ start", self.name);
    [calculator input:@"7"];
    [calculator input:@"+"];
    [calculator input:@"3"];
    [calculator input:@"C"];
    [calculator input:@"4"];
    [calculator input:@"="];
    XCTAssertTrue([[calculator displayValue] isEqualToString:@"11"], @"");
    NSLog(@"%@ end", self.name);
}

/* testClearComputation ensures that the clear (C) key clears the computation when used twice.
 */
- (void) testClearComputation {
    NSLog(@"%@ start", self.name);
    [calculator input:@"C"];
    [calculator input:@"7"];
    [calculator input:@"+"];
    [calculator input:@"3"];
    [calculator input:@"C"];
    [calculator input:@"C"];
    XCTAssertTrue([[calculator displayValue] isEqualToString:@"0"], @"");
    NSLog(@"%@ end", self.name);
}

/* testInputException ensures that the input: method throws an exception in three situations:
 * 1. The argument contains more than one character.
 * 2. The argument contains an invalid character.
 * 3. The argument is nil.
 */
- (void) testInputException {
    NSLog(@"%@ start", self.name);
    XCTAssertThrows([calculator input:@"67"], @"No exception for multicharacter input.");
    XCTAssertThrows([calculator input:@"j"],  @"No exception for invalid input.");
    XCTAssertThrows([calculator input:nil],   @"No exception for nil input.");
    NSLog(@"%@ end", self.name);
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
