//
//  MarketDataModel.swift
//  SwiftfulCrypto
//
//  Created by 朱双泉 on 2023/2/27.
//
//  https://app.quicktype.io/

import Foundation

// JSON data:
/*
 
 URL: http://api.coingecko.com/api/v3/global

 JSON Response:
 {
    "data": {
        "active_cryptocurrencies": 12311,
        "upcoming_icos": 0,
        "ongoing_icos": 49,
        "ended_icos": 3376,
        "markets": 667,
        "total_market_cap": {
            "btc": 48045881.120454416,
            "eth": 687056239.841427,
            "ltc": 11909331740.778755,
            "bch": 8336914370.34366,
            "bnb": 3675323914.4996324,
            "eos": 1005829655343.2427,
            "xrp": 2989786105235.4614,
            "xlm": 12705411294177.828,
            "link": 152804958305.89243,
            "dot": 169771023836.53772,
            "yfi": 117531812.87954289,
            "usd": 1123979062143.7825,
            "aed": 4128487493160.321,
            "ars": 219920665644613.53,
            "aud": 1677549990040.2122,
            "bdt": 120574732501735.1,
            "bhd": 423726618679.4596,
            "bmd": 1123979062143.7825,
            "brl": 5857167290737.438,
            "cad": 1531074162640.696,
            "chf": 1058742193397.8937,
            "clp": 914326035150173.5,
            "cny": 7832335696642.727,
            "czk": 25233477186385.02,
            "dkk": 7939713912365.566,
            "eur": 1066740428404.1072,
            "gbp": 942141729470.1613,
            "hkd": 8819470307970.518,
            "huf": 406019214250885.4,
            "idr": 17177233252107498,
            "ils": 4141806645046.7227,
            "inr": 93193596586652.42,
            "jpy": 153331650086967.62,
            "krw": 1488781244839252.2,
            "kwd": 345458336687.07715,
            "lkr": 411029550988664.25,
            "mmk": 2364831310494934,
            "mxn": 20699586181216.297,
            "myr": 5032616250748.799,
            "ngn": 518021783309734.6,
            "nok": 11709652084702.01,
            "nzd": 1832092615168.7336,
            "php": 62527518340568.44,
            "pkr": 290482439148401.8,
            "pln": 5035518364687.227,
            "rub": 84989683527876.14,
            "sar": 4215076592149.75,
            "sek": 11819125397396.686,
            "sgd": 1518913833167.3628,
            "thb": 39497748222794.56,
            "try": 21219600714212.414,
            "twd": 34564041005535.383,
            "uah": 41386461283218.83,
            "vef": 112544023492.45663,
            "vnd": 26767781041041920,
            "zar": 20766832724525.297,
            "xdr": 846340498087.3944,
            "xag": 54428663604.73107,
            "xau": 621470503.0405395,
            "bits": 48045881120454.414,
            "sats": 4804588112045442
        },
        "total_volume": {
            "btc": 2132440.723383832,
            "eth": 30493908.55003163,
            "ltc": 528576922.72631764,
            "bch": 370020807.11380976,
            "bnb": 163123460.41186237,
            "eos": 44642164277.59351,
            "xrp": 132696945010.27681,
            "xlm": 563909659250.9203,
            "link": 6782007286.1091,
            "dot": 7535019369.755628,
            "yfi": 5216464.309377935,
            "usd": 49886039519.95749,
            "aed": 183236411760.75555,
            "ars": 9760832196177.61,
            "aud": 74455412843.93155,
            "bdt": 5351519501811.151,
            "bhd": 18806438266.549706,
            "bmd": 49886039519.95749,
            "brl": 259961140542.44928,
            "cad": 67954314059.73018,
            "chf": 46990603900.17957,
            "clp": 40580920285677.68,
            "cny": 347625877790.8714,
            "czk": 1119948122294.221,
            "dkk": 352391690690.37085,
            "eur": 47345592957.40351,
            "gbp": 41815476046.41876,
            "hkd": 391438291999.2747,
            "huf": 18020523024111.918,
            "idr": 762384430207958,
            "ils": 183827561329.06696,
            "inr": 4136250931099.6377,
            "jpy": 6805383670857.265,
            "krw": 66077209547807.13,
            "kwd": 15332623904.577457,
            "lkr": 18242898924987.16,
            "mmk": 104959311242304.83,
            "mxn": 918718514483.1697,
            "myr": 223364741950.61023,
            "ngn": 22991580559427.26,
            "nok": 519714455844.25946,
            "nzd": 81314543733.76761,
            "php": 2775185371401.0205,
            "pkr": 12892605322711.152,
            "pln": 223493547704.64954,
            "rub": 3772133177617.8076,
            "sar": 187079532473.29388,
            "sek": 524573256321.42413,
            "sgd": 67414596998.16377,
            "thb": 1753045314770.8218,
            "try": 941798540097.275,
            "twd": 1534070494411.9294,
            "uah": 1836872867745.4087,
            "vef": 4995089137.133329,
            "vnd": 1188045781144778.8,
            "zar": 921703146341.6093,
            "xdr": 37563489353.97454,
            "xag": 2415730466.0331354,
            "xau": 27582988.971374862,
            "bits": 2132440723383.8318,
            "sats": 213244072338383.2
        },
        "market_cap_percentage": {
            "btc": 40.176257672548296,
            "eth": 17.53628857943355,
            "usdt": 6.305091566994409,
            "bnb": 4.297794885518179,
            "usdc": 3.8004002287011853,
            "xrp": 1.7046494940871946,
            "okb": 1.1447931583105841,
            "ada": 1.1354770061895136,
            "matic": 1.013547751482804,
            "doge": 1.0022010263685477
        },
        "market_cap_change_percentage_24h_usd": 1.148120477200766,
        "updated_at": 1677480947
    }
 }
 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return item.value.asPrecentString()
        }
        return ""
    }
}
