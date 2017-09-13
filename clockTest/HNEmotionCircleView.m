//
//  HNEmotionCircleView.m
//  test
//
//  Created by wanglei on 2017/9/12.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "HNEmotionCircleView.h"

@interface HNEmotionCircleView ()

@property (nonatomic, strong) CAShapeLayer *pointerLayer;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat trackLayerWidth;

@end

@implementation HNEmotionCircleView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(0, 20, frame.size.width, 305)];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        _radius = self.frame.size.width/2.0 - 70;
        _trackLayerWidth = 20.f;
        CGFloat sacle = (M_PI * 1.30)/9.f;
        
        CAShapeLayer *trackLayer = [CAShapeLayer layer];
        trackLayer.frame = self.bounds;
        trackLayer.fillColor = [UIColor clearColor].CGColor;
        trackLayer.strokeColor = [UIColor colorWithRed:170/255.0 green:210/255.0 blue:254/255.0 alpha:1].CGColor;
        trackLayer.lineWidth = _trackLayerWidth;
        trackLayer.lineCap = @"round";
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0) radius:_radius startAngle:-M_PI*1.15 endAngle: -M_PI * 1.15 + M_PI * 1.30 clockwise:YES];
        trackLayer.path = path.CGPath;
        
        CGColorRef colorTop = [UIColor colorWithRed:90/255.f green:131/255.f blue:235/255.f alpha:1].CGColor;
        CGColorRef colorLeft = [UIColor colorWithRed:78/255.f green:220/255.f blue:164/255.f alpha:1].CGColor;
        CGColorRef colorRight = [UIColor colorWithRed:251/255.f green:62/255.f blue:62/255.f alpha:1].CGColor;
        
        CALayer *gradientLayer = [CALayer layer];
        gradientLayer.frame = self.bounds;
        
        CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
        gradientLayer1.frame = CGRectMake(0, 0, width/2.0, height);
        gradientLayer1.colors = @[(__bridge id)colorTop, (__bridge id)colorLeft];
        [gradientLayer1 setLocations:@[@0.4, @0.6,@1]];
        gradientLayer1.startPoint = CGPointMake(1, 0);
        gradientLayer1.endPoint = CGPointMake(0.5, 1);
        [gradientLayer addSublayer:gradientLayer1];
        
        CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];
        gradientLayer2.frame = CGRectMake(width/2.0, 0, width/2.0, height);
        gradientLayer2.colors = @[(__bridge id)colorTop, (__bridge id)colorRight];
        [gradientLayer2 setLocations:@[@0.4, @0.6,@1]];
        gradientLayer2.startPoint = CGPointMake(0, 0);
        gradientLayer2.endPoint = CGPointMake(0.5, 1);
        [gradientLayer addSublayer:gradientLayer2];

        [self.layer addSublayer:gradientLayer];
        gradientLayer.mask = trackLayer;
        
        //中心1
        CAShapeLayer *centre1 = [CAShapeLayer layer];
        centre1.frame = self.bounds;
        centre1.fillColor = [UIColor lightGrayColor].CGColor;
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0) radius:25 startAngle:-M_PI endAngle: -M_PI + M_PI * 2 clockwise:YES];
        centre1.path = path.CGPath;
        [self.layer addSublayer:centre1];
        
        self.pointerLayer = [CAShapeLayer layer];
        self.pointerLayer.frame = self.bounds;
        self.pointerLayer.fillColor = [UIColor darkGrayColor].CGColor;
        self.pointerLayer.lineWidth = 10;
        self.pointerLayer.lineCap = @"round";
        self.pointerLayer.strokeColor = [UIColor darkGrayColor].CGColor;
        [self.layer addSublayer:self.pointerLayer];
        UIBezierPath *pointerPath = [UIBezierPath bezierPath];
        [pointerPath moveToPoint:CGPointMake(width/2.0, height/2+26)];
        [pointerPath addLineToPoint:CGPointMake(width/2.0, height/2-70)];
        self.pointerLayer.path = pointerPath.CGPath;
        [self.pointerLayer setAffineTransform:CGAffineTransformMakeRotation(sacle * 4.5*-1)];
        
        CAShapeLayer *cuspLayer = [CAShapeLayer layer];
        cuspLayer.frame = self.bounds;
        cuspLayer.fillColor = [UIColor darkGrayColor].CGColor;
        [self.layer addSublayer:self.pointerLayer];
        pointerPath = [UIBezierPath bezierPath];
        [pointerPath moveToPoint:CGPointMake(width/2.0, height/2-85)];
        [pointerPath addLineToPoint:CGPointMake(width/2.0 - 5, height/2-72)];
        [pointerPath addLineToPoint:CGPointMake(width/2.0 + 5, height/2-72)];
        [pointerPath closePath];
        cuspLayer.path = pointerPath.CGPath;
        [self.pointerLayer addSublayer:cuspLayer];
        
        //中心2
        CAShapeLayer *centre2 = [CAShapeLayer layer];
        centre2.frame = self.bounds;
        centre2.fillColor = [UIColor whiteColor].CGColor;
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0) radius:14 startAngle:-M_PI endAngle: -M_PI + M_PI * 2 clockwise:YES];
        centre2.path = path.CGPath;
        [self.layer addSublayer:centre2];
        
        [self addDialLabel];
    }
    return self;
}

