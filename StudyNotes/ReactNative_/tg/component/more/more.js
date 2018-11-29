import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  ScrollView
} from 'react-native';

import CommonNavBar from '../main/commonnavbar'
import CommonCell from '../main/commoncell'

var More = React.createClass({

    render(){
        return (
            <View style={styles.container}>
                <CommonNavBar
                    navTitle="更多"
                    rightIconName={require('../../img/icon_mine_setting@2x.png')}
                />
                <ScrollView style={{backgroundColor: '#e8e8e8'}}>
                    <View style={{marginTop: 15}}>
                        <CommonCell leftTitle='扫一扫'/>
                    </View>
                    <View style={{marginTop: 15}}>
                        <CommonCell leftTitle='省流量模式' isSwitch={true}/>
                        <CommonCell leftTitle='消息提醒'/>
                        <CommonCell leftTitle='邀请好友使用'/>
                        <CommonCell leftTitle='清空缓存' rightTitle='100M'/>
                    </View>
                </ScrollView>
            </View>

        )
    },
});

const styles = StyleSheet.create({
    container: {
        flex: 1,
    }
});

module.exports = More
