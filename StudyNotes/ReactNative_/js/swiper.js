import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image
} from 'react-native';
import  Swiper from 'react-native-swiper'
var Dimensions = require('Dimensions');
const { width } = Dimensions.get('window')

export default class _Swiper extends Component {
  render(){
    return (
        <View style={styles.container}>
        <Swiper style={styles.wrapper} height={200} horizontal={false} autoplay>
          <View style={styles.slide1}>
            <Text style={styles.text}>Hello Swiper</Text>
          </View>
          <View style={styles.slide2}>
            <Text style={styles.text}>Beautiful</Text>
          </View>
          <View style={styles.slide3}>
            <Text style={styles.text}>And simple</Text>
          </View>
        </Swiper>

        <Swiper style={styles.wrapper} height={240}
          onMomentumScrollEnd={(e, state, context) => console.log('index:', state.index)}
          dot={<View style={{backgroundColor: 'rgba(0,0,0,.2)', width: 5, height: 5, borderRadius: 4, marginLeft: 3, marginRight: 3, marginTop: 3, marginBottom: 3}} />}
          activeDot={<View style={{backgroundColor: '#000', width: 8, height: 8, borderRadius: 4, marginLeft: 3, marginRight: 3, marginTop: 3, marginBottom: 3}} />}
          paginationStyle={{
            bottom: 5, left: null, right: 10
          }} loop>
          <View style={styles.slide}>
            <Image resizeMode='stretch' style={styles.image} source={require('../img/Castiel.jpg')} />
            <Text style={styles.titleStyle} numberOfLines={1}>Aussie tourist dies at Bali hotel</Text>
          </View>
          <View style={styles.slide}>
            <Image resizeMode='stretch' style={styles.image} source={require('../img/Castiel.jpg')} />
            <Text style={styles.titleStyle} numberOfLines={1}>Big lie behind Nine’s new show</Text>
          </View>
          <View style={styles.slide}>
            <Image resizeMode='stretch' style={styles.image} source={require('../img/Castiel.jpg')} />
            <Text style={styles.titleStyle} numberOfLines={1}>Why Stone split from Garfield</Text>
          </View>
          <View style={styles.slide}>
            <Image resizeMode='stretch' style={styles.image} source={require('../img/Castiel.jpg')} />
            <Text style={styles.titleStyle} numberOfLines={1}>Learn from Kim K to land that job</Text>
          </View>
        </Swiper>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  },

  titleStyle: {
    backgroundColor: 'rgba(0,0,0,.4)',
    position: 'absolute',
    left: 0,
    bottom: 0,
    height: 22,
    width: width,
    lineHeight: 22,
    color: 'white'
  },

  wrapper: {
  },

  slide: {
    flex: 1,
    justifyContent: 'center',
    backgroundColor: 'transparent'
  },

  slide1: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#9DD6EB'
  },

  slide2: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#97CAE5'
  },

  slide3: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#92BBD9'
  },

  text: {
    color: '#fff',
    fontSize: 30,
    fontWeight: 'bold'
  },

  image: {
    width,
    flex: 1
  }
})

module.exports = _Swiper;
