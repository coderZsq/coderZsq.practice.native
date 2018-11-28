import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image
} from 'react-native';

import TabNavigator from 'react-native-tab-navigator';

var Main = React.createClass({

    render(){
        return (
            <TabNavigator>
                <TabNavigator.Item
                    title="首页"
                    renderIcon={() => <Image source={require('../../img/icon_tabbar_homepage.png')} style={styles.tabIconStyle} />}
                    renderSelectedIcon={() => <Image source={require('../../img/icon_tabbar_homepage_selected.png')} style={styles.tabIconStyle} />}
                    >
                </TabNavigator.Item>
            </TabNavigator>
        )
    },
});

const styles = StyleSheet.create({
    tabIconStyle: {
        width: 30,
        height: 30
    }
});

module.exports = Main
