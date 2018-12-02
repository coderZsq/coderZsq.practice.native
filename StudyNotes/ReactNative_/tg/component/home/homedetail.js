import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  TouchableOpacity,
  WebView
} from 'react-native';

var HomeDetail = React.createClass({

    render(){
        // alert(this.props.data);
        return (
            <WebView
                source={{uri: this.props.data}}
            />
        )
    },

    popToHome(){
        this.props.navigator.pop();
    }
});

const styles = StyleSheet.create({

});

module.exports = HomeDetail
