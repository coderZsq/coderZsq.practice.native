//
//  SQVideoCoverView.m
//  App
//
//  Created by 朱双泉 on 2021/1/17.
//

#import "SQVideoCoverView.h"
#import <AVFoundation/AVFoundation.h>
#import "SQVideoPlayer.h"
#import "SQVideoToolbar.h"

@interface SQVideoCoverView ()

@property (nonatomic, strong, readwrite) UIImageView *coverView;
@property (nonatomic, strong, readwrite) UIImageView *playButton;
@property (nonatomic, copy, readwrite) NSString *videoUrl;
@property (nonatomic, strong, readwrite) SQVideoToolbar *toolbar;

@end

@implementation SQVideoCoverView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - SQVideoToolbarHeight)];
            _coverView;
        })];
        
        [_coverView addSubview:({
            _playButton = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 50) / 2, (frame.size.height - SQVideoToolbarHeight - 50) / 2, 50, 50)];
            _playButton;
        })];
        
        [self addSubview:({
            _toolbar = [[SQVideoToolbar alloc] initWithFrame:CGRectMake(0, _coverView.bounds.size.height, frame.size.width, SQVideoToolbarHeight)];
            _toolbar;
        })];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - public method

- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl {
    _coverView.image = [UIImage imageNamed:videoCoverUrl];
    _playButton.image = [UIImage imageNamed:@"videoPlay.png"];
    _videoUrl = videoUrl;
    [_toolbar layoutWithModel:nil];
}

#pragma mark - private method

- (void)_tapToPlay {
    [[SQVideoPlayer Player] playVideoWithUrl:_videoUrl attachView:_coverView];
}

@end
