//
//  UITextView+WYTagUtils.h
//  Pods-WYUtils_Example
//
//  Created by wyan on 2023/4/7.
//  为 UITextView 提供 类似于 YYTextView 的 textParser 能力
//  只支持 一次性刷新(tu_refreshText), 识别文本中所有需要高亮的富文本, 如果需要更准确的能力, 换成 YYTextView 吧

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WYHyperHashTag;

@interface UITextView (WYTagUtils)

/// 外部输入的富文本列表
@property (nonatomic, strong) NSMutableArray<NSString *> *inputTagList;
/// 当前文本中的 tag
@property (nonatomic, strong) NSMutableArray<WYHyperHashTag *> *hashTagList;
/// 上一个选中的 location

/// 高亮标签的样式
@property (nonatomic, strong) NSDictionary *highlightAttrDic;
/// 正常文字的样式
@property (nonatomic, strong) NSDictionary *normalAttrDic;

/// 上一次刷新光标时候的文本
@property (nonatomic, strong) NSString *lastRefreshCursorText;

/// 刷新文本
/// 根据 inputTagList 刷新已输入文本中的 hashTagList
- (void)tu_refreshText;

// @tag 等, 由外部自己指定, 指定完之后 调用 tu_refreshText 刷新
- (void)tu_appendTagString:(NSString *)tagStr;

// 清空外部传入的标签列表(inputTagList), 并刷新
- (void)tu_clearTagList;

/// 调整光标的位置, 对于 标签, 光标不能落在标签文字内部,  标签移动时候应该跳过标签, 选择多个文字时候, 应该选中标签全部文字
/// 在 textViewDidChangeSelection: 调用
- (void)tu_adjustCursorPosition;

/// 修改文本内容是否会影响到光标, 比如删除的时候, 遇到标签, 应该先全选中标签, 下次点击删除再删除整个标签
/// 在 - textView: shouldChangeTextInRange: replacementText: 中调用
- (BOOL)tu_shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
