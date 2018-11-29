import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image
} from 'react-native';

var Template = React.createClass({

    render(){
        return (
            <View style={styles.container}>
                <Text>Template</Text>
            </View>
        )
    },
});

const styles = StyleSheet.create({
    container: {
        flex: 1,
    }
});

module.exports = Template
