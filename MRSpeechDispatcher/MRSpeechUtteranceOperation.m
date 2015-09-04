// MRSpeechUtteranceOperation.m
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

#import "MRSpeechUtteranceOperation.h"


@interface MRSpeechUtteranceOperation () <AVSpeechSynthesizerDelegate>
@property (nonatomic, readwrite, getter = isSpeechPaused) BOOL speechPaused;
@property (nonatomic, readwrite, getter = isSpeechStarted) BOOL speechStarted;
@property (nonatomic, strong, readwrite) AVSpeechUtterance *utterance;
@property (nonatomic, weak) id<MRExecutingOperation> executingOperation;
@property (nonatomic, strong, readwrite) AVSpeechSynthesizer *synthesizer;
@end


@implementation MRSpeechUtteranceOperation

+ (instancetype)speechOperationWithUtterance:(AVSpeechUtterance *const)utterance
{
    NSParameterAssert(utterance);
    
    return [MRSpeechUtteranceOperation speechOperationWithSynthesizer:nil
                                                         andUtterance:utterance];
}

+ (instancetype)speechOperationWithSynthesizer:(AVSpeechSynthesizer *)synthesizer
                                  andUtterance:(AVSpeechUtterance *)utterance
{
    NSParameterAssert(utterance);
    
    MRSpeechUtteranceOperation *const operation =
    [(MRSpeechUtteranceOperation *)[self alloc] initWithBlock:
     ^(MRSpeechUtteranceOperation<MRExecutingOperation> *const operation) {

         operation.executingOperation = operation;
         [operation.synthesizer speakUtterance:utterance];
     }];
    
    operation.utterance = utterance;
    operation.cancelSpeechBoundary = AVSpeechBoundaryWord;
    
    operation.synthesizer = (synthesizer ?: AVSpeechSynthesizer.new);
    operation.synthesizer.delegate = operation;

    return operation;
}

+ (instancetype)speechUnvoiceOperation:(NSTimeInterval const)unvoiceInterval
{
    NSParameterAssert(unvoiceInterval >= 0);
    MRSpeechUtteranceOperation *const operation =
    [(MRSpeechUtteranceOperation *)[self alloc] initWithBlock:
     ^(MRSpeechUtteranceOperation<MRExecutingOperation> *const operation) {
                                                       
         dispatch_time_t const queue =
         dispatch_time(DISPATCH_TIME_NOW, (int64_t)(unvoiceInterval * NSEC_PER_SEC));
         dispatch_after(queue, dispatch_get_main_queue(), ^{
             [operation finishWithError:nil];
             operation.executingOperation = nil;
         });
       
     }];
    
    return operation;
}

#pragma mark - AVSpeechSynthesizerDelegate

- (void)speechSynthesizer:(__unused AVSpeechSynthesizer *const)synthesizer
  didStartSpeechUtterance:(AVSpeechUtterance *const)utterance
{
    if (_utterance == utterance) {
        self.speechStarted = YES;
    }
}

- (void)speechSynthesizer:(__unused AVSpeechSynthesizer *const)synthesizer
 didFinishSpeechUtterance:(AVSpeechUtterance *const)utterance
{
    if (_utterance == utterance) {
        id<MRExecutingOperation> const executingOperation = self.executingOperation;
        [executingOperation finishWithError:nil];
        self.executingOperation = nil;
    }
}

- (void)speechSynthesizer:(__unused AVSpeechSynthesizer *const)synthesizer
  didPauseSpeechUtterance:(AVSpeechUtterance *const)utterance
{
    if (_utterance == utterance) {
        self.speechPaused = YES;
    }
}

  - (void)speechSynthesizer:(__unused AVSpeechSynthesizer *const)synthesizer
 didContinueSpeechUtterance:(AVSpeechUtterance *const)utterance
{
    if (_utterance == utterance) {
        self.speechPaused = NO;
    }
}

- (void)speechSynthesizer:(__unused AVSpeechSynthesizer *const)synthesizer
 didCancelSpeechUtterance:(AVSpeechUtterance *const)utterance
{
    if (_utterance == utterance) {
        if (!self.isCancelled) {
            [super cancel];
            self.executingOperation = nil;
        }
    }
}

    - (void)speechSynthesizer:(__unused AVSpeechSynthesizer *const)synthesizer
 willSpeakRangeOfSpeechString:(NSRange const)characterRange
                    utterance:(AVSpeechUtterance *const)utterance
{
    if (_utterance == utterance) {
        [self.delegate speechUtteranceOperation:self
                   willSpeakRangeOfSpeechString:characterRange];
    }
}

#pragma mark NSOperation

- (BOOL)isReady
{
    AVSpeechSynthesizer *const synthesizer = self.synthesizer;
    BOOL const isSpeaking = synthesizer.isSpeaking;
    BOOL const isReady = super.isReady;
    
    return isReady && !isSpeaking;
}

- (void)cancel
{
    [super cancel];
    
    AVSpeechSynthesizer *const synthesizer = self.synthesizer;
    BOOL const isSpeaking = synthesizer.isSpeaking;
    if (isSpeaking) {
        [synthesizer stopSpeakingAtBoundary:self.cancelSpeechBoundary];
    }
    
    self.executingOperation = nil;
}

@end
