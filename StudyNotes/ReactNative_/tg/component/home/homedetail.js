import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  TouchableOpacity
} from 'react-native';

var HomeDetail = React.createClass({

    render(){
        return (
            <TouchableOpacity onPress={() => this.popToHome()}>
                <Text>HomeDetail</Text>
            </TouchableOpacity>
        )
    },

    popToHome(){
        this.props.navigator.pop();
    }
});

const styles = StyleSheet.create({

});

module.exports = HomeDetail
