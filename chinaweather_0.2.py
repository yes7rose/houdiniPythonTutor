#-*- coding: utf-8 -*-
__author__ = 'yan'

import urllib2
import xml.etree.ElementTree as elementTree
import json

# WEATHREROOT = "http://flash.weather.com.cn/wmaps/xml/china.xml"
WEATHREROOT = "file:///E:/houWeather/wmaps/xml/china.xml"
# PROVINCE_BASE = "http://flash.weather.com.cn/wmaps/xml/"
PROVINCE_BASE = "file:///E:/houWeather/wmaps/xml/"
# CITY_BASE = "http://flash.weather.com.cn/wmaps/xml/"
CITY_BASE = "file:///E:/houWeather/wmaps/xml/"
# LOCAL_BASE = "http://m.weather.com.cn/data/"
LOCAL_BASE = "file:///E:/houWeather/data/"

def u2hex(s):
    result = ""
    for c in s:
        result = result + r"\u" + "%04x"%ord(c)
    return result

class China(object):
    def __init__(self, WEATHREROOT):

        self.chinaXmlPort = ""
        try:
            rootport = urllib2.urlopen(WEATHREROOT)
            self.chinaXmlPort = rootport.read()
        except urllib2.URLError, e:
            print(e)
            print("can not open: " + WEATHREROOT)

        self.provincePyNames = self._getProvincePyNames()
        self.provinceNameDict = self._getProvinceNameDict()

    def _getProvincePyNames(self):
        provinceTree = elementTree.fromstring(self.chinaXmlPort)
        proviceElement = provinceTree.findall("city")

        provincePyNames = []
        for province in proviceElement:
            provincePyName = province.get("pyName")
            provincePyNames.append(provincePyName)

        return provincePyNames

    def _getProvinceNameDict(self):
        provinceTree = elementTree.fromstring(self.chinaXmlPort)
        proviceElement = provinceTree.findall("city")

        provinceNameDict = dict()
        for province in proviceElement:
            provincePyName = province.get("pyName")
            provinceName = province.get("quName")
            provinceNameDict[provincePyName] = provinceName

        return provinceNameDict

class Province(object):
    def __init__(self, provicePyName = "neimenggu"):

        self.provincePyName = provicePyName
        self.provinceXmlPort = ""
        try:
            provincePort = urllib2.urlopen(PROVINCE_BASE + provicePyName + ".xml")
            self.provinceXmlPort = provincePort.read()
        except urllib2.URLError, e:
            print(e)
            print("can not open: " + PROVINCE_BASE + provicePyName + ".xml")

        self.cityPyNames = self._getCityPyNames()
        self.cityNameDict = self._getCityNameDict()

    def _getCityPyNames(self):
        cityTree = elementTree.fromstring(self.provinceXmlPort)
        cityElement = cityTree.findall("city")

        cityPyNames = []
        for city in cityElement:
            cityPyName = city.get("pyName")
            cityPyNames.append(cityPyName)

        return cityPyNames

    def _getCityNameDict(self):
        cityTree = elementTree.fromstring(self.provinceXmlPort)
        cityElement = cityTree.findall("city")

        cityNameDict = dict()
        for city in cityElement:
            cityPyName = city.get("pyName")
            cityName = city.get("quName")
            cityNameDict[cityPyName] = cityName

        return cityNameDict

