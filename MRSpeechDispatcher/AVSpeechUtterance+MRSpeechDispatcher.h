// AVSpeechUtterance+MRSpeechDispatcher.h
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

#import <AVFoundation/AVFoundation.h>


/**
 Adds convenience methods for creating `AVSpeechUtterance` instances. See `MRSpeechAnimus`.
 */
@interface AVSpeechUtterance (MRSpeechDispatcher)

/**
 Creates an utterance object with text to be spoken and regular voice parameters.
 
 @param string A string containing text to be spoken.
 @return An `AVSpeechUtterance` object that can speak the specified text.
 */
+ (nonnull AVSpeechUtterance *)regularUtteranceWithText:(nonnull NSString *)text
__attribute__((returns_nonnull, nonnull (1)));

/**
 Creates an utterance object with text to be spoken and glad voice parameters.
 
 @param string A string containing text to be spoken.
 @return An `AVSpeechUtterance` object that can speak the specified text.
 */
+ (nonnull AVSpeechUtterance *)gladUtteranceWithText:(nonnull NSString *)text
__attribute__((returns_nonnull, nonnull (1)));

/**
 Creates an utterance object with text to be spoken and fast voice parameters.
 
 @param string A string containing text to be spoken.
 @return An `AVSpeechUtterance` object that can speak the specified text.
 */
+ (nonnull AVSpeechUtterance *)hurryUtteranceWithText:(nonnull NSString *)text
__attribute__((returns_nonnull, nonnull (1)));

@end
