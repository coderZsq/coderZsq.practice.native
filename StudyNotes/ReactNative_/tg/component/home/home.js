import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  TouchableOpacity,
  TextInput,
  Platform,
  ScrollView
} from 'react-native';

var Dimensions = require('Dimensions');
var {width, height} = Dimensions.get('window')

var TopMenu = require('../../data/TopMenu.json')
var TopMiddleData = require('../../data/HomeTopMiddleLeft.json')
var MiddleBottomData = require('../../data/XMG_Home_D4.json')
var shopCenterData = require('../../data/XMG_Home_D5.json')

var HomeDetail = require('./homedetail')
import HomeTopMenu from './hometopmenu'
import HomeMiddleView from './homemiddleview'
import HomeMiddleBottomView from './homemiddlebottomview'
import ShopCenterView from './shopcenterview'

var Home = React.createClass({

    render(){
        return (
            <View style={{flex: 1, backgroundColor: '#e8e8e8'}}>
                {this.renderNavBar()}
                <ScrollView>
                    <HomeTopMenu data={TopMenu.data}/>
                    <HomeMiddleView dataObj={TopMiddleData}/>
                    <HomeMiddleBottomView dataArr={MiddleBottomData.data}/>
                    <ShopCenterView pushToHome={(data)=>this.pushToHomeDetail(data)} data={shopCenterData}/>
                </ScrollView>
            </View>
        )
    },

    renderNavBar(){
        return (
            <View style={styles.navBarStyle}>
                <TouchableOpacity onPress={this.pushToHomeDetail}>
                    <Text style={{color: 'white'}}>广州</Text>
                </TouchableOpacity>
                <View>
                    <TextInput
                        placeholder='搜索商家 商圈 品类'
                        style={styles.textInputStyle}
                    />
                </View>
                <View style={styles.navRightViewStyle}>
                    <Image source={require('../../img/icon_homepage_message.png')} style={styles.navBarImgStyle}/>
                    <Image source={require('../../img/icon_homepage_scan.png')} style={styles.navBarImgStyle}/>
                </View>
            </View>
        )
    },

    pushToHomeDetail(data){
        this.props.navigator.push({
            title: '详情页',
            component: HomeDetail,
            params: {data}
        })
    }
});

const styles = StyleSheet.create({
    navBarStyle: {
        height: Platform.OS === 'ios' ? 64 : 54,
        backgroundColor: 'rgba(255, 96, 0, 0.7)',
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-around',
        paddingTop: Platform.OS === 'ios' ? 15 : 0
    },
    textInputStyle: {
        backgroundColor: 'white',
        width: width * 0.68,
        height: 38,
        borderRadius: Platform.OS === 'ios' ? 19 : 0,
        paddingLeft: 15
    },
    navBarImgStyle: {
        width: 30,
        height: 30
    },
    navRightViewStyle: {
        flexDirection: 'row',
    }
});

module.exports = Home
