# LPPlaceHodelViewTableView

最近不是很忙，整理了一下项目中用到的部分功能进行了封装以及优化

这里要介绍的便是可以一行代码完成tableview空数据时的占位界面

tableview大家经常都可以用到，但是在处理空数据时，很多项目都已经做了空数据时的占位界面处理，这对用户来说十分友好。因为自己的项目经常有表格的界面，之前一直按照需求去加这种占位界面，但是界面渐渐多了起来，感觉很难受，每次都要去写界面。而项目一直赶进度，暂时也没有去进行优化。最近闲了下来，便着手进行优化和封装。

做这个的时候，有去了解一些主流的封装方式，有的采用的是自己封装一个父类的tableView，虽然这很方便，但是对于一些一开始就没有用这个父类的项目来说，不是太友好，有很多潜伏的危险。这种方式，我比较推荐一开始就使用，而不是在项目优化的时候改成继承别人写的父类的tableViewController。这里说一下我用的方式，
### 主要的就是根据KVO来判断是否要在tableViewController上加上一个view去做遮挡，形成一个占位界面。

这里最主要的方法
```
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
```

使用方式也很简单
```
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    self.dataArray=[NSMutableArray array];
    [[LPPlaceHolderViewTableView shareNoDataPlacehodelView] showCenterWithSuperView:self.tableView array:self.dataArray iconName:@"图表无数据" viewClicked:^{
        [self addArrayData];
    }];

    // Do any additional setup after loading the view, typically from a nib.
}
```


### 注意！！！
### 因为是通过KVO监测的，所有当你的tableViewController的数据源改变时（也就是代码中的 self.dataArray），一定要重新赋值！！！
```
-(void)addArrayData {
    [self.dataArray addObject:@"--1-- 有数据源啦！！！！！！"];
    [self.dataArray addObject:@"--2-- 有数据源啦！！！！！！"];
    [self.dataArray addObject:@"--3-- 有数据源啦！！！！！！"];
    [self.dataArray addObject:@"--4-- 有数据源啦！！！！！！"];
    // 需要重指向行触发KVO
    [LPPlaceHolderViewTableView shareNoDataPlacehodelView].NoDataPlacehodelViewDataArray = self.dataArray;    
}
- (IBAction)deleteDataButtonAction:(id)sender {
    [self.dataArray removeAllObjects];
    // 需要重指向行触发KVO
    [LPPlaceHolderViewTableView shareNoDataPlacehodelView].NoDataPlacehodelViewDataArray = self.dataArray;
//        
}
```
![Untitled.gif](http://upload-images.jianshu.io/upload_images/2251830-b1448f1fbca82ba0.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

最后附上demo地址：https://github.com/bommmmmmm/PlaceHodelViewTableView  求个star哟~~~~~
个人的blog：https://bommmmmmm.github.io

简书地址：https://www.jianshu.com/u/955aaff4602f

