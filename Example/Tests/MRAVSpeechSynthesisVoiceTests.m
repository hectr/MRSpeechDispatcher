//
//  MRAVSpeechSynthesisVoiceTests.m
//  MRSpeechDispatcher
//
//  Created by NA on 04/09/15.
//  Copyright (c) 2015 hectr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <MRSpeechDispatcher/AVSpeechSynthesisVoice+MRSpeechDispatcher.h>


@interface MRAVSpeechSynthesisVoiceTests : XCTestCase
@end


@implementation MRAVSpeechSynthesisVoiceTests

- (void)testThatVoicesForCountryReturnsVoicesForUS
{
    XCTAssertTrue([AVSpeechSynthesisVoice voicesForCountry:@"US"].count > 0);
}

- (void)testThatVoicesForCountryReturnsVoicesForUs
{
    XCTAssertTrue([AVSpeechSynthesisVoice voicesForCountry:@"us"].count > 0);
}

- (void)testThatVoicesForCountryIsConsistent
{
    XCTAssertEqualObjects([AVSpeechSynthesisVoice voicesForCountry:@"us"], [AVSpeechSynthesisVoice voicesForCountry:@"US"]);
}

- (void)testThatVoicesForLanguageReturnsVoicesForEn
{
    XCTAssertTrue([AVSpeechSynthesisVoice voicesForLanguage:@"en"].count > 0);
}

- (void)testThatVoicesForLanguageReturnsEn_USVoiceForEn
{
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    NSSet *voices = [AVSpeechSynthesisVoice voicesForLanguage:@"en"];
    BOOL found = NO;
    for (AVSpeechSynthesisVoice *v in voices) {
        if ([v isEqual:voice]) {
            found = YES;
            break;
        }
    }
    XCTAssertTrue(found);
}

- (void)testThatLanguageCodeIsCorrect
{
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    XCTAssertEqualObjects(voice.languageCode, @"en");
}

- (void)testThatCountryCodeIsCorrect
{
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    XCTAssertEqualObjects(voice.countryCode, @"US");
}

@end