- (void)addDialLabel{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat sacle = (M_PI * 1.30)/9.f;
    CGFloat idt = 5*sacle;
    NSArray *Xcorrections = @[@(0),@(0),@(4),@(2),@(0),@(0),@(0),@(-2),@(-4),@(0),@(-0)];
    NSArray *Ycorrections = @[@(0),@(8),@(5),@(2),@(0),@(0),@(0),@(0),@(5),@(8),@(0)];
    NSArray *dials = @[@"-2.00",@"-0.95",@"-0.60",@"-0.37",@"-0.18",@"0.00",@"0.18",@"0.37",@"0.60",@"0.95",@"2.00"];
    for (int i = 0; i < 11; i ++) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = self.bounds;
        if (i>0 && i<10) {
            layer.lineWidth = 2.f;
            layer.strokeColor = [UIColor lightGrayColor].CGColor;
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(width/2.0-1, height/2-_radius+_trackLayerWidth*0.5)];
            [path addLineToPoint:CGPointMake(width/2.0-1, height/2-_radius+5+_trackLayerWidth*0.5)];
            layer.path = path.CGPath;
        }
        CATextLayer *textLayer = [CATextLayer layer];
//        textLayer.backgroundColor = [UIColor redColor].CGColor;
        textLayer.string = dials[i];
        textLayer.frame = CGRectMake(width/2.0-20+[Xcorrections[i] floatValue], height/2-_radius+8+_trackLayerWidth*0.5+2+[Ycorrections[i] floatValue], 40, 10);
        UIFont *font = [UIFont systemFontOfSize:10.f];
        CFStringRef fontName = (__bridge CFStringRef)font.fontName;
        CGFontRef fontRef = CGFontCreateWithFontName(fontName);
        textLayer.font = fontRef;
        textLayer.fontSize = font.pointSize;
        CGFontRelease(fontRef);
        
        textLayer.foregroundColor = [UIColor blackColor].CGColor;
        textLayer.alignmentMode = kCAAlignmentCenter;
        if (i==0) textLayer.alignmentMode = kCAAlignmentLeft;
        if (i==10) textLayer.alignmentMode = kCAAlignmentRight;
        [layer addSublayer:textLayer];
        [self.layer addSublayer:layer];
        CGFloat rotation = -idt+sacle * i;
        [layer setAffineTransform:CGAffineTransformMakeRotation(rotation)];
        [textLayer setAffineTransform:CGAffineTransformMakeRotation(-rotation)];
    }
}

- (void)setProgress:(CGFloat)progress{
    CGFloat preAngle = M_PI * 1.30/4.f;
    CGFloat num = progress - (-2);
    CGFloat rotation = preAngle * num;
    
    CGFloat sacle = (M_PI * 1.30)/9.f;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    pathAnimation.duration = 2;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pathAnimation.fromValue = @(sacle * 4.5*-1);
    pathAnimation.toValue = @(sacle * 4.5*-1 + rotation);
    pathAnimation.fillMode=kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    [self.pointerLayer addAnimation:pathAnimation forKey:@"pointerLayerAnimation"];
}








/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
