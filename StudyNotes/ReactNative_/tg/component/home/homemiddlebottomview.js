import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image
} from 'react-native';

import CommonView from './homecommonview'

var HomeMiddleBottomView = React.createClass({

    getDefaultProps(){
        return {
            dataArr: []
        }
    },

    render(){
        return (
            <View style={styles.container}>
                <View style={styles.bottomViewStyle}>
                    {this.renderBottomItem()}
                </View>
            </View>
        )
    },

    renderBottomItem(){
        var dataArr = this.props.dataArr;
        var itemArr = [];
        for (var i = 0; i < dataArr.length; i++) {
            var item = dataArr[i];
            var changeItem = {
                title: item.maintitle,
                subTitle: item.title,
                rightImage: this.dealImgWithUrl(item.imageurl),
                titleColor: item.typeface_color
            }
            itemArr.push(
                <CommonView key={i} data={changeItem}/>
            )
        }
        return itemArr;
    },

    dealImgWithUrl(url){
        var wh = 'w.h';
        var replaceUrl;
        if (url.search(wh) !== -1) {
            replaceUrl = url.replace(wh, '60.50');
        }
        return replaceUrl;
    }
});

const styles = StyleSheet.create({
    container: {
        marginTop: 15
    },
    bottomViewStyle: {
        flexDirection: 'row',
        flexWrap: 'wrap'
    }
});

module.exports = HomeMiddleBottomView
