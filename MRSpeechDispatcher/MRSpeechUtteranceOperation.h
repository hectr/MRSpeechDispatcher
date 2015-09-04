// MRSpeechUtteranceOperation.h
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

#import "MROperation.h"

#import <AVFoundation/AVFoundation.h>

@protocol MRSpeechUtteranceOperationDelegate;


/**
 `MRSpeechUtteranceOperation` is a concrete subclass of `NSOperation` that enqueues an utterance to be spoken in a synthesizer and finishes when the synthesizer notifies to have finished speaking it.
 */
@interface MRSpeechUtteranceOperation : MROperation

/**
 Initializes and returns a newly allocated operation object that will enqueue an utterance to be spoken.
 
 @param utterance An `AVSpeechUtterance` object containing text to be spoken.
 @return A new speech operation object.
 */
+ (nonnull instancetype)speechOperationWithUtterance:(nonnull AVSpeechUtterance *)utterance
__attribute__((returns_nonnull, nonnull (1)));

/**
 Initializes and returns a newly allocated operation object that will enqueue an utterance to be spoken in the given synthesizer.
 
 @param synthesizer The `AVSpeechSynthesizer` that will speak the utterance. Upon creation the new operation will be set as synthesizer's delegate.
 @param utterance An `AVSpeechUtterance` object containing text to be spoken.
 @return A new speech operation object.
 */
+ (nonnull instancetype)speechOperationWithSynthesizer:(nullable AVSpeechSynthesizer *)synthesizer
                                          andUtterance:(nonnull AVSpeechUtterance *)utterance
__attribute__((returns_nonnull, nonnull (2)));

/**
 Initializes and returns a newly allocated operation object that will not produce any sound during the given time interval.
 
 @param unvoiceInterval The interval of time that should take to complete the operation.
 @return A new speech operation object.
 */
+ (nonnull instancetype)speechUnvoiceOperation:(NSTimeInterval)unvoiceInterval
__attribute__((returns_nonnull));

/**
 Property set when the synthesizer notifies that the speech is paused.
 */
@property (nonatomic, readonly, getter = isSpeechPaused) BOOL speechPaused;

/**
 Property set when the synthesizer notifies that the speech has started.
 */
@property (nonatomic, readonly, getter = isSpeechStarted) BOOL speechStarted;

/**
 Utterance that will be spoken by the operation.
 */
@property (nonatomic, strong, readonly, nonnull) AVSpeechUtterance *utterance;

/**
 Synthesizer that will speak the utterance.
 */
@property (nonatomic, strong, readonly, nonnull) AVSpeechSynthesizer *synthesizer;

/**
 Operation's stop speech boundary.
 */
@property (nonatomic) AVSpeechBoundary cancelSpeechBoundary;

/**
 Operation's delegate. See `MRSpeechUtteranceOperationDelegate`.
 */
@property (nonatomic, weak, nullable) id<MRSpeechUtteranceOperationDelegate> delegate;

@end


/**
 Protocol that should be conformed by speech operation's delegate.
 */
@protocol MRSpeechUtteranceOperationDelegate <NSObject>

/**
 Tells the delegate when the synthesizer is about to speak a portion of an utterance’s text.
 
 @param operation The executing operation that whose utterance is being spoken.
 @param characterRange The range of characters in the utterance’s speechString corresponding to the unit of speech about to be spoken.
 */
@required
- (void)speechUtteranceOperation:(nonnull MRSpeechUtteranceOperation *)operation
    willSpeakRangeOfSpeechString:(NSRange)characterRange
__attribute__((nonnull (1)));

@end
