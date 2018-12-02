import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  TouchableOpacity
} from 'react-native';

var Dimensions = require('Dimensions');
var {width, height} = Dimensions.get('window')

var HomeCommonView = React.createClass({

    getDefaultProps(){
        return {
            data: {}
        }
    },

    render(){
        return (
            <TouchableOpacity style={styles.container}>
                <View style={styles.leftViewStyle}>
                    <Text style={{color: this.props.data.titleColor, fontSize: 20}}>{this.props.data.title}</Text>
                    <Text numberOfLine={1} style={{color: 'gray', marginTop: 4}}>{this.props.data.subTitle}</Text>
                </View>
                <Image source={{uri: this.props.data.rightImage}} style={styles.rightImgStyle}/>
            </TouchableOpacity>
        )
    },
});

const styles = StyleSheet.create({
    container: {
        backgroundColor: 'white',
        flexDirection: 'row',
        width: width * 0.5 - 1,
        height: 65,
        marginBottom: 1,
        alignItems: 'center',
        justifyContent: 'space-between',
        paddingLeft: 9,
        paddingRight: 9,
        marginRight: 1

    },
    rightImgStyle: {
        width: 60,
        height: 50,
        resizeMode: 'contain'
    },
    leftViewStyle: {
        flex: 1
    }
});

module.exports = HomeCommonView
