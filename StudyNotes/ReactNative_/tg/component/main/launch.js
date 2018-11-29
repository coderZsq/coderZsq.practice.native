import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image
} from 'react-native';

var Dimensions = require('Dimensions');
var {width, height} = Dimensions.get('window')

import Main from './main'

var Launch = React.createClass({

    getDefaultProps(){
        return {
            durationTime: 1500
        }
    },

    render(){
        return (
            <View style={{flex: 1, backgroundColor: "#e8e8e8", justifyContent: 'center', alignItems: 'center'}}>
                <Text style={{fontSize: 24}}>启动页</Text>
            </View>
        )
    },

    componentDidMount(){
        setTimeout(() => {
            this.props.navigator.replace({
                title: '首页',
                component: Main
            });
        }, this.props.durationTime);
    }
});

const styles = StyleSheet.create({

});

module.exports = Launch
