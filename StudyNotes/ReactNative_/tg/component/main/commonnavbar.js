import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  TouchableOpacity,
  Platform
} from 'react-native';

var Dimensions = require('Dimensions');
var {width, height} = Dimensions.get('window')

var CommonNavBar = React.createClass({

    getDefaultProps(){
        return {
            leftIconName: {uri: 'null'},
            navTitle: '',
            rightIconName: {uri: 'null'}
        }
    },

    render(){
        return (
            <View style={styles.navBarStyle}>
                <TouchableOpacity style={styles.navBarLeftViewStyle}>
                    <Image source={this.props.leftIconName} style={styles.navBarImgStyle}/>
                </TouchableOpacity>
                <View>
                    <Text style={{color: 'white', fontSize: 17, fontWeight: 'bold'}}>{this.props.navTitle}</Text>
                </View>
                <View style={styles.navRightViewStyle}>
                    <Image source={this.props.rightIconName} style={styles.navBarImgStyle}/>
                </View>
            </View>
        )
    },
});

const styles = StyleSheet.create({
    navBarStyle: {
        height: Platform.OS === 'ios' ? 64 : 54,
        backgroundColor: 'rgba(255, 96, 0, 0.7)',
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-between',
        paddingTop: Platform.OS === 'ios' ? 15 : 0
    },
    navBarImgStyle: {
        width: 30,
        height: 30
    },
    navRightViewStyle: {
        flexDirection: 'row',
        marginRight: 8
    },
    navBarLeftViewStyle: {
        marginLeft: 8
    }
});

module.exports = CommonNavBar
