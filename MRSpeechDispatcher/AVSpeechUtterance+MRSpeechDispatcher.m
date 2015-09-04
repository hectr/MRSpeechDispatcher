// AVSpeechUtterance+MRSpeechDispatcher.m
//
// Copyright (c) 2013 Héctor Marqués
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AVSpeechUtterance+MRSpeechDispatcher.h"


static float const kRegularUtteranceSpeechRateModifier = 2.0f/6;
static float const kGladUtteranceSpeechRateModifier = 2.0f/7;
static float const kHurryUtteranceSpeechRateModifier = 3.0f/7;

static float const kRegularPitchMultiplier = 1.2f;
static float const kGladPitchMultiplier = 1.3f;
static float const kHurryPitchMultiplier = 1.2f;


@implementation AVSpeechUtterance (MRSpeechDispatcher)

+ (AVSpeechUtterance *)regularUtteranceWithText:(NSString *const)text
{
    AVSpeechUtterance *const utterance = [AVSpeechUtterance speechUtteranceWithString:text];
    float const baseRate = AVSpeechUtteranceMinimumSpeechRate + AVSpeechUtteranceDefaultSpeechRate;
    float const rate = kRegularUtteranceSpeechRateModifier*baseRate;
    NSAssert( rate >= AVSpeechUtteranceMinimumSpeechRate
             , @"Specified speech rate is too low" );
    NSAssert( rate <= AVSpeechUtteranceMaximumSpeechRate
             , @"Specified speech rate is too high" );
    utterance.rate = rate;
    utterance.pitchMultiplier = kRegularPitchMultiplier;
    return utterance;
}

+ (AVSpeechUtterance *)gladUtteranceWithText:(NSString *const)text
{
    AVSpeechUtterance *const utterance = [AVSpeechUtterance speechUtteranceWithString:text];
    float const baseRate = AVSpeechUtteranceMinimumSpeechRate + AVSpeechUtteranceDefaultSpeechRate;
    float const rate = kGladUtteranceSpeechRateModifier*baseRate;
    NSAssert( rate >= AVSpeechUtteranceMinimumSpeechRate
             , @"Specified speech rate is too low" );
    NSAssert( rate <= AVSpeechUtteranceMaximumSpeechRate
             , @"Specified speech rate is too high" );
    utterance.rate = rate;
    utterance.pitchMultiplier = kGladPitchMultiplier;
    return utterance;
}

+ (AVSpeechUtterance *)hurryUtteranceWithText:(NSString *const)text
{
    AVSpeechUtterance *const utterance = [AVSpeechUtterance speechUtteranceWithString:text];
    float const baseRate = AVSpeechUtteranceMinimumSpeechRate + AVSpeechUtteranceDefaultSpeechRate;
    float const rate = kHurryUtteranceSpeechRateModifier*baseRate;
    NSAssert( rate >= AVSpeechUtteranceMinimumSpeechRate
             , @"Specified speech rate is too low" );
    NSAssert( rate <= AVSpeechUtteranceMaximumSpeechRate
             , @"Specified speech rate is too high" );
    utterance.rate = rate;
    utterance.pitchMultiplier = kHurryPitchMultiplier;
    return utterance;
}

@end
