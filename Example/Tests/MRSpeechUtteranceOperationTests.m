//
//  MRSpeechUtteranceOperationTests.m
//  MRSpeechDispatcher
//
//  Created by NA on 04/09/15.
//  Copyright (c) 2015 hectr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <MRSpeechDispatcher/MRSpeechUtteranceOperation.h>


@interface MRSpeechUtteranceOperationBlockDelegate_ : NSObject <MRSpeechUtteranceOperationDelegate>
@property (nonatomic, copy) void(^block)(MRSpeechUtteranceOperation *, NSRange);
@end

@implementation MRSpeechUtteranceOperationBlockDelegate_

- (void)speechUtteranceOperation:(MRSpeechUtteranceOperation *)operation
    willSpeakRangeOfSpeechString:(NSRange)characterRange
{
    self.block(operation, characterRange);
}

@end


@interface MRSpeechUtteranceOperationTests : XCTestCase
@end


@implementation MRSpeechUtteranceOperationTests

- (void)testThatSpeechOperationWithUtteranceReturnsAnOperation
{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"test"];
    MRSpeechUtteranceOperation *operation = [MRSpeechUtteranceOperation speechOperationWithUtterance:utterance];
    XCTAssertTrue([operation isKindOfClass:MRSpeechUtteranceOperation.class]);
}

- (void)testThatSpeechOperationWithSynthesizerAndUtteranceAcceptsNilSynthesizer
{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"test"];
    MRSpeechUtteranceOperation *operation = [MRSpeechUtteranceOperation speechOperationWithSynthesizer:nil
                                                                                          andUtterance:utterance];
    XCTAssertNotNil(operation.synthesizer);
}

- (void)testThatSynthesizerIsSet
{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"test"];
    AVSpeechSynthesizer *synthesizer = AVSpeechSynthesizer.new;
    MRSpeechUtteranceOperation *operation = [MRSpeechUtteranceOperation speechOperationWithSynthesizer:synthesizer
                                                                                          andUtterance:utterance];
    XCTAssertEqualObjects(operation.synthesizer, synthesizer);
}

- (void)testThatSynthesizerIsSetWhenNil
{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"test"];
    MRSpeechUtteranceOperation *operation = [MRSpeechUtteranceOperation speechOperationWithSynthesizer:nil
                                                                                          andUtterance:utterance];
    XCTAssertNotNil(operation.synthesizer);
}

- (void)testThatSynthesizerDelegateIsSet
{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"test"];
    MRSpeechUtteranceOperation *operation = [MRSpeechUtteranceOperation speechOperationWithUtterance:utterance];
    XCTAssertEqualObjects(operation.synthesizer.delegate, operation);
}


- (void)testThatSpeechUnvoiceOperationReturnsAnOperation
{
    MRSpeechUtteranceOperation *operation = [MRSpeechUtteranceOperation speechUnvoiceOperation:2];
    XCTAssertTrue([operation isKindOfClass:MRSpeechUtteranceOperation.class]);
}

- (void)testThatSynthesizerStarts
{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"a longer test"];
    utterance.rate = AVSpeechUtteranceMinimumSpeechRate;
    MRSpeechUtteranceOperation *operation = [MRSpeechUtteranceOperation speechOperationWithUtterance:utterance];
    @synchronized(@"test") {
        [operation start];
        [NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
        XCTAssertTrue(operation.synthesizer.isSpeaking);
        [operation.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        [NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
}

- (void)testThatCancelStopsSynthesizer
{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"a longer test"];
    utterance.rate = AVSpeechUtteranceMinimumSpeechRate;
    MRSpeechUtteranceOperation *operation = [MRSpeechUtteranceOperation speechOperationWithUtterance:utterance];
    operation.cancelSpeechBoundary = AVSpeechBoundaryImmediate;
    @synchronized(@"test") {
        [operation start];
        [NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
        [operation cancel];
        [NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
    XCTAssertFalse(operation.synthesizer.isSpeaking);
}

- (void)testThatSynthesizerNotifiesWhenPaused
{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"a longer test"];
    utterance.rate = AVSpeechUtteranceMinimumSpeechRate;
    MRSpeechUtteranceOperation *operation = [MRSpeechUtteranceOperation speechOperationWithUtterance:utterance];
    @synchronized(@"test") {
        [operation start];
        [NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
        [operation.synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        [NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
        XCTAssertTrue(operation.isSpeechPaused);
        [operation.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        [NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
}

- (void)testThatDelegateIsNotified
{
    __block BOOL notified = NO;
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"a longer test"];
    utterance.rate = AVSpeechUtteranceMinimumSpeechRate;
    MRSpeechUtteranceOperation *operation = [MRSpeechUtteranceOperation speechOperationWithUtterance:utterance];
    MRSpeechUtteranceOperationBlockDelegate_ *delegate = MRSpeechUtteranceOperationBlockDelegate_.new;
    delegate.block = ^(MRSpeechUtteranceOperation *operation, NSRange characterRange) {
        notified = (operation != nil);
    };
    operation.delegate = delegate;
    @synchronized(@"test") {
        [operation start];
        [NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
        [operation.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        [NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
    XCTAssertTrue(notified);
}

@end
