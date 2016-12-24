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



if __name__ == "__main__":
    rootport = urllib2.urlopen(WEATHREROOT)
    xmlport = rootport.read()
    weatherTree = elementTree.fromstring(xmlport)
    proviceElement = weatherTree.findall("city")

    for province in proviceElement:
        provincePyName = province.get("pyName")
        pronvinceXmlPort = urllib2.urlopen(PROVINCE_BASE + provincePyName+".xml").read()
        cityTree = elementTree.fromstring(pronvinceXmlPort)
        cityElement = cityTree.findall("city")

        for city in cityElement:
            cityPyName = city.get("pyName")
            cityXmlPort = urllib2.urlopen(CITY_BASE + cityPyName + ".xml").read()

            localTree = elementTree.fromstring(cityXmlPort)
            localElement = localTree.findall("city")

            for local in localElement:
                # print(local.get("cityname").encode("utf-8"))
                localNumber = local.get("url")
                data = urllib2.urlopen(LOCAL_BASE + localNumber + ".html").read()

                weatherInfo = json.loads(data)
                print(weatherInfo.get("weatherinfo").get("city").encode("utf-8"))
                print(weatherInfo.get("weatherinfo").get("date_y").encode("utf-8"))
                print(weatherInfo.get("weatherinfo").get("temp1").encode("utf-8"))