//
//  ViewController.m
//  AVSpeechSynthesis
//
//  Created by 小飞鸟 on 2018/5/12.
//  Copyright © 2018年 小飞鸟. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVSpeechSynthesizerDelegate>

@end

@implementation ViewController{
    
    AVSpeechSynthesizer *av;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    av = [[AVSpeechSynthesizer alloc]init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"想跟你在一起。想跟你在一起。想跟你在一起。想跟你在一起"];  //需要转换的文本
    //设置语言
    AVSpeechSynthesisVoice *voiceType = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    utterance.voice = voiceType;
    //设置语速
    utterance.rate = 0.5;
    //设置音量 （0.0~1.0）默认为1.0
    utterance.volume = 1.0;
    //设置音调 (0.5-2.0)
    utterance.pitchMultiplier = 1.0;
    //目的是让语音合成器播放下一语句前有短暂的暂停
    utterance.postUtteranceDelay = 10.0;
    
    av.delegate = self;
    [av speakUtterance:utterance];
    
}
- (IBAction)pauseSound:(id)sender {
    
    if (av.isSpeaking) {
        [av pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];//立即停止播放
//        [av pauseSpeakingAtBoundary:AVSpeechBoundaryWord];//播放完毕这个词
    }
    
}
- (IBAction)convertToSound:(id)sender {
    
    if ([av isPaused]) {
        [av continueSpeaking];//继续播放
        
    }else{
          [av pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];//立即停止播放
    }
}

#pragma mark - AVSpeechSynthesizerDelegate(代理方法)

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"开始播放语音的时候调用");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"语音播放结束的时候调用");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"暂停语音播放的时候调用");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"继续播放语音的时候调用");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"取消语音播放的时候调用");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance {
    
    /** 将要播放的语音文字 */
    NSString *willSpeakRangeOfSpeechString = [utterance.speechString substringWithRange:characterRange];
    
    NSLog(@"即将播放的语音文字:%@",willSpeakRangeOfSpeechString);
}

@end
