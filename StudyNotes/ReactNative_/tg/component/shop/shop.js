import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  WebView
} from 'react-native';

import CommonNavBar from '../main/commonnavbar'

let RequestURL = 'https://coderzsq.github.io/';

var Shop = React.createClass({

    render(){
        return (
            <View>
                <CommonNavBar
                    leftIconName={require('../../img/icon_shop_local@2x.png')}
                    navTitle="商家"
                    rightIconName={require('../../img/icon_shop_search@2x.png')}
                />
                <WebView
                    source={{uri: RequestURL}}
                />
            </View>

        )
    },
});

const styles = StyleSheet.create({

});

module.exports = Shop
