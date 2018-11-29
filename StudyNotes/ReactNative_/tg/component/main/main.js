import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  Platform,
} from 'react-native';

import TabNavigator from 'react-native-tab-navigator';
import { Navigator } from 'react-native-deprecated-custom-components';

var Home = require('../home/home')
var Shop = require('../shop/shop')
var Mine = require('../mine/mine')
var More = require('../more/more')

var Main = React.createClass({

    getInitialState() {
        return {
            selectedTab: 'home'
        }
    },

    render(){
        return (
            <TabNavigator>
                {this.renderItemTabItem('首页', require('../../img/icon_tabbar_homepage.png'), require('../../img/icon_tabbar_homepage_selected.png'), 'home', Home)}
                {this.renderItemTabItem('商家', require('../../img/icon_tabbar_merchant_normal.png'), require('../../img/icon_tabbar_merchant_selected.png'), 'shop', Shop)}
                {this.renderItemTabItem('我的', require('../../img/icon_tabbar_mine.png'), require('../../img/icon_tabbar_mine_selected.png'), 'mine', Mine)}
                {this.renderItemTabItem('更多', require('../../img/icon_tabbar_misc.png'), require('../../img/icon_tabbar_misc_selected.png'), 'more', More)}
            </TabNavigator>
        )
    },

    renderItemTabItem(title, renderIcon, renderSelectedIcon, selectedTab, component){
        return (
            <TabNavigator.Item
                title={title}
                renderIcon={() => <Image source={renderIcon} style={styles.tabIconStyle} />}
                renderSelectedIcon={() => <Image source={renderSelectedIcon} style={styles.tabIconStyle} />}
                onPress={() => this.setState({selectedTab: selectedTab})}
                selected={this.state.selectedTab === selectedTab}
                selectedTitleStyle={styles.selectedTitleStyle}
                >
                <Navigator
                    initialRoute={{name: title, component: component}}
                    configureScene={(route) => {
                        return Navigator.SceneConfigs.PushFromRight;
                    }}
                    renderScene={(route, navigator) => {
                        let Component = route.component;
                        return <Component {...route.params} navigator={navigator}/>
                    }}
                />
            </TabNavigator.Item>
        )
    }
});

const styles = StyleSheet.create({
    tabIconStyle: {
        width: Platform.OS === 'ios' ? 30 : 25,
        height: Platform.OS === 'ios' ? 30: 25
    },
    selectedTitleStyle: {
        color: 'orange'
    }
});

module.exports = Main
