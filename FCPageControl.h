//
//  FCPageControl.h
//
//  Created by Alejandro Barros Cuetos on 08/03/14.
//  Copyright (c) 2014 Alejandro Barros Cuetos. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  && and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE  
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FCPageControlType) {
    FCPageControlTypeActiveFillInactiveFill,
    FCPageControlTypeActiveFillInactiveEmpty,
    FCPageControlTypeActiveEmptyInactiveFill,
    FCPageControlTypeActiveEmptyInactiveEmpty
};

@class FCPageControl;

@protocol FCPageControlDelegate <NSObject>

@optional
- (void)pageControl:(FCPageControl *)pageControl Clicked:(NSUInteger)index;

@end


@interface FCPageControl : UIControl

@property (nonatomic) NSInteger numberOfPages;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic, getter = isHiddenForSinglePage) BOOL hidesForSinglePage;
@property (nonatomic, getter = isDeferringCurrentPageDisplay) BOOL defersCurrentPageDisplay;
@property (nonatomic) FCPageControlType controlType;
@property (nonatomic, strong) UIColor *activeColor;
@property (nonatomic, strong) UIColor *inactiveColor;
@property (nonatomic) CGFloat dotDiameter;
@property (nonatomic) CGFloat dotMargin;

@property (assign, nonatomic) id<FCPageControlDelegate> delegate;

- (void)updateCurrentPageDisplay;
- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;

- (instancetype)initWithType:(FCPageControlType)aType;
- (instancetype)initWithFrame:(CGRect)frame andType:(FCPageControlType)aType;

@end
