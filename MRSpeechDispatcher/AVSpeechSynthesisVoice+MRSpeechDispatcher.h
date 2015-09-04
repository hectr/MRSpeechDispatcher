// AVSpeechSynthesisVoice+MRSpeechDispatcher.h
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


@interface AVSpeechSynthesisVoice (MRSpeechDispatcher)

/**
 Returns all available speech voices for the given country.
 
 @param country The country for which voices should be selected.
 @return A set of `AVSpeechSynthesisVoice` objects, one for each available voice for the given country.
 */
+ (nullable NSSet *)voicesForCountry:(nonnull NSString *)country
__attribute__((nonnull (1)));

/**
 Returns all available speech voices for the given language.
 
 @param language The language for which voices should be selected.
 @return A set of `AVSpeechSynthesisVoice` objects, one for each available voice for the given language.
 */
+ (nullable NSSet *)voicesForLanguage:(nonnull NSString *)language
__attribute__((nonnull (1)));

/**
 Returns the language component of the BCP-47 code identifying the voice’s language and locale.
 
 @return Language code of the receiver.
 */
- (nullable NSString *)languageCode;

/**
 Returns the locale component of the BCP-47 code identifying the voice’s language and locale.
 
 @return Country code of the receiver.
 */
- (nullable NSString *)countryCode;

@end
