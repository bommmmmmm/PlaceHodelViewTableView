//
//  LPPlaceHolderViewTableView.m
//  LPPlaceHodelViewTableView
//
//  Created by 刘平 on 2018/1/31.
//  Copyright © 2018年 刘平. All rights reserved.
//

#import "LPPlaceHolderViewTableView.h"
#define kAnimationTime 0.5f
@interface LPPlaceHolderViewTableView()
@property(nonatomic,strong)UIImageView *placehodelView;
@property (nonatomic, strong) NSString *icon;
@end

@implementation LPPlaceHolderViewTableView


+(LPPlaceHolderViewTableView*)shareNoDataPlacehodelView{
    static LPPlaceHolderViewTableView* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LPPlaceHolderViewTableView alloc] init];
    });
    return instance;
}


-(UIImageView *)placehodelView{
    if (!_placehodelView) {
        _placehodelView=[[UIImageView alloc] init];
        _placehodelView.contentMode=UIViewContentModeScaleAspectFit;
        _placehodelView.userInteractionEnabled=YES;
        [_placehodelView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(placehodelViewClicked)]];
        _placehodelView.frame=CGRectMake(0, 0, 60, 60);
    }
    return _placehodelView;
}

-(instancetype)init{
    if (self=[super init]) {
        // 添加视图
        [self addSubview:self.placehodelView];
        // 添加KVO
        [self addObserver:self forKeyPath:@"NoDataPlacehodelViewDataArray" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.placehodelView.center=self.center;
}


-(void)placehodelViewClicked{
    if (!self.viewClicked) return;
    [self animationPopupWith:self.placehodelView];
    self.viewClicked();
}

-(void)showCenterWithSuperView:(UIView *)view icon:(NSString *)icon viewClicked:(ViewClicked)viewClicked {
    [self showCenterWithSuperView:view icon:icon];
    self.superSendView = view;
    self.viewClicked=viewClicked;
}
-(void)showCenterWithSuperView:(UIView*)view icon:(NSString*)icon{
    [self showSuper:view icon:icon];
    self.frame=view.bounds;
}

-(void)showSuper:(UIView*)view icon:(NSString*)icon{
    if (!view){
        NSException *excp = [NSException exceptionWithName:@"NoDataPlacehodelView" reason:@"未设置父视图。" userInfo:nil];
        [excp raise];
        return;
    };
    icon=icon? icon:@"";
    self.backgroundColor=view.backgroundColor;
    // 添加视图
    [view insertSubview:self atIndex:0];
    self.placehodelView.image=[UIImage imageNamed:icon];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.superSendView respondsToSelector:@selector(reloadData)]) {
            [(UITableView *)self.superSendView reloadData];
        }
    });

}


- (void)removeNoDataPlacehodelViewFromeSuperview {
    if (self) {
        [self removeFromSuperview];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.superSendView respondsToSelector:@selector(reloadData)]) {
            [(UITableView *)self.superSendView reloadData];
        }
    });
    
}

-(void)animationPopupWith:(UIView*)view {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = self.animationTime ? self.animationTime : kAnimationTime;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [view.layer addAnimation:animation forKey:nil];
}


-(void)showCenterWithSuperView:(UIView *)view array:(NSArray *)array iconName:(NSString *)icon viewClicked:(ViewClicked)viewClicked {
    self.icon = icon;
    self.superSendView = view;
    self.NoDataPlacehodelViewDataArray = array;
    self.viewClicked=viewClicked;
}


#pragma mark-----KVO回调----
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (![keyPath isEqualToString:@"NoDataPlacehodelViewDataArray"]) {
        return;
    }
    if ([self.NoDataPlacehodelViewDataArray count]==0) {
        [self showCenterWithSuperView:self.superSendView icon:self.icon viewClicked:self.viewClicked];
    }else {
        [[LPPlaceHolderViewTableView shareNoDataPlacehodelView] removeNoDataPlacehodelViewFromeSuperview];
    }
    
}
-(void)dealloc{
    [self removeObserver:self forKeyPath:@"NoDataPlacehodelViewDataArray"];
}

-(void)clear{
    for (UIView*bview in self.superview.subviews) {
        if ([bview isKindOfClass:[LPPlaceHolderViewTableView class]]) {
            [bview removeFromSuperview];
        }
    }
}
@end
