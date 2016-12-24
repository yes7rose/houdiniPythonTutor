#-*- coding: utf-8 -*-

import xml.etree.ElementTree as Et
import urllib, urllib2, json
import hou

#CHINAWEATHERPORT = "http://flash.weather.com.cn/wmaps/xml/china.xml"
# CHINAWEATHERPORT = "http://flash.weather.com.cn/wmaps/xml/china.xml"
CHINAWEATHERPORT = "file:///E:/chinaWeather/china.xml"
# CITYBASELINK = "http://flash.weather.com.cn/wmaps/xml/"
CITYBASELINK = "file:///E:/chinaWeather/wmaps/xml/"
# DATABASELINK = "http://m.weather.com.cn/data/"
DATABASELINK = "file:///E:/chinaWeather/data/"

def u2hex(s):
    result = ""
    for c in s:
        hexStr = "%04x"%ord(c)    
        result += r"\u"+hexStr
    
    return result

node = hou.pwd()

class China(object):
    """docstring for China"""
    def __init__(self, CHINAWEATHERPORT):
    # header = {
    #         "GET":"/wmaps/xml/china.xml HTTP/1.1",
    #         "Host": "flash.weather.com.cn",
    #         "User-Agent": "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:21.0) Gecko/20100101 Firefox/21.0",
    #         "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    #         "Accept-Language": "zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3",
    #         "Accept-Encoding": "gzip, deflate",
    #         "Cookie": "vjuids=de2c2b7a.13eacc6e2ce.0.eb92ab800d33e8; vjlast=1368698315.1368788859.13; __gads=ID=5f4c94acf8487fe7:T=1368703518:S=ALNI_MZFu0gEtYpj26efwPJvofk-xBNhPQ; Hm_lvt_9b711b58e18018800cbf37f65059e4a1=1368703532; pgv_pvi=4363183104; BIGipServerflash_pool=2042168381.20480.0000",
    #         "Connection": "keep-alive",
    #         "If-Modified-Since": "Sun, 19 May 2013 02:16:15 GMT",
    #         "Cache-Control": "max-age=0"
    #         }
    # opener = urllib.request.build_opener(urllib.request.HTTPCookieProcessor())
    # urllib.request.install_opener(opener)
    # req=urllib.request.Request(CHINAWEATHERPORT, headers=header)
        try:
            port = urllib2.urlopen(CHINAWEATHERPORT)
            
        except urllib2.URLError, e:
            print("Can't get weather port!!")
            print(e)

        self.chinaPortXml = port.read()
        
        self.provinceNames = self.getProvinceNames()
        self.provincePyNames = self.getProvincePyNames()        
        self.provinceDict = self.getProvinceDict()
        
        # self.provinces = self.getProvinces()

    def getProvincePyNames(self):
        provinceEt = Et.fromstring(self.chinaPortXml).findall("city")
        
        provincePyNames = []
        for pyName in provinceEt:
            provincePyNames.append(pyName.get("pyName"))
        
        return provincePyNames

    def getProvinceNames(self):
        provinceEt = Et.fromstring(self.chinaPortXml).findall("city")
        
        provinceNames = []
        for name in provinceEt:
            provinceNames.append(name.get("quName"))
                        
        return provinceNames
    
    def getProvinceDict(self):
        provinceEt = Et.fromstring(self.chinaPortXml).findall("city")
        
        provinceDict = {}
        for province in provinceEt:
            provinceDict[province.get("pyName")] = province.get("quName")
            
        return provinceDict
    
    # def getProvinces(self):
        
    #     provinces = []
    #     for provincePyName in self.provincePyNames:
    #         province = Province(provincePyName)
    #         provinces.append(province)
        
    #     return provinces

class Province(object):
    def __init__(self, pyName):
        try:
            port = urllib2.urlopen(CITYBASELINK + pyName + ".xml")
            
        except urllib2.URLError, e:
            print("Can't get city weather port!!")
            print(e)
            sys.exit()
            
        self.provincePortXml = port.read()
        self.provincePyName = pyName
        self.provinceName = pyName
        
        self.cityPyNames = self.getCityPyNames()
        self.cityNames = self.getCityNames()
        self.cityUrls = self.getCityUrls()
        
        # self.citys = self.getCitys()
    
    def getCityPyNames(self):
        cityEt = Et.fromstring(self.provincePortXml).findall("city")
        
        cityPyNames = []
        for city in cityEt:
            cityPyNames.append(city.get("pyName"))
            
        return cityPyNames
    
    def getCityNames(self):
        cityEt = Et.fromstring(self.provincePortXml).findall("city")
        
        cityNames = []
        for city in cityEt:
            cityNames.append(city.get("cityname"))
            
        return cityNames
    
    def getCityUrls(self):
        cityEt = Et.fromstring(self.provincePortXml).findall("city")
        
        cityNames = []
        for city in cityEt:
            cityNames.append(city.get("url"))
            
        return cityNames
    
    # def getCitys(self): 
    #     citys = []
    #     for cityPyName in self.cityPyNames:
    #         city = City(self.provincePyName, cityPyName)
    #         citys.append(city)
            
    #     return citys
    

