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

import Mall from './mall/component/main/main'

export default class ReactNative_ extends Component {
  render() {
    return (
      <Mall/>
    );
  }
}

const styles = StyleSheet.create({
  
});

AppRegistry.registerComponent('ReactNative_', () => ReactNative_);
