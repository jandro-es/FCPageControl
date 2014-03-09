//
//  FCPageControl.m
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

#import "FCPageControl.h"

static CGFloat const kDefautDotDiameter = 4.0f;
static CGFloat const kDefautDotMargin = 12.0f;

@implementation FCPageControl{
    NSMutableArray *_indexAreas;
    BOOL _touchInArea;
}

#pragma mark - NSObject
- (instancetype)initWithFrame:(CGRect)frame andType:(FCPageControlType)aType
{
    self = [super initWithFrame:frame];
    if (self){
        self.controlType = aType;
        _indexAreas = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return self;
}

- (instancetype)initWithType:(FCPageControlType)aType
{
    self = [super initWithFrame:CGRectZero];
    if (self){
        self.controlType = aType;
        _indexAreas = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return self;
}

- (void)layoutSubviews
{
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - DrawRect
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGFloat diameter = (_dotDiameter) ? _dotDiameter : kDefautDotDiameter;
    CGFloat margin = (_dotMargin) ? _dotMargin : kDefautDotMargin;
    
    CGFloat dotsWidth = _numberOfPages * diameter + MAX(0, _numberOfPages - 1) * margin;
    CGPoint centerPoint;

    centerPoint.x = CGRectGetMidX(self.bounds) - dotsWidth / 2;
    centerPoint.y = CGRectGetMidY(self.bounds) - diameter / 2;
    
    UIColor *activeColor = _activeColor ? _activeColor : [UIColor whiteColor];
    UIColor *inactiveColor = _inactiveColor ? _inactiveColor : [UIColor colorWithWhite:0.6f alpha:0.5f];
    
    for (int i = 0; i < _numberOfPages; i++)
    {
        CGRect dotFrame = CGRectMake(centerPoint.x, centerPoint.y, diameter, diameter);
        [_indexAreas addObject:NSStringFromCGRect(dotFrame)];
        if (i == _currentPage){
            if (_controlType == FCPageControlTypeActiveFillInactiveFill || _controlType == FCPageControlTypeActiveFillInactiveEmpty){
                CGContextSetFillColorWithColor(context, activeColor.CGColor);
                CGContextFillEllipseInRect(context, CGRectInset(dotFrame, -0.5f, -0.5f));
            } else {
                CGContextSetStrokeColorWithColor(context, activeColor.CGColor);
				CGContextStrokeEllipseInRect(context, dotFrame);
            }
        } else {
            if ( _controlType == FCPageControlTypeActiveEmptyInactiveEmpty || _controlType == FCPageControlTypeActiveFillInactiveEmpty){
                CGContextSetStrokeColorWithColor(context, inactiveColor.CGColor);
				CGContextStrokeEllipseInRect(context, dotFrame);
            } else {
                CGContextSetFillColorWithColor(context, inactiveColor.CGColor) ;
				CGContextFillEllipseInRect(context, CGRectInset(dotFrame, -0.5f, -0.5f)) ;
            }
        }
        centerPoint.x += diameter + margin;
    }
    
    CGContextRestoreGState(context);
}

#pragma mark - Custom Setters
- (void)setCurrentPage:(NSInteger)currentPage
{
    if (_currentPage != currentPage){
        _currentPage = MIN(MAX(0, currentPage), _numberOfPages -1);
        
        if (self.isDeferringCurrentPageDisplay == NO){
            [self setNeedsDisplay];
        }
    }
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = MAX(0, numberOfPages);
    _currentPage = MIN(MAX(0, _currentPage), numberOfPages - 1);
    
    self.bounds = self.bounds;
    [self setNeedsDisplay];
    
    if (self.isHiddenForSinglePage && numberOfPages < 2){
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
}

- (void)setHidesForSinglePage:(BOOL)hidesForSinglePage
{
    _hidesForSinglePage = hidesForSinglePage;
    
    if (_hidesForSinglePage && _numberOfPages < 2){
        self.hidden = YES;
    }
}

- (void)setControlType:(FCPageControlType)controlType
{
    _controlType = controlType;
    [self setNeedsDisplay];
}

- (void)setActiveColor:(UIColor *)activeColor
{
    _activeColor = activeColor;
    [self setNeedsDisplay];
}

- (void)setInactiveColor:(UIColor *)inactiveColor
{
    _inactiveColor = inactiveColor;
    [self setNeedsDisplay];
}

- (void)setDotDiameter:(CGFloat)dotDiameter
{
    _dotDiameter = dotDiameter;
    self.bounds = self.bounds;
    [self setNeedsDisplay];
}

- (void)setDotMargin:(CGFloat)dotMargin
{
    _dotMargin = dotMargin;
    self.bounds = self.bounds;
    [self setNeedsDisplay];
}

- (void)setFrame:(CGRect)frame
{
    frame.size = [self sizeForNumberOfPages:_numberOfPages];
    super.frame = frame;
}

- (void)setBounds:(CGRect)bounds
{
    bounds.size = [self sizeForNumberOfPages:_numberOfPages];
    super.bounds = bounds;
}

#pragma mark - UIPageControl
- (void)updateCurrentPageDisplay
{
    if (self.isDeferringCurrentPageDisplay == YES){
        [self setNeedsDisplay];
    }
}

- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount
{
    CGFloat diameter = (_dotDiameter) ? _dotDiameter : kDefautDotDiameter;
    CGFloat margin = (_dotMargin) ? _dotMargin : kDefautDotMargin;
    
    return CGSizeMake(pageCount * diameter + (pageCount - 1) * margin + 44.0f, MAX(44.0f, diameter + 4.0f));
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *aTouch = [touches anyObject];
    CGPoint touchPoint = [aTouch locationInView:self];
    NSUInteger pageIndex = [self pageIndexForPoint:touchPoint];

    if (_touchInArea){
        self.currentPage = MAX(pageIndex, 0);
        if ([self.delegate respondsToSelector:@selector(pageControl:Clicked:)]){
            [self.delegate pageControl:self Clicked:pageIndex];
        }
    }
}

- (NSUInteger)pageIndexForPoint:(CGPoint)aPoint
{
    _touchInArea = NO;
    NSUInteger calculatedIndex = 0;
    NSUInteger currentIndex = 0;
    for (NSString *stringRect in _indexAreas) {
        CGRect originalRect = CGRectFromString(stringRect);
        if (CGRectContainsPoint(originalRect, aPoint)){
            calculatedIndex = currentIndex;
            _touchInArea = YES;
            break;
        }
        currentIndex++;
    }
    
    return calculatedIndex;
}


@end
