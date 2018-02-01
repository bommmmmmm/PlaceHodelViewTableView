//
//  LPPlaceHolderViewTableView.h
//  LPPlaceHodelViewTableView
//
//  Created by 刘平 on 2018/1/31.
//  Copyright © 2018年 刘平. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ViewClicked) ();

@interface LPPlaceHolderViewTableView : UIView

@property (nonatomic, strong) NSArray *NoDataPlacehodelViewDataArray;
/** 传入的view 一般是tableview*/
@property(nonatomic, strong)UIView *superSendView;
/** 点击图片的回调*/
@property(nonatomic,copy)ViewClicked viewClicked;
/** 动画时间*/
@property (nonatomic, assign) float animationTime;

/**
 *  单利初始化
 *
 */
+(LPPlaceHolderViewTableView *)shareNoDataPlacehodelView;


/*!
 @method
 @abstract          根据传入的tableview 加入当数组为空时的占位图名称为icon的图片界面
 @discussion        需要正确传参，iconname 是占位图片的名字
 @param view        当前要使用占位界面的tableview
 @param array       当前要使用占位界面的tableview的数据源数组
 @param icon        当前要使用占位界面的图片名称
 @param viewClicked 点击图片的回调
 */
-(void)showCenterWithSuperView:(UIView *)view array:(NSArray *)array iconName:(NSString *)icon viewClicked:(ViewClicked)viewClicked;


/*!
 @method
 @abstract   移除占位图片
 @discussion 无
 */
- (void)removeNoDataPlacehodelViewFromeSuperview;

/*!
 @method
 @abstract   强迫症专用，彻底清除LPPlaceHolderViewTableView
 @discussion 强迫症专用，彻底清除LPPlaceHolderViewTableView
 */
-(void)clear;
@end
