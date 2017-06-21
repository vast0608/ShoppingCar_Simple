//
//  ShoppingCraCell.m
//  ShoppingCar
//
//  Created by 上海烨历网络科技有限公司 on 2017/6/14.
//  Copyright © 2017年 上海烨历网络科技有限公司. All rights reserved.
//

#import "ShoppingCraCell.h"

@implementation ShoppingCraCell
//cell自定义用的是-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier方法
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setUI];
    }
    return self;
}
-(void)setUI{
    //选择按钮
    _selectBtn = [UIButton new];
    _selectBtn.frame = CGRectMake(10, 40, 20, 20);
    _selectBtn.backgroundColor = [UIColor redColor];
    [_selectBtn setTitle:@"是" forState:UIControlStateSelected];
    [_selectBtn setTitle:@"否" forState:UIControlStateNormal];
    [self addSubview:_selectBtn];
    //商品图片
    _productImageView = [UIImageView new];
    _productImageView.frame = CGRectMake(40, 10, 80, 80);
    _productImageView.backgroundColor = [UIColor yellowColor];
    [self addSubview:_productImageView];
    //商品名字
    _productNameLab = [UILabel new];
    _productNameLab.frame = CGRectMake(130, 10, [UIScreen mainScreen].bounds.size.width-140, 40);
    _productNameLab.backgroundColor = [UIColor blueColor];
    [self addSubview:_productNameLab];
    //商品价格
    _productPriceLab = [UILabel new];
    _productPriceLab.frame = CGRectMake(130, 70, [UIScreen mainScreen].bounds.size.width-245, 20);
    _productPriceLab.backgroundColor = [UIColor greenColor];
    [self addSubview:_productPriceLab];
    //加号减号按钮
    _numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100, 65, 85, 25)];
    _numberButton.shakeAnimation = YES;
    // 设置最小值
    _numberButton.minValue = 1;
    // 设置最大值
    _numberButton.maxValue = 10;
    _numberButton.increaseImage = [UIImage imageNamed:@"increase_taobao"];
    _numberButton.decreaseImage = [UIImage imageNamed:@"decrease_taobao"];
    [self addSubview:_numberButton];
    //删除按钮
    _deleteBtn = [UIButton new];
    _deleteBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100, 0, 100, 100);
    [_deleteBtn setTitle:@"删除" forState:0];
    _deleteBtn.hidden = YES;
    _deleteBtn.backgroundColor = [UIColor redColor];
    [self addSubview:_deleteBtn];
}

-(void)setModel:(ShoppingCarModel *)model{
    _productImageView.image = [UIImage imageNamed:model.imageName];
    _productNameLab.text = model.productName;
    _productPriceLab.text = [NSString stringWithFormat:@"CA$%@",model.totalPrice];
    _numberButton.textField.text = model.number;
}
@end
