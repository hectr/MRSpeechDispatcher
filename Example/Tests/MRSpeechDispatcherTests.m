//
//  MRSpeechDispatcherTests.m
//  MRSpeechDispatcher
//
//  Created by NA on 04/09/15.
//  Copyright (c) 2015 hectr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <MRSpeechDispatcher/MRSpeechDispatcher.h>
#import <MRSpeechDispatcher/MRSpeechUtteranceOperation.h>


@interface MRSpeechDispatcherTests : XCTestCase
@end


@implementation MRSpeechDispatcherTests

- (void)testThatKeepQuiteCreatesAnOperation
{
    MRSpeechDispatcher *dispatcher = MRSpeechDispatcher.new;
    MRSpeechUtteranceOperation *operation = [dispatcher keepQuiteFor:1];
    [dispatcher.queue cancelAllOperations];
    XCTAssertTrue([operation isKindOfClass:MRSpeechUtteranceOperation.class]);
}

- (void)testThatKeepQuiteEnqueuesTheOperation
{
    MRSpeechDispatcher *dispatcher = MRSpeechDispatcher.new;
    MRSpeechUtteranceOperation *operation = [dispatcher keepQuiteFor:1];
    XCTAssertTrue([dispatcher.queue.operations containsObject:operation]);
    [dispatcher.queue cancelAllOperations];
}

- (void)testThatSpeechTextWithAnimusCreatesAnOperation
{
    MRSpeechDispatcher *dispatcher = MRSpeechDispatcher.new;
    MRSpeechUtteranceOperation *operation;
    @synchronized(@"test") {
        operation = [dispatcher speechText:@"test" withAnimus:MRSpeechAnimusDefault];
        [dispatcher.queue cancelAllOperations];
    }
    XCTAssertTrue([operation isKindOfClass:MRSpeechUtteranceOperation.class]);
}

- (void)testThatSpeechTextWithAnimusEnqueuesTheOperation
{
    MRSpeechDispatcher *dispatcher = MRSpeechDispatcher.new;
    MRSpeechUtteranceOperation *operation;
    @synchronized(@"test") {
        operation = [dispatcher speechText:@"test" withAnimus:MRSpeechAnimusDefault];
        XCTAssertTrue([dispatcher.queue.operations containsObject:operation]);
        [dispatcher.queue cancelAllOperations];
    }
}

- (void)testThatSpeechUtteranceWithStringCreatesAnOperation
{
    MRSpeechDispatcher *dispatcher = MRSpeechDispatcher.new;
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"test"];
    MRSpeechUtteranceOperation *operation;
    @synchronized(@"test") {
        operation = [dispatcher speechUtterance:utterance];
        [dispatcher.queue cancelAllOperations];
    }
    XCTAssertTrue([operation isKindOfClass:MRSpeechUtteranceOperation.class]);
}

- (void)testThatSpeechUtteranceWithStringEnqueuesTheOperation
{
    MRSpeechDispatcher *dispatcher = MRSpeechDispatcher.new;
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"test"];
    MRSpeechUtteranceOperation *operation;
    @synchronized(@"test") {
        operation = [dispatcher speechUtterance:utterance];
        XCTAssertTrue([dispatcher.queue.operations containsObject:operation]);
        [dispatcher.queue cancelAllOperations];
    }
}

- (void)testThatOperationIsStartedIfQueueIsNil
{
    MRSpeechDispatcher *dispatcher = MRSpeechDispatcher.new;
    dispatcher.queue = nil;
    MRSpeechUtteranceOperation *operation = [dispatcher keepQuiteFor:1];
    XCTAssertTrue(operation.isExecuting);
    [dispatcher.queue cancelAllOperations];
}

@end
