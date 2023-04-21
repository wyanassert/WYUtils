//
//  UITextView+WYTagUtils.m
//  Pods-WYUtils_Example
//
//  Created by wyan on 2023/4/7.
//

#import "UITextView+WYTagUtils.h"
#import <objc/runtime.h>
#import "WYMacroHeader.h"

@interface WYHyperHashTag : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) NSUInteger location;

@end

@implementation WYHyperHashTag

@end


@implementation UITextView (WYTagUtils)


- (void)tu_refreshText
{
    UITextRange *markedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:markedRange.start offset:0];
    if (position) // 有中文候选词(系统默认中文输入法才有), 不能刷新富文本
    {
        return ;
    }
    self.lastRefreshCursorText = WY_AVOID_NIL_STRING(self.text);
    [self.hashTagList removeAllObjects];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] init];
    if (self.inputTagList.count == 0)
    {
        
        [self tu_addNormalForText:self.text toAttr:attr];
    }
    else
    {
        // 有双循环, 注意下不要用在太重的地方
        NSString *origText = self.text;
        int i = 0;
        int j = 0;
        while (i < origText.length)
        {
            NSString *currentText = [origText substringFromIndex:i];
            NSString *currHashTag = nil;
            for (NSString *testTag in self.inputTagList.copy)
            {
                if (testTag.length && [currentText hasPrefix:testTag])
                {
                    if (i > j)
                    {
                        NSString *subStr = [origText substringWithRange:NSMakeRange(j, i - j)];
                        [self tu_addNormalForText:subStr toAttr:attr];
                    }
                    NSUInteger location = i;
                    i += testTag.length;
                    j = i;
                    [self tu_addHashTag:testTag
                                 toAttr:attr
                             atLocation:location];
                    currHashTag = testTag;
                    break;
                }
            }
            if (currHashTag)
            {
                continue ;
            }
            else
            {
                i ++;
            }
        }
        if (origText.length > j)
        {
            NSString *subStr = [origText substringWithRange:NSMakeRange(j, origText.length - j)];
            [self tu_addNormalForText:subStr toAttr:attr];
        }
    }
    NSRange selectRange = self.selectedRange;
    self.attributedText = attr.copy; // 会把光标挪到最后面,
    self.selectedRange = selectRange;
}

- (void)tu_appendTagString:(NSString *)tagStr
{
    if (tagStr.length == 0 || [self.inputTagList containsObject:WY_AVOID_NIL_STRING(tagStr)])
    {
        return;
    }
    
    if (self.inputTagList == nil)
    {
        self.inputTagList = [[NSMutableArray alloc] init];
    }
    [self.inputTagList addObject:WY_AVOID_NIL_STRING(tagStr)];
}

- (void)tu_clearTagList
{
    [self.inputTagList removeAllObjects];
    [self tu_refreshText];
}

- (void)tu_adjustCursorPosition
{
    NSString *logText = self.lastRefreshCursorText;
    BOOL textChange = ![WY_AVOID_NIL_STRING(logText) isEqualToString:WY_AVOID_NIL_STRING(self.text)];
    if (textChange && self.self.hashTagList.count > 0)
    {
        // 如果文本变化了, 需要重新刷一次富文本信息, 才能继续定位光标
        [self tu_refreshText];
    }
    NSRange textRange = self.selectedRange;
    for (WYHyperHashTag *hashTag in self.hashTagList.copy)
    {
        NSRange tagRange = NSMakeRange(hashTag.location, hashTag.text.length);
        if (textRange.length == 0) // 单个光标选中
        {
            NSUInteger tagLeft = tagRange.location;
            NSUInteger tagRight = tagLeft + tagRange.length;
            if (textRange.location > tagLeft && textRange.location < tagRight)
            {
                if (textRange.location >= (tagLeft + tagRight) / 2.0)
                {
                    [self updateSelectRange:NSMakeRange(tagRight, textRange.length)];
                    break ; // 设置光标后 立刻跳出循环
                }
                else
                {
                    [self updateSelectRange:NSMakeRange(tagLeft, textRange.length)];
                    break ; // 设置光标后 立刻跳出循环
                }
            }
        }
        else // 同时选中多个字符
        {
            NSInteger intersection = NSIntersectionRange(textRange, tagRange).length;
            if (intersection > 0 && intersection < tagRange.length) // 相交但不包含才设置光标
            {
                [self updateSelectRange:NSUnionRange(textRange, tagRange)];
                break ; // 设置光标后 立刻跳出循环
            }
        }
    }
}

