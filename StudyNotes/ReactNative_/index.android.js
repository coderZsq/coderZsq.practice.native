/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import { Navigator } from 'react-native-deprecated-custom-components';

import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';

import Launch from './tg/component/main/launch'

export default class ReactNative_ extends Component {
  render() {
    return (
        <Navigator
            initialRoute={{name: '启动页', component: Launch}}
            configureScene={(route) => {
                return Navigator.SceneConfigs.PushFromRight;
            }}
            renderScene={(route, navigator) => {
                let Component = route.component;
                return <Component {...route.params} navigator={navigator}/>
            }}
        />
    );
  }
}

const styles = StyleSheet.create({

});

AppRegistry.registerComponent('ReactNative_', () => ReactNative_);
