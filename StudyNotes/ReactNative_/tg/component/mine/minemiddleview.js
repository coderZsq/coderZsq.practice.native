import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  TouchableOpacity
} from 'react-native';

var MiddleView = React.createClass({

    getDefaultProps(){
        return {
            data: {}
        }
    },

    render(){
        return (
            <View style={styles.container}>
                {this.renderItem()}
            </View>
        )
    },

    renderItem(){
        var itemArr = [];
        for (var i = 0; i < this.props.data.length; i++) {
            var item = this.props.data[i];
            itemArr.push(
                <ChildView key={i} item={item}/>
            );
        }
        return itemArr;
    }
});

const styles = StyleSheet.create({
    container: {
        backgroundColor: 'white',
        flexDirection: 'row',
        justifyContent: 'space-around',
        paddingTop: 10,
        paddingBottom: 10
    }
});

var ChildView = React.createClass({

    getDefaultProps(){
        return {
            item: {}
        }
    },

    render(){
        var icon = this.props.item.icon;
        if (icon === 'order1') {
            icon = require('../../img//order1.png')
        } else if (icon === 'order2') {
            icon = require('../../img//order2.png')
        } else if (icon === 'order3') {
            icon = require('../../img//order3.png')
        } else if (icon === 'order4') {
            icon = require('../../img//order4.png')
        }
        return (
            <TouchableOpacity style={childStyle.viewStyle}>
                <Image source={icon} style={childStyle.imgStyle}/>
                <Text style={styles.titleStyle}>{this.props.item.title}</Text>
            </TouchableOpacity>
        )
    }
});

const childStyle = StyleSheet.create({
    imgStyle: {
        width: 60,
        height: 40,
        resizeMode: 'contain'
    },
    viewStyle: {
        justifyContent: 'center',
        alignItems: 'center'
    },
    titleStyle: {
        color: 'gray',
        marginTop: 4
    }
});

module.exports = MiddleView
