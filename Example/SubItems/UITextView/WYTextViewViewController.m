//
//  WYTextViewViewController.m
//  WYUtils_Example
//
//  Created by wyan on 2023/4/21.
//  Copyright © 2023 wyanassert. All rights reserved.
//

#import "WYTextViewViewController.h"
#import "UITextView+WYTagUtils.h"
#import "UIControl+BlocksKit.h"
#import "WYSafeCast.h"

@interface WYTextViewViewController () <UITextViewDelegate>

@end

@implementation WYTextViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(16, 100, WY_SCREEN_WIDTH - 32, 200)];
    textView.layer.borderColor = UIColor.blueColor.CGColor;
    textView.layer.borderWidth = 1;
    textView.delegate = self;
    textView.returnKeyType = UIReturnKeySend;
    textView.enablesReturnKeyAutomatically = YES;
    textView.scrollsToTop = NO;
    textView.highlightAttrDic = @{
        NSForegroundColorAttributeName : [UIColor greenColor],
        NSFontAttributeName : [UIFont systemFontOfSize:16],
    };
    textView.normalAttrDic = @{
        NSForegroundColorAttributeName : UIColor.grayColor,
        NSFontAttributeName : [UIFont systemFontOfSize:16],
    };
    
    for (NSString *text in @[@"@周杰伦", @"#每日推荐"])
    {
        [textView tu_appendTagString:WYSAFE_CAST(text, NSString)];
    }
    [self.view addSubview:textView];
    
    {
        UIButton *test1Button = [[UIButton alloc] initWithFrame:CGRectMake(16, 400, 100, 30)];
        [test1Button setTitle:@"@周杰伦" forState:UIControlStateNormal];
        [test1Button setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [test1Button bk_addEventHandler:^(id sender) {
            textView.text = @"一起听新歌吧 @周杰伦 最伟大的作品 @周杰伦的歌";
            [textView tu_refreshText];
        } forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:test1Button];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITextViewDelegate

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    [textView tu_adjustCursorPosition];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (NO == [textView tu_shouldChangeTextInRange:range replacementText:text])
    {
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [textView tu_refreshText];
}

@end
