/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
} from 'react-native';

var BaseView = require('./js/baseview');
var LifeCycle = require('./js/lifecycle');
var ScrollView = require('./js/scrollview');
var Carousel = require('./js/carousel')
var Swiper = require('./js/swiper')
var ListView = require('./js/listview')
var ListView2 = require('./js/listview2')
var ListView3 = require('./js/listview3')
var TabBar = require('./js/tabbar')
var Main = require('./component/main')
var TG = require('./tg/component/main/main')

export default class ReactNative_ extends Component {
  render() {
    return (
        // <BaseView/>
        // <LifeCycle/>
        // <ScrollView/>
        // <Carousel/>
        // <Carousel imageData={require('./data/carousel.json').data}/>
        // <Swiper/>
        // <ListView/>
        // <ListView2/>
        // <ListView3/>
        // <TabBar/>
        // <Main/>
        <TG/>
    );
  }
}


AppRegistry.registerComponent('ReactNative_', () => ReactNative_);
