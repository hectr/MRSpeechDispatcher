
Pod::Spec.new do |s|
  s.name             = "MRSpeechDispatcher"
  s.version          = "0.0.1"
  s.summary          = "Text-to-speech operations dispatcher."
  s.description      = <<-DESC
                       `MRSpeechDispatcher` provides an easy-to-use interface for producing synthesized speech on an iOS device.
                       DESC

  s.homepage         = "https://github.com/hectr/MRSpeechDispatcher"
  s.license          = 'MIT'
  s.author           = { "hectr" => "h@mrhector.me" }
  s.source           = { :git => "https://github.com/hectr/MRSpeechDispatcher.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/hectormarquesra'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'MRSpeechDispatcher'
  s.public_header_files = 'MRSpeechDispatcher/*.h'
  s.frameworks = 'AVFoundation'

  s.subspec 'Dispatcher' do |st|
    st.public_header_files = 'MRSpeechDispatcher/MRSpeechDispatcher.h'
    st.source_files = 'MRSpeechDispatcher/MRSpeechDispatcher.*'
    st.dependency 'MRSpeechDispatcher/Operation'
    st.dependency 'MRSpeechDispatcher/Utterance'
  end

  s.subspec 'Operation' do |st|
    st.public_header_files = 'MRSpeechDispatcher/MRSpeechUtteranceOperation.h'
    st.source_files = 'MRSpeechDispatcher/MRSpeechUtteranceOperation.*'
    st.dependency 'MROperation', '~> 0.1.0'
  end

  s.subspec 'SynthesisVoice' do |st|
    st.public_header_files = 'MRSpeechDispatcher/AVSpeechSynthesisVoice+MRSpeechDispatcher.h'
    st.source_files = 'MRSpeechDispatcher/AVSpeechSynthesisVoice+MRSpeechDispatcher.*'
  end

  s.subspec 'Utterance' do |st|
    st.public_header_files = 'MRSpeechDispatcher/AVSpeechUtterance+MRSpeechDispatcher.h'
    st.source_files = 'MRSpeechDispatcher/AVSpeechUtterance+MRSpeechDispatcher.*'
  end

end
