# MRSpeechDispatcher

[![CI Status](http://img.shields.io/travis/hectr/MRSpeechDispatcher.svg?style=flat)](https://travis-ci.org/hectr/MRSpeechDispatcher)
[![Version](https://img.shields.io/cocoapods/v/MRSpeechDispatcher.svg?style=flat)](http://cocoapods.org/pods/MRSpeechDispatcher)
[![License](https://img.shields.io/cocoapods/l/MRSpeechDispatcher.svg?style=flat)](http://cocoapods.org/pods/MRSpeechDispatcher)
[![Platform](https://img.shields.io/cocoapods/p/MRSpeechDispatcher.svg?style=flat)](http://cocoapods.org/pods/MRSpeechDispatcher)

`MRSpeechDispatcher` provides an easy-to-use interface for producing synthesized speech from text on an iOS device:

```objc
MRSpeechDispatcher *dispatcher = MRSpeechDispatcher.defaultSpeechDispatcher;
dispatcher.reusedSynthesizer = [[AVSpeechSynthesizer alloc] init];
[dispatcher speechText:@"Now relax." withAnimus:MRSpeechAnimusGlad];
[dispatcher speechText:@"And close your eyes." withAnimus:MRSpeechAnimusRegular];
[dispatcher keepQuiteFor:2];
[dispatcher speechText:@"Well done!" withAnimus:MRSpeechAnimusGlad];
[dispatcher speechText:@"See you the next session!" withAnimus:MRSpeechAnimusHurry];
```

In the example above the dispatcher enqueues the texts to be spoken by wrapping the produced `AVSpeechUtterance` instances into `MRSpeechUtteranceOperation` objects and adding them to its `NSOperationQueue`.

But `MRSpeechUtteranceOperation` can also be created and used independently just as any other `NSOperation` instance:

```objc
AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"hello"];
NSOperation *operation = [MRSpeechUtteranceOperation speechOperationWithUtterance:utterance];
[operation start];
```

## Usage

To run the example project, clone the repo, and run `pod install` from the *Example* directory first.

## Installation

### CocoaPods

**MRSpeechDispatcher** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your *Podfile*:

```ruby
pod "MRSpeechDispatcher"
```

### Manually

Perform the following steps:

- Add the `MROperation` class into your project (see <https://www.github.com/hectr/MROperation>).
- Copy *MRSpeechDispatcher* directory into your project.

## License

**MRSpeechDispatcher** is available under the MIT license. See the *LICENSE* file for more info.