- (BOOL)tu_shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (text.length == 0) // 删除操作
    {
        for (WYHyperHashTag *hashTag in self.hashTagList.copy)
        {
            NSInteger intersection = NSIntersectionRange(range, NSMakeRange(hashTag.location, hashTag.text.length)).length;
            if (intersection > 0 && intersection < hashTag.text.length)
            {
                [self updateSelectRange:NSUnionRange(range, NSMakeRange(hashTag.location, hashTag.text.length))];
                return NO;
            }
        }
    }
    return YES;
}

#pragma mark - Private

- (void)tu_addNormalForText:(NSString *)subStr toAttr:(NSMutableAttributedString *)mutableAttr
{
    NSDictionary *attrDic = self.normalAttrDic;
    if (attrDic.count == 0)
    {
        attrDic = @{
            NSFontAttributeName : [UIFont systemFontOfSize:UIFont.systemFontSize],
            NSForegroundColorAttributeName : UIColor.blackColor,
        };
    }
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:WY_AVOID_NIL_STRING(subStr)
                                                               attributes:WY_AVOID_NIL_DIC(attrDic)];
    [mutableAttr appendAttributedString:attr];
}

- (void)tu_addHashTag:(NSString *)tag
               toAttr:(NSMutableAttributedString *)mutableAttr
           atLocation:(NSUInteger)location
{
    if (self.hashTagList == nil)
    {
        self.hashTagList = [NSMutableArray array];
    }
    WYHyperHashTag *hashTag = [[WYHyperHashTag alloc] init];
    hashTag.text = tag;
    hashTag.location = location;
    [self.hashTagList addObject:hashTag];
    
    NSDictionary *attrDic = self.highlightAttrDic;
    if (attrDic.count == 0)
    {
        attrDic = @{
            NSFontAttributeName : [UIFont systemFontOfSize:UIFont.systemFontSize],
            NSForegroundColorAttributeName : UIColor.greenColor,
        };
    }
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:WY_AVOID_NIL_STRING(tag)
                                                               attributes:WY_AVOID_NIL_DIC(attrDic)];
    [mutableAttr appendAttributedString:attr];
}

- (void)updateSelectRange:(NSRange)range
{
    NSRange origRange = self.selectedRange;
    if (origRange.location != range.location || origRange.length != range.length)
    {
        [self becomeFirstResponder];
        UITextPosition *startPosion = [self positionFromPosition:self.beginningOfDocument offset:range.location];
        UITextPosition *endPosion = [self positionFromPosition:startPosion offset:range.length];
        UITextRange *textRange = [self textRangeFromPosition:startPosion  toPosition:endPosion];
        self.selectedTextRange = textRange;
    }
}

#pragma mark - Getter & Setter

- (NSMutableArray<NSString *> *)inputTagList
{
    return objc_getAssociatedObject(self, @selector(inputTagList));
}

- (void)setInputTagList:(NSMutableArray<NSString *> *)inputTagList
{
    objc_setAssociatedObject(self, @selector(inputTagList), inputTagList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray<WYHyperHashTag *> *)hashTagList
{
    return objc_getAssociatedObject(self, @selector(hashTagList));
}

- (void)setHashTagList:(NSMutableArray<WYHyperHashTag *> *)hashTagList
{
    objc_setAssociatedObject(self, @selector(hashTagList), hashTagList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)highlightAttrDic
{
    return objc_getAssociatedObject(self, @selector(highlightAttrDic));
}

- (void)setHighlightAttrDic:(NSDictionary *)highlightAttrDic
{
    objc_setAssociatedObject(self, @selector(highlightAttrDic), highlightAttrDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)normalAttrDic
{
    return objc_getAssociatedObject(self, @selector(normalAttrDic));
}

- (void)setNormalAttrDic:(NSDictionary *)normalAttrDic
{
    objc_setAssociatedObject(self, @selector(normalAttrDic), normalAttrDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)lastRefreshCursorText
{
    return objc_getAssociatedObject(self, @selector(lastRefreshCursorText));
}

- (void)setLastRefreshCursorText:(NSString *)lastRefreshCursorText
{
    objc_setAssociatedObject(self, @selector(lastRefreshCursorText), lastRefreshCursorText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
