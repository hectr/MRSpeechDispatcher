// MRSpeechDispatcher.m
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

#import "MRSpeechDispatcher.h"
#import "AVSpeechUtterance+MRSpeechDispatcher.h"
#import "MRSpeechUtteranceOperation.h"


@implementation MRSpeechDispatcher

+ (MRSpeechDispatcher *)defaultSpeechDispatcher
{
    static MRSpeechDispatcher *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[MRSpeechDispatcher alloc] init];
    });
    return __instance;
}

- (MRSpeechUtteranceOperation *)speechUtterance:(AVSpeechUtterance *const)utterance
{
    NSParameterAssert(utterance);
    
    MRSpeechUtteranceOperation *operation;
    if (_reusedSynthesizer) {
        operation =
        [MRSpeechUtteranceOperation speechOperationWithSynthesizer:_reusedSynthesizer
                                                      andUtterance:utterance];
    } else {
        operation =
        [MRSpeechUtteranceOperation speechOperationWithUtterance:utterance];
    }
    
    if (_queue) {
        [_queue addOperation:operation];
    } else {
        [operation start];
    }
    return operation;
}

- (MRSpeechUtteranceOperation *)speechText:(NSString *const)text
                                withAnimus:(MRSpeechAnimus const)animus
{
    NSParameterAssert(text);
    
    AVSpeechUtterance *utterance;
    switch (animus) {
        case MRSpeechAnimusDefault:
            utterance = [AVSpeechUtterance speechUtteranceWithString:text];
            break;
        case MRSpeechAnimusRegular:
            utterance = [AVSpeechUtterance regularUtteranceWithText:text];
            break;
        case MRSpeechAnimusGlad:
            utterance = [AVSpeechUtterance gladUtteranceWithText:text];
            break;
        case MRSpeechAnimusHurry:
            utterance = [AVSpeechUtterance hurryUtteranceWithText:text];
            break;
        case MRSpeechAnimusBrisk:
            utterance = [AVSpeechUtterance briskUtteranceWithText:text];
            break;
    }
    
    if (_reusedVoice) {
        utterance.voice = _reusedVoice;
    }
    
    return [self speechUtterance:utterance];
}

- (MRSpeechUtteranceOperation *)keepQuiteFor:(NSTimeInterval const)timeInterval
{
    MRSpeechUtteranceOperation *const operation =
    [MRSpeechUtteranceOperation speechUnvoiceOperation:timeInterval];
    
    if (_queue) {
        [_queue addOperation:operation];
    } else {
        [operation start];
    }
    return operation;
}

#pragma mark NSObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 1;
    }
    return self;
}

@end
