/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';

export default class ReactNative_iOS extends Component {
  render() {
    return (
        <View style={styles.outViewStyle}>
            <Text>你好</Text>
        </View>
    );
  }
}

const styles = StyleSheet.create({
    outViewStyle: {
        backgroundColor: 'green',
        width: 250,
        height: 200
    }
});

AppRegistry.registerComponent('ReactNative_iOS', () => ReactNative_iOS);
