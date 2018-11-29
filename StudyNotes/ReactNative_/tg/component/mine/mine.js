import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  ScrollView
} from 'react-native';

import CommonCell from '../main/commoncell';
import MineMiddleView from './minemiddleview';
import MineTopView from './minetopview';

var MiddleDataArr = require('./middledata.json');
var TopData = require('./topdata.json');

var Mine = React.createClass({

    render(){
        return (
            <ScrollView
                style={{backgroundColor: '#e8e8e8'}}
                contentInset={{top: -300}}
                contentOffset={{y: 300}}
                >
                <MineTopView data={TopData}/>
                <View style={{marginTop: 15}}>
                    <CommonCell
                        leftIcon={require('../../img/collect.png')}
                        leftTitle='我的订单'
                        rightTitle='查看全部订单'
                        />
                    <MineMiddleView data={MiddleDataArr}/>
                </View>
                <View style={{marginTop: 15}}>
                    <CommonCell
                        leftIcon={require('../../img/draft.png')}
                        leftTitle='Castiel 钱包'
                        rightTitle='£666.66'
                    />
                    <CommonCell
                        leftIcon={require('../../img/like.png')}
                        leftTitle='抵用券'
                        rightTitle='0'
                    />
                </View>
                <View style={{marginTop: 15}}>
                    <CommonCell
                        leftIcon={require('../../img/card.png')}
                        leftTitle='积分商城'
                    />
                </View>
                <View style={{marginTop: 15}}>
                    <CommonCell
                        leftIcon={require('../../img/new_friend.png')}
                        leftTitle='今日推荐'
                        rightIcon={require('../../img/me_new.png')}
                    />
                </View>
                <View style={{marginTop: 15}}>
                    <CommonCell
                        leftIcon={require('../../img/pay.png')}
                        leftTitle='我要合作'
                        rightTitle='轻松开店, 招财进宝'
                    />
                </View>
            </ScrollView>
        )
    },
});

const styles = StyleSheet.create({

});

module.exports = Mine