class City(object):
    def __init__(self, cityPyName = "eerduosi"):

        self.cityPyName = cityPyName
        self.cityXmlPort = ""
        try:
            cityXmlPort = urllib2.urlopen(CITY_BASE +  cityPyName + ".xml")
            self.cityXmlPort = cityXmlPort.read()
        except urllib2.URLError, e:
            print(e)
            print("can not open: " + CITY_BASE + cityPyName + ".xml")

        self.localNumbers = self._getLocalNumbers()
        self.localPyNames = self._getLocalPyNames()
        self.localNameDict = self._getLocalNameDict()
        self.localNumberDict = self._getLocalNumberDict()

    def _getLocalNumbers(self):
        localTree = elementTree.fromstring(self.cityXmlPort)
        localElement = localTree.findall("city")

        localNumbers = []
        for city in localElement:
            localUrl = city.get("url")
            localNumbers.append(localUrl)

        return localNumbers

    def _getLocalPyNames(self):

        localPyNames = []
        for localNumer in self.localNumbers:
            dataStr = ""
            try:
                dataPort = urllib2.urlopen(LOCAL_BASE + localNumer + ".html")
                dataStr = dataPort.read()
            except urllib2.URLError, e:
                print(e)
                print("can not open: " + LOCAL_BASE + localNumer + ".html")

            localData = json.loads(dataStr)
            localPyName = localData.get("weatherinfo").get("city_en")
            localPyNames.append(localPyName)

        return localPyNames


    def _getLocalNameDict(self):

        localNameDict = dict()
        for localNumer in self.localNumbers:
            dataStr = ""
            try:
                dataPort = urllib2.urlopen(LOCAL_BASE + localNumer + ".html")
                dataStr = dataPort.read()
            except urllib2.URLError, e:
                print(e)
                print("can not open: " + LOCAL_BASE + localNumer + ".html")

            localData = json.loads(dataStr)
            localPyName = localData.get("weatherinfo").get("city_en")
            localName = localData.get("weatherinfo").get("city").encode("utf-8")
            localNameDict[localPyName] = localName

        return localNameDict

    def _getLocalNumberDict(self):
        localNumberDict = dict()
        for localNumer in self.localNumbers:
            dataStr = ""
            try:
                dataPort = urllib2.urlopen(LOCAL_BASE + localNumer + ".html")
                dataStr = dataPort.read()
            except urllib2.URLError, e:
                print(e)
                print("can not open: " + LOCAL_BASE + localNumer + ".html")

            localData = json.loads(dataStr)
            localPyName = localData.get("weatherinfo").get("city_en")
            localNumberDict[localPyName] = localNumer

        return localNumberDict

class Local(object):
    def __init__(self, localNumber):
        self.number = localNumber
        self.weatherInfo = self._getLocalWeatherInfo()
        self.name = self.weatherInfo.get("city")

    # def _getLocalName(self):
    #
    #     try:
    #         dataPort = urllib2.urlopen(LOCAL_BASE + self.localNumber + ".html")
    #         dataStr = dataPort.read()
    #     except urllib2.URLError, e:
    #         print(e)
    #         print("can not open: " + LOCAL_BASE + self.localNumber + ".html")
    #
    #     localData = json.loads(dataStr)
    #     localName = localData.get("weatherinfo").get("city")
    #
    #     return localName

    def _getLocalWeatherInfo(self):
        try:
            dataPort = urllib2.urlopen(LOCAL_BASE + self.number + ".html")
            dataStr = dataPort.read()
        except urllib2.URLError, e:
            print(e)
            print("can not open: " + LOCAL_BASE + self.number + ".html")

        localData = json.loads(dataStr)
        weatherinfo = localData.get("weatherinfo")

        return weatherinfo


if __name__ == "__main__":
    # rootport = urllib2.urlopen(WEATHREROOT)
    # xmlport = rootport.read()
    # weatherTree = elementTree.fromstring(xmlport)
    # proviceElement = weatherTree.findall("city")
    #
    # for province in proviceElement:
    #     provincePyName = province.get("pyName")
    #     pronvinceXmlPort = urllib2.urlopen(PROVINCE_BASE + provincePyName+".xml").read()
    #     cityTree = elementTree.fromstring(pronvinceXmlPort)
    #     cityElement = cityTree.findall("city")
    #
    #     for city in cityElement:
    #         cityPyName = city.get("pyName")
    #         cityXmlPort = urllib2.urlopen(CITY_BASE + cityPyName + ".xml").read()
    #
    #         localTree = elementTree.fromstring(cityXmlPort)
    #         localElement = localTree.findall("city")
    #
    #         for local in localElement:
    #             # print(local.get("cityname").encode("utf-8"))
    #             localNumber = local.get("url")
    #             data = urllib2.urlopen(LOCAL_BASE + localNumber + ".html").read()
    #
    #             weatherInfo = json.loads(data)
    #             print(weatherInfo.get("weatherinfo").get("city").encode("utf-8"))
    #             print(weatherInfo.get("weatherinfo").get("date_y").encode("utf-8"))
    #             print(weatherInfo.get("weatherinfo").get("temp1").encode("utf-8"))

    # china = China(WEATHREROOT)
    # for provincePyName in china.provincePyNames:
    #     province = Province(provincePyName)
    #
    #     for cityName in province.cityPyNames:
    #         city = City(cityName)
    #
    #         for localNumber in city.localNumbers:
    #             local = Local(localNumber)
    #             print local.number
    #             print(local.name.encode("utf-8"))
    #             print(local.weatherInfo)

    test = "你好！"
    print u2hex(test)