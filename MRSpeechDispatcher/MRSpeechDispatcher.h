// MRSpeechDispatcher.h
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

#import <Foundation/Foundation.h>

@class AVSpeechUtterance;
@class AVSpeechSynthesizer;
@class AVSpeechSynthesisVoice;
@class MRSpeechUtteranceOperation;


/**
 Enumeration used by the method `speechText:withAnimus:` for configuring utterance objects.
 */
typedef NS_ENUM(NSInteger, MRSpeechAnimus) {
    /** Default speech animus. */
    MRSpeechAnimusDefault,
    /** Regular speech animus. */
    MRSpeechAnimusRegular,
    /** Glad speech animus. */
    MRSpeechAnimusGlad,
    /** Fast speech animus. */
    MRSpeechAnimusHurry
};


/**
 Dispatcher of speech operations.
 */
@interface MRSpeechDispatcher : NSObject

/**
 Returns the default speech dispatcher.
 
 @return The default speech dispatcher instance.
 */
+ (nonnull MRSpeechDispatcher *)defaultSpeechDispatcher
__attribute__((returns_nonnull));

/**
 Speech operations queue. If `nil` speech operations created by the speech dispatcher will be started instead of enqueued.
 */
@property (nonatomic, strong, nullable) NSOperationQueue *queue;

/**
 Reused synthesizer instance. If `nil`, no synthesizer object will be passed when creating the speech operations.
 */
@property (nonatomic, strong, nullable) AVSpeechSynthesizer *reusedSynthesizer;

/**
 Reused voice instance. If `nil`, no voice will be passed when creating the utterance objects.
 */
@property (nonatomic, strong, nullable) AVSpeechSynthesisVoice *reusedVoice;

/**
 Enqueues/starts a new speech operation for speaking the given utterance.
 
 @param utterance The sppech utterance that will be spoken.
 @return The new already enqueued/started speech operation.
 */
- (nonnull MRSpeechUtteranceOperation *)speechUtterance:(nonnull AVSpeechUtterance *)utterance
__attribute__((returns_nonnull, nonnull (1)));

/**
 Enqueues/starts a new speech operation for speaking the given text.
 
 @param text The text that will be spoken.
 @param animus The `MRSpeechAnimus` value used for configuring the spoken utterance.
 @return The new already enqueued/started speech operation.
 */
- (nonnull MRSpeechUtteranceOperation *)speechText:(nonnull NSString *)text
                                        withAnimus:(MRSpeechAnimus)animus
__attribute__((returns_nonnull, nonnull (1)));

/**
 Enqueues/starts a new speech operation that will be quite for the given time interval.
 
 @param timeInterval The duration of the silent speech operation.
 @return The new already enqueued/started speech operation.
 */
- (nonnull MRSpeechUtteranceOperation *)keepQuiteFor:(NSTimeInterval)timeInterval
__attribute__((returns_nonnull));

@end
