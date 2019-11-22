//
//  WyMessageViewController.m
//  Test
//
//  Created by 王焱 on 2019/11/22.
//  Copyright © 2019 王焱. All rights reserved.
//

#import "WyMessageViewController.h"
#import "WyMessageCollectionViewCell.h"
#import "WyMessageTableViewViewController.h"
@interface WyMessageViewController()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    //当前标题位置
    NSInteger ld_currentIndex;
}
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSMutableArray *controllersArr;/// 控制器数组
@property (nonatomic, strong) NSMutableArray *titleArray; /// 标题数组
@property (nonatomic, strong) UICollectionView *titleCollectionView; /// 标题collectionview
@end

@implementation WyMessageViewController

- (void)viewDidLoad {
 [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
 self.title = @"消息";
 [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
 [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"base"] forBarMetrics:UIBarMetricsDefault];
 self.navigationController.navigationBar.translucent = NO;
 self.controllersArr = [NSMutableArray array];
 self.titleArray = [NSMutableArray array];
// 如果controller布局相同则循环创建MyViewController 添加进数组，，如果controller 布局不同 那就创建多个不同controller依次添加数组
 for (int i = 0; i < 2; i++) {
  WyMessageTableViewViewController *con = [[WyMessageTableViewViewController alloc]init];
  [self.controllersArr addObject:con];

//  NSString *str = [NSString stringWithFormat:@"第 %d 页", i+1];
//  con.titlestring = str;
 // [self.titleArray addObject:str];

 }
 [self createPageViewController];
 [self createCollectionView];
 [self setTheFirstPage];
}
 
 
 
/// 创建标题collectionview
- (void)createCollectionView{
 UICollectionViewFlowLayout *lay = [[UICollectionViewFlowLayout alloc] init];
// lay.itemSize = CGSizeMake(60, 30);
// lay.minimumLineSpacing = 0;
// lay.minimumInteritemSpacing = 0;
// lay.scrollDirection = UICollectionViewScrollDirectionHorizontal;
 self.titleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 70) collectionViewLayout:lay];
 self.titleCollectionView.showsHorizontalScrollIndicator = NO;
 self.titleCollectionView.backgroundColor = [UIColor whiteColor];
 self.titleCollectionView.delegate = self;
 self.titleCollectionView.dataSource = self;
 //[self.titleCollectionView registerClass:[TitleCollectionViewCell class] forCellWithReuseIdentifier:@"titleReuse"];
    [self.titleCollectionView registerNib:[UINib nibWithNibName:@"WyMessageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"WyMessageCollectionViewCell"];
//    [self.titleCollectionView registerClass:[WyMessageCollectionViewCell class] forCellWithReuseIdentifier:@"WyMessageCollectionViewCell"];
 [self.view addSubview:self.titleCollectionView];
}
 
#pragma mark flowDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(166, 70);
    
}


//// 标题collectionview的协议方法
 


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
 return self.controllersArr.count;
 
}
 
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *ID = @"WyMessageCollectionViewCell";
    WyMessageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (indexPath.row == 1) {
        cell.imageView.image = [UIImage imageNamed:@"receive"];
        cell.label.text = @"收到";
    }
 if (indexPath.row == ld_currentIndex) {
     cell.indicator.hidden = false;

 }else{

     cell.indicator.hidden = true;

 }

 return cell;

}
 
//// 点击标题左右切换视图控制器------------再也不用看到好几个中间页面从屏幕快速闪过了------
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 UIViewController *vc = [self.controllersArr objectAtIndex:indexPath.row];
 if (indexPath.row > ld_currentIndex) {
  [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
 
  }];
 
 } else {
 
  [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
 
  }];
 
 }
 ld_currentIndex = indexPath.row;
 NSIndexPath *path = [NSIndexPath indexPathForRow:ld_currentIndex inSection:0];
 [self.titleCollectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
 [self.titleCollectionView reloadData];
 
}
 
 
 
/// 创建pageViewController
- (void)createPageViewController {
 NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:0] forKey:UIPageViewControllerOptionInterPageSpacingKey];
 _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
 _pageViewController.delegate = self;
 _pageViewController.dataSource = self;
 [self addChildViewController:_pageViewController];
 [self.view addSubview:_pageViewController.view];
 
}
 
/// 展示上一页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
 NSInteger index = [self.controllersArr indexOfObject:viewController];
 if (index == 0 || (index == NSNotFound)) {
  return nil;
 
 }
 
 index--;
 return [self.controllersArr objectAtIndex:index];
 
}
 
/// 展示下一页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
 NSInteger index = [self.controllersArr indexOfObject:viewController];
 if (index == self.controllersArr.count - 1 || (index == NSNotFound)) {
  return nil;
 
 }
 
 index++;
 return [self.controllersArr objectAtIndex:index];
 
}
 
/// 将要滑动切换的时候
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
 UIViewController *nextVC = [pendingViewControllers firstObject];
 NSInteger index = [self.controllersArr indexOfObject:nextVC];
 ld_currentIndex = index;
 
}
 
/// 滑动结束后
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
 if (completed) {
  NSIndexPath *path = [NSIndexPath indexPathForRow:ld_currentIndex inSection:0];
  [self.titleCollectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
  [self.titleCollectionView reloadData];
 
  NSLog(@">>>>>>>>> %ld", (long)ld_currentIndex);
 
 }
 
}
 
/// 设置默认显示的是哪个页面（controller）
- (void)setTheFirstPage{
 UIViewController *vc = [self.controllersArr objectAtIndex:ld_currentIndex];
 [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
 
}
 
- (void)didReceiveMemoryWarning {
 [super didReceiveMemoryWarning];
 // Dispose of any resources that can be recreated.
 
}
 
//TitleCollectionViewCell
//@implementation TitleCollectionViewCell
// 
// 
//- (instancetype)initWithFrame:(CGRect)frame{
// self = [super initWithFrame:frame];
// if (self) {
//  [self createView];
// 
// }
// return self;
// 
//}
// 
//- (void)createView{
// self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
// [self.contentView addSubview:self.titleLabel];
// self.titleLabel.font = [UIFont systemFontOfSize:14];
// 
//}

@end