class City(object):
    def __init__(self, province="neimenggu", cityPyName="eerduosi"):
 
        self.province = province
        self.pyName = cityPyName
        
        try:
            port = urllib2.urlopen(CITYBASELINK + self.pyName + ".xml")            
        except urllib2.URLError, e:
            print("Can't get city weather port!!")
            print(e)
            sys.exit()
            
        self.cityPortXml = port.read()
#        self.cityUrl = self.getCityUrl()
        
#        self.cityWeatherInfo = self.getCityWeatherInfo()
        
        self.localUrls = self.getLocalUrls()
        self.localPyNames = self.getLocalPyNames()
        # self.locals = self.getLocals()
    
    def getLocalUrls(self):
        cityEt = Et.fromstring(self.cityPortXml).findall("city")
        
        urls = []
        for city in cityEt:
            urls.append(city.get("url"))
            
        return urls
    
    def getLocalPyNames(self):
        localPyNames = []
        for url in self.localUrls:
            try:
                dataPort = urllib2.urlopen(DATABASELINK + url + ".html")
            except urllib2.URLError, e:
                print("Can't get city weather data port!!")
                print(e)
                sys.exit()
            dataStr =   dataPort.read()
            dataDict = json.loads(dataStr.decode("utf-8"))
#            print(self.pyName, self.province)            
            localName = dataDict.get("weatherinfo").get("city_en")
            localPyNames.append(localName)
            
        return localPyNames
    
    def getLocals(self):
        wlocals = []
        for url in self.localUrls:
            wlocal = LocalWeather(self.pyName, url)
            wlocals.append(wlocal)
        
        return wlocals
    
#    def getCityWeatherInfo(self):
#        pass
    
class LocalWeather(object):
    def __init__(self, city, url):
        
        self.city = city
        self.url = url
        self.weatherInfo = self.getWeatherInfo()
        self.pyName = self.weatherInfo.get("city_en")
        self.name = u2hex(self.weatherInfo.get("city"))
        
    def getWeatherInfo(self):
        dataStr = urllib2.urlopen(DATABASELINK + self.url + ".html").read()
        dataDict = json.loads(dataStr.decode("utf-8"))
        weatherInfo = dataDict.get("weatherinfo")
        
        return weatherInfo

node = hou.pwd()


def menuProvince():
    china = China(CHINAWEATHERPORT)

    china.provincePyNames.sort()
    
    menu = []
    for pyName in china.provincePyNames:
        menu.append(pyName)
        menu.append(pyName.capitalize())
        
    return menu

def update():
    print("updating......")

def changSheng():
    # print("province changed...")
    # cityParm = node.parm("province")
    # print cityParm.eval()
    # cityParm = cityParm.menuItems()[cityParm.eval()]
    # print cityParm
    pass

def menuCity():
    provinceParm = node.parm("province")
    province = Province(provinceParm.menuItems()[provinceParm.eval()])
    
    province.cityPyNames.sort()
    menu = []
    for cityPyName in province.cityPyNames:
        menu.append(cityPyName)
        menu.append(cityPyName.capitalize())

    return menu

def menuLocal():
    provinceParm = node.parm("province")
    cityParm =  node.parm("city")
    city = City(provinceParm.menuItems()[provinceParm.eval()],cityParm.menuItems()[cityParm.eval()])
    
    city.localPyNames.sort()
    menu = []
    for localPyName in city.localPyNames:
        menu.append(localPyName)
        menu.append(localPyName.capitalize())

    return menu

def getWeather():
    cityParm = node.parm("city")
    localParm = node.parm("local")
    provinceParm = node.parm("province")

    provincePyName = provinceParm.menuItems()[provinceParm.eval()]
    cityPyName = cityParm.menuItems()[cityParm.eval()]
    city = City(provincePyName, cityPyName)

    localPyName = localParm.menuItems()[localParm.eval()]

    wlocals = city.getLocals()

    weatherinfo = None
    wlocal = None
    for wlocal in wlocals:
        if wlocal.pyName == localPyName:
            weatherinfo=wlocal.weatherInfo
            print wlocal
            break
    name = wlocal.name
    print name
    localName = node.parm("local_name")
    print localName
    localName.set(name)
    print localName