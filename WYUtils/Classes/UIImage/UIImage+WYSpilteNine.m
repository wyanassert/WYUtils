//
//  UIImage+SpilteNine.m
//  PhotoGrid
//
//  Created by wyan on 2018/9/7.
//  Copyright © 2018年 makeupopular.com. All rights reserved.
//

#import "UIImage+WYSpilteNine.h"

@implementation UIImage (WYSpiltNine)

- (NSArray<UIImage *> *)wy_spiltenine {
    NSMutableArray<UIImage *> *tmpMutableArray = [NSMutableArray array];
    CGImageRef imageref = self.CGImage;
    CGFloat imageWidth = self.size.width * self.scale;
    CGFloat imageHeight = self.size.height * self.scale;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            CGRect rect = CGRectMake(j * imageWidth / 3, i*imageHeight / 3, imageWidth/3, imageHeight/3);
            CGImageRef newRef = CGImageCreateWithImageInRect(imageref, rect);
            UIImage *subImage = [UIImage imageWithCGImage:newRef];
            CGImageRelease(newRef);
            if(subImage) {
                [tmpMutableArray addObject:subImage];
            }
        }
    }
    return [tmpMutableArray copy];
}

@end
