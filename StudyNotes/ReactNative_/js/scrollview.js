import React, {Component} from 'react';
import {
    AppRegistry,
    StyleSheet,
    ScrollView,
    View,
    Text
} from 'react-native';

class _ScrollView extends Component {
    render() {
        return (
            <View>
                <ScrollView
                    horizontal={true}
                    showsHorizontalScrollIndicator={false}
                    pagingEnabled={true}
                    // scrollEnabled={false}
                    >
                    {this.renderItem()}
                </ScrollView>
            </View>
        )
    }

    renderItem() {
        var colorArr = ['red', 'green', 'blue', 'yellow', 'gray']
        var itemArr = []
        for (var i = 0; i < colorArr.length; i++) {
            itemArr.push(
                <View key={i} style={{width: 375, height: 120, backgroundColor: colorArr[i]}}>
                    <Text>{i}</Text>
                </View>
            )
        }
        return itemArr
    }
}

const styles = StyleSheet.create({

});

module.exports = _ScrollView;
