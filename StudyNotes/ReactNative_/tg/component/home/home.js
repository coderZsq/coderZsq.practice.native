import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  TouchableOpacity
} from 'react-native';

var HomeDetail = require('./homedetail')

var Home = React.createClass({

    render(){
        return (
            <TouchableOpacity onPress={() => this.pushToHomeDetail()}>
                <Text>Home</Text>
            </TouchableOpacity>
        )
    },

    pushToHomeDetail(){
        this.props.navigator.push({
            title: '详情页',
            component: HomeDetail
        })
    }
});

const styles = StyleSheet.create({

});

module.exports = Home
