//
//  MRAVSpeechUtteranceTests.m
//  MRSpeechDispatcher
//
//  Created by NA on 04/09/15.
//  Copyright (c) 2015 hectr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <MRSpeechDispatcher/AVSpeechUtterance+MRSpeechDispatcher.h>


@interface MRAVSpeechUtteranceTests : XCTestCase
@end


@implementation MRAVSpeechUtteranceTests

- (void)testThatRegularUtteranceIsReturned
{
    AVSpeechUtterance *utterance = [AVSpeechUtterance regularUtteranceWithText:@"test"];
    XCTAssertNotNil(utterance);
}

- (void)testThatRegularUtteranceTextIsCorrect
{
    NSString *speechString = @"test";
    AVSpeechUtterance *utterance = [AVSpeechUtterance regularUtteranceWithText:speechString];
    XCTAssertEqualObjects(utterance.speechString, speechString);
}

- (void)testThatGladUtteranceIsReturned
{
    AVSpeechUtterance *utterance = [AVSpeechUtterance gladUtteranceWithText:@"test"];
    XCTAssertNotNil(utterance);
}

- (void)testThatGladUtteranceTextIsCorrect
{
    NSString *speechString = @"test";
    AVSpeechUtterance *utterance = [AVSpeechUtterance gladUtteranceWithText:speechString];
    XCTAssertEqualObjects(utterance.speechString, speechString);
}

- (void)testThatHurryUtteranceIsReturned
{
    AVSpeechUtterance *utterance = [AVSpeechUtterance hurryUtteranceWithText:@"test"];
    XCTAssertNotNil(utterance);
}

- (void)testThatHurryUtteranceTextIsCorrect
{
    NSString *speechString = @"test";
    AVSpeechUtterance *utterance = [AVSpeechUtterance hurryUtteranceWithText:speechString];
    XCTAssertEqualObjects(utterance.speechString, speechString);
}

@end
