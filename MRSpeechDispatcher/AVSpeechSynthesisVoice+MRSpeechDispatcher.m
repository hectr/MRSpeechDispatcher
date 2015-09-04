// AVSpeechSynthesisVoice+MRSpeechDispatcher.m
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

#import "AVSpeechSynthesisVoice+MRSpeechDispatcher.h"


static NSDictionary *__voicesForCountry = nil;
static NSDictionary *__voicesForLanguage = nil;


@implementation AVSpeechSynthesisVoice (MRSpeechDispatcher)

+ (NSSet *)voicesForCountry:(NSString *const)country
{
    NSParameterAssert(country);
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *const speechVoices = AVSpeechSynthesisVoice.speechVoices;
        NSMutableDictionary *const voicesForCountry = NSMutableDictionary.dictionary;
        [speechVoices enumerateObjectsUsingBlock:
         ^(AVSpeechSynthesisVoice *const voice, NSUInteger const idx, BOOL *const stop) {
             NSString *const country = voice.countryCode;
             if (country) {
                 NSMutableSet *const voices = voicesForCountry[country];
                 if (voices) {
                     [voices addObject:voice];
                 } else {
                     voicesForCountry[country] = [NSMutableSet setWithObject:voice];
                 }
             }
         }];
        __voicesForCountry = voicesForCountry;
    });
    NSSet *const voices = __voicesForCountry[(country.uppercaseString ?: NSNull.null)];
    return voices;
}

+ (NSSet *)voicesForLanguage:(NSString *const)language
{
    NSParameterAssert(language);
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *const speechVoices = AVSpeechSynthesisVoice.speechVoices;
        NSMutableDictionary *const voicesForLanguage = NSMutableDictionary.dictionary;
        [speechVoices enumerateObjectsUsingBlock:
         ^(AVSpeechSynthesisVoice *const voice, NSUInteger const idx, BOOL *const stop) {
             NSString *const language = voice.languageCode;
             if (language) {
                 NSMutableSet *const voices = voicesForLanguage[language];
                 if (voices) {
                     [voices addObject:voice];
                 } else {
                     voicesForLanguage[language] = [NSMutableSet setWithObject:voice];
                 }
             }
         }];
        __voicesForLanguage = voicesForLanguage;
    });
    NSSet *const voices = __voicesForLanguage[(language ?: NSNull.null)];
    return voices;
}

- (NSString *)languageCode
{
    NSString *const languageString = self.language;
    NSArray *const components = [languageString componentsSeparatedByString:@"-"];
    NSString *languageCode;
    if (components.count >= 1) {
        languageCode = components[0];
    }
    return languageCode;
}

- (NSString *)countryCode
{
    NSString *const languageString = self.language;
    NSArray *const components = [languageString componentsSeparatedByString:@"-"];
    NSString *countryCode;
    if (components.count >= 2) {
        countryCode = components[1];
    }
    return countryCode;
}

@end
