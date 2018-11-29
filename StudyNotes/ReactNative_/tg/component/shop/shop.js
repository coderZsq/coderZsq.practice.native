import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image
} from 'react-native';

import CommonNavBar from '../main/commonnavbar'

var Shop = React.createClass({

    render(){
        return (
            <CommonNavBar
                leftIconName={require('../../img/icon_shop_local@2x.png')}
                navTitle="商家"
                rightIconName={require('../../img/icon_shop_search@2x.png')}
            />
        )
    },
});

const styles = StyleSheet.create({

});

module.exports = Shop
