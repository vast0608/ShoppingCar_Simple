//
//  ViewController.m
//  ShoppingCar
//
//  Created by 上海烨历网络科技有限公司 on 2017/6/14.
//  Copyright © 2017年 上海烨历网络科技有限公司. All rights reserved.
//

#import "ShoppingCraVC.h"
#import "ShoppingCraCell.h"
#import "ShoppingCarModel.h"
@interface ShoppingCraVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIButton *deleteButton;//删除按钮
//列表属性
@property(nonatomic,strong)UITableView *tableView;//列表
@property(nonatomic,strong)ShoppingCraCell *shoppingCraCell;//cell
//底部栏按钮属性
@property(nonatomic,strong)UILabel *totlePriceLab;//总价格
@property(nonatomic,strong)UIButton *settleAccounts;//结算按钮

@property(nonatomic,strong)UIButton *cancleDelBtn;//取消删除
@property(nonatomic,strong)UIButton *confirmDelBtn;//确定删除

@property(nonatomic,strong)NSMutableArray *selectIndexMuarr;//存储选择按钮的容器

@property(nonatomic,strong)NSMutableArray *dataMuarr;//数据容器容器
@property(nonatomic,assign)CGFloat price;

@end
static NSString *CellIdentifierCell = @"ShoppingCraCell";
@implementation ShoppingCraVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建模拟模型
    [self setModel];
    //创建导航栏有关的内容
    [self creatAboutNavi];
    //创建底部栏
    [self creatBottomUI];
    // 创建tableView
    [self creatTableview];
}
#pragma mark----创建模拟模型
-(void)setModel{
    _dataMuarr = [NSMutableArray new];
    for (int i=0; i<5; i++) {
        ShoppingCarModel *moade = [ShoppingCarModel new];
        moade.productName = [NSString stringWithFormat:@"模拟商品标题%d",i];
        moade.totalPrice = [NSString stringWithFormat:@"%d",i*10+1];
        moade.imageName = @"123456.jpg";
        moade.number = @"2";
        [_dataMuarr addObject:moade];
    }
}
#pragma mark----创建导航栏有关的内容
-(void)creatAboutNavi{
    self.title = @"购物车";
    //右边按钮
    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteButton.frame = CGRectMake(0, 0, 40, 40);
    [_deleteButton setTitle:@"删除" forState:0];
    _deleteButton.backgroundColor = [UIColor redColor];
    [_deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:_deleteButton];
    self.navigationItem.rightBarButtonItem = barItem;
}
#pragma mark----创建底部栏
-(void)creatBottomUI{
    UIView *bottonView = [UIView new];
    bottonView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49-45, [UIScreen mainScreen].bounds.size.width, 45);
    [self.view addSubview:bottonView];
    //总价格
    _totlePriceLab = [UILabel new];
    _totlePriceLab.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-125, 45);
    _totlePriceLab.backgroundColor = [UIColor greenColor];
    _totlePriceLab.textAlignment = NSTextAlignmentCenter;
    _totlePriceLab.text = @"￥0.00";
    [bottonView addSubview:_totlePriceLab];
    //结算按钮
    _settleAccounts = [UIButton new];
    _settleAccounts.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-125, 0, 125, 45);
    [_settleAccounts setTitle:@"去结算" forState:0];
    _settleAccounts.backgroundColor = [UIColor redColor];
    [bottonView addSubview:_settleAccounts];
    //取消删除
    _cancleDelBtn = [UIButton new];
    _cancleDelBtn.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 45);
    [_cancleDelBtn setTitle:@"取消" forState:0];
    _cancleDelBtn.backgroundColor = [UIColor lightGrayColor];
    [_cancleDelBtn addTarget:self action:@selector(cancleDelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _cancleDelBtn.hidden = YES;
    [bottonView addSubview:_cancleDelBtn];
    //确定删除
    _confirmDelBtn = [UIButton new];
    _confirmDelBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2, 0, [UIScreen mainScreen].bounds.size.width/2, 45);
    [_confirmDelBtn setTitle:@"确定" forState:0];
    _confirmDelBtn.backgroundColor = [UIColor redColor];
    [_confirmDelBtn addTarget:self action:@selector(confirmDelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _confirmDelBtn.hidden = YES;
    [bottonView addSubview:_confirmDelBtn];
}
#pragma mark----创建tableView
-(void)creatTableview{
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-49-45)style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[ShoppingCraCell class] forCellReuseIdentifier:CellIdentifierCell];//注册cell
    
    _selectIndexMuarr = [NSMutableArray new];//存储选择按钮的容器
}
//有多少组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//第二问：每组有几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataMuarr.count;
}
//第三问：每行长什么样子
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _shoppingCraCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierCell];
    if (_shoppingCraCell == nil) {// 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
        //单元格样式设置为UITableViewCellStyleDefault
        _shoppingCraCell = [[ShoppingCraCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierCell];
    }
    _shoppingCraCell.selectionStyle = UITableViewCellSelectionStyleNone;//选中cell时的颜色
    [_shoppingCraCell.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_shoppingCraCell.deleteBtn addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _shoppingCraCell.selectBtn.tag = indexPath.row;
    //设置模型
    _shoppingCraCell.model = _dataMuarr[indexPath.row];
    _shoppingCraCell.numberButton.userInteractionEnabled = NO;
    //删除时的状态
    if (_deleteButton.selected==YES) {
        _shoppingCraCell.productNameLab.hidden = YES;
        _shoppingCraCell.productPriceLab.hidden = YES;
        _shoppingCraCell.numberButton.hidden = YES;
        _shoppingCraCell.deleteBtn.hidden = NO;
    }else if(_deleteButton.selected==NO){
        _shoppingCraCell.productNameLab.hidden = NO;
        _shoppingCraCell.productPriceLab.hidden = NO;
        _shoppingCraCell.numberButton.hidden = NO;
        _shoppingCraCell.deleteBtn.hidden = YES;
    }
    
    
    return _shoppingCraCell;
}
//一答：点中一行后如何响应
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
//每行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
//设置每一组的头间距
- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section{
    return 0.001 ;
}
//设置每一组的脚间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001 ;
}
#pragma mark----tableview上选择按钮的点击事件
-(void)selectBtnClick:(UIButton *)button{
    NSInteger indexRow = [self.tableView indexPathForCell:((ShoppingCraCell*)[button   superview])].row;
    button.selected = !button.selected;
    _shoppingCraCell = (ShoppingCraCell *)[_tableView cellForRowAtIndexPath:[self.tableView indexPathForCell:((ShoppingCraCell*)[button superview])]];
    //取出选择的cell下标
    if (button.selected==YES) {
        [_selectIndexMuarr addObject:[NSIndexPath indexPathForRow:indexRow inSection:0]];
        _shoppingCraCell.numberButton.userInteractionEnabled = YES;
    }else{
        [_selectIndexMuarr removeObject:[NSIndexPath indexPathForRow:indexRow inSection:0]];
        _shoppingCraCell.numberButton.userInteractionEnabled = NO;
    }
    NSLog(@"-----------%@",_selectIndexMuarr);
    //计算总价
    _price = 0.0;
    if (_selectIndexMuarr.count!=0) {
        for (int i=0; i<_selectIndexMuarr.count; i++) {
            NSIndexPath *indexP = _selectIndexMuarr[i];
            _shoppingCraCell = (ShoppingCraCell *)[_tableView cellForRowAtIndexPath:indexP];
            NSString *priceStr = [_shoppingCraCell.productPriceLab.text substringFromIndex:3];//截取掉下标3之前的字符串
            __weak typeof(self) weakSelf = self;
            _shoppingCraCell.numberButton.numberBlock = ^(NSString *num){
                if ([num integerValue]>[((ShoppingCarModel *)_dataMuarr[indexP.row]).number integerValue]) {
                    _price = _price + [priceStr floatValue]*(1);
                    ((ShoppingCarModel *)weakSelf.dataMuarr[indexP.row]).number = num;
                }else if ([num integerValue]<[((ShoppingCarModel *)_dataMuarr[indexP.row]).number integerValue]){
                    _price = _price + [priceStr floatValue]*(-1);
                    ((ShoppingCarModel *)weakSelf.dataMuarr[indexP.row]).number = num;
                }
                //主线程执行：
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.totlePriceLab.text = [NSString stringWithFormat:@"CA$%.2f",weakSelf.price];
                });
                NSLog(@"=======%f",weakSelf.price);
            };
            _price = _price + [priceStr floatValue]*[_shoppingCraCell.numberButton.textField.text integerValue];
        }
    }else{
        _price = 0.0;
    }
    // 主线程执行：
    dispatch_async(dispatch_get_main_queue(), ^{
        self.totlePriceLab.text = [NSString stringWithFormat:@"CA$%.2f",self.price];
    });
    NSLog(@"=======%f",_price);
}
#pragma mark----tableview上删除按钮的点击事件
-(void)deleteButtonClick:(UIButton *)button{
    NSInteger indexRow = [self.tableView indexPathForCell:((ShoppingCraCell*)[button   superview])].row;
    [self.tableView beginUpdates];
    
    [self.dataMuarr removeObjectAtIndex:indexRow];
    [_selectIndexMuarr removeAllObjects];
    
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexRow inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    if (_dataMuarr.count==0) {
        [self cancleDelBtnClick];
    }
    [self.tableView endUpdates];
    
    //选择归零
    for (int i=0; i<self.dataMuarr.count; i++) {
        NSIndexPath *indexP = [NSIndexPath indexPathForRow:i inSection:0];
        _shoppingCraCell = (ShoppingCraCell *)[_tableView cellForRowAtIndexPath:indexP];
        _shoppingCraCell.selectBtn.selected = NO;
    }
    _price = 0.0;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.totlePriceLab.text = [NSString stringWithFormat:@"CA$%.2f",self.price];
    });
    NSLog(@"=======%f",_price);
    [self.tableView reloadData];
}
#pragma mark----导航栏上删除按钮的点击事件
-(void)deleteButtonClick{
    //让确定和取消显示出来
    _confirmDelBtn.hidden = NO;
    _cancleDelBtn.hidden = NO;
    //让总价格和结算隐藏出来
    _totlePriceLab.hidden = YES;
    _settleAccounts.hidden = YES;
    //让cell上的隐藏或显示
    _deleteButton.selected = YES;
    [self.tableView reloadData];
}
#pragma mark----取消删除按钮的点击事件
-(void)cancleDelBtnClick{
    //让确定和取消隐藏出来
    _confirmDelBtn.hidden = YES;
    _cancleDelBtn.hidden = YES;
    //让总价格和结算显示出来
    _totlePriceLab.hidden = NO;
    _settleAccounts.hidden = NO;
    //让cell上的隐藏或显示
    _deleteButton.selected = NO;
    [self.tableView reloadData];
}
#pragma mark----确定删除按钮的点击事件
-(void)confirmDelBtnClick{
    
    if (_selectIndexMuarr.count!=0) {
        [self.tableView beginUpdates];
        NSMutableIndexSet *set = [NSMutableIndexSet indexSet];
        for (NSIndexPath *indexP in _selectIndexMuarr) {
            [set addIndex:indexP.row];
        }
        
        [self.dataMuarr removeObjectsAtIndexes:set];
        [self.tableView deleteRowsAtIndexPaths:_selectIndexMuarr withRowAnimation:UITableViewRowAnimationAutomatic];
        
        if (_dataMuarr.count==0) {
            [self cancleDelBtnClick];
        }
        _price = 0.0;
        // 主线程执行：
        dispatch_async(dispatch_get_main_queue(), ^{
            self.totlePriceLab.text = [NSString stringWithFormat:@"CA$%.2f",self.price];
        });
        NSLog(@"=======%f",_price);
        
        [_selectIndexMuarr removeAllObjects];
        [self.tableView endUpdates];
    }
}

@end
