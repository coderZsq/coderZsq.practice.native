import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  TouchableOpacity,
  Switch
} from 'react-native';

var CommonCell = React.createClass({

    getDefaultProps(){
        return {
            leftTitle: '',
            isSwitch: false,
            rightTitle: '',
            leftIcon: '',
            rightIcon: ''
        }
    },

    getInitialState(){
        return {
            isSwitchOn: false
        }
    },

    render(){
        return (
            <TouchableOpacity activeOpacity={0.5} style={styles.container}>
                {this.renderLeftItem()}
                {this.renderRightItem()}
            </TouchableOpacity>
        )
    },

    renderLeftItem(){
        var temp;
        if (this.props.leftIcon !== '') {
            temp = <Image source={this.props.leftIcon} style={styles.leftImgStyle}/>
        } else {
            temp = null
        }
        return (
            <View style={styles.leftViewStyle}>
                {temp}
                <Text>{this.props.leftTitle}</Text>
            </View>
        )
    },

    renderRightItem(){
        if (this.props.isSwitch) {
            return (
                <Switch
                    onValueChange={() => {
                        this.setState({
                            isSwitchOn: !this.state.isSwitchOn
                        })
                    }}
                    value={this.state.isSwitchOn === true}
                    onTintColor='orange'
                />
            )
        } else {
            var temp;
            if (this.props.rightIcon === '') {
                temp = <Text style={{color: 'gray', marginRight: 5}}>{this.props.rightTitle}</Text>;
            } else {
                temp = <Image source={this.props.rightIcon} style={{width: 24, height: 13, marginRight: 5}}/>
            }
            return (
                <View style={styles.rightViewStyle}>
                    {temp}
                    <Image source={require('../../img/icon_cell_rightarrow.png')} style={{width: 8, height: 13}}/>
                </View>
            )
        }
    }
});

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'white',
        flexDirection: 'row',
        height: 44,
        borderWidth: 0.5,
        borderColor: '#e8e8e8',
        justifyContent: 'space-between',
        alignItems: 'center'
    },
    leftViewStyle: {
        marginLeft: 8,
        flexDirection: 'row',
        alignItems: 'center'
    },
    rightViewStyle: {
        marginRight: 8,
        flexDirection: 'row',
        alignItems: 'center'
    },
    leftImgStyle: {
        width: 30,
        height: 30,
        marginRight: 5,
        borderRadius: 15
    }
});

module.exports = CommonCell
