import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
} from 'react-native';

import CommonCell from '../main/commoncell'
import GuestYouLikeListView from './guestyoulikelistview'

var GuestYouLike = React.createClass({

    render(){
        return (
            <View style={styles.container}>
                <CommonCell
                    leftIcon={require('../../img/cnxh.png')}
                    leftTitle="猜你喜欢"
                />
                <GuestYouLikeListView/>
            </View>
        )
    },

});

const styles = StyleSheet.create({
    container: {
        marginTop: 15,
    }
});

module.exports = GuestYouLike
