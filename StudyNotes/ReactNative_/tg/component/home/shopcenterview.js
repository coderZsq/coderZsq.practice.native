import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  ScrollView,
  TouchableOpacity
} from 'react-native';

import CommonCell from '../main/commoncell'
// import HomeDetail from '../home/homedetail'

var ShopCenterView = React.createClass({

    getDefaultProps(){
        return {
            data: {},
            pushToHome: {}
        }
    },

    render(){
        return (
            <View style={styles.container}>
                <CommonCell
                    leftIcon={require('../../img/gwzx.png')}
                    leftTitle='购物中心'
                    rightTitle={this.props.data.tips}
                />
                <ScrollView
                    horizontal={true}
                    style={{height: 130, padding: 8, backgroundColor: 'white'}}
                    showsHorizontalScrollIndicator={false}
                    >
                    {this.renderItem()}
                </ScrollView>

            </View>
        )
    },

    renderItem(){
        var dataArr = this.props.data.data;
        var itemArr = [];
        for (var i = 0; i < dataArr.length; i++) {
            var item = dataArr[i];
            itemArr.push(
                <ShopView popToPreView={(data)=>this.dealWithNextView(data)} key={i} itemObj={item}/>
            );
        }
        return itemArr;
    },

    dealWithNextView(data){
        // alert(data)
        this.props.pushToHome(data);
    }
});

const styles = StyleSheet.create({
    container: {
        marginTop: 15,
    },
    shopImageStyle: {
        width: 120,
        height: 90,
        borderRadius: 8,
    },
    shopViewStyle: {
        height: 120,
        margin: 8
    },
    showTextStyle: {
        backgroundColor: 'orange',
        position: 'absolute',
        left: 0,
        top: 60,
        padding: 2,
        borderRadius: 5,
        borderTopRightRadius: 5,
        borderBottomRightRadius: 5
    }
});

var ShopView = React.createClass({

    getDefaultProps(){
        return {
            itemObj:{},
            popToPreView: {}
        }
    },

    render(){
        var itemObj = this.props.itemObj;
        return (
            <TouchableOpacity style={styles.shopViewStyle} onPress={()=>this.pushToHomeDetail(this.props.itemObj.detailurl)}>
                <Image source={{uri: itemObj.img}} style={styles.shopImageStyle} />
                <Text>{itemObj.name}</Text>
                <View style={styles.showTextStyle}>
                    <Text style={{backgroundColor: 'rgba(0,0,0,0)', color: 'white'}}>{itemObj.showtext.text}</Text>
                </View>
            </TouchableOpacity>
        )
    },

    pushToHomeDetail(data){
        // this.props.navigator.push({
        //     title: '详情页',
        //     component: HomeDetail
        // })
        var newData = this.dealWithShopURL(data);
        this.props.popToPreView(newData);
    },

    dealWithShopURL(data){
        // const last_url =
        var realURL;
        if (data.search('imeituan:') !== -1) {
            realURL = data.replace('imeituan://www.meituan.com/web/?url=', '');
        }
        return realURL;
    }
})

module.exports = ShopCenterView
