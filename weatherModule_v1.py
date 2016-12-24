import xml.etree.ElementTree as Et
import urllib, urllib2
import hou

#CHINAWEATHERPORT = "http://flash.weather.com.cn/wmaps/xml/china.xml"
CHINAWEATHERPORT = "file:///E:/chinaWeather/china.xml"

CITYBASELINK = "file:///E:/chinaWeather/wmaps/xml/"

class Weather(object):
    """docstring for Weather"""
    def __init__(self, port = CHINAWEATHERPORT):
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

        self.portXml = port.read()
        
        self.provinceNames=self.getProvinceNames()
        self.provincePyNames=self.getProvincePyNames()
        
        self.provinceDict = self.getProvinceDict()

    def getProvincePyNames(self):
        cityEt = Et.fromstring(self.portXml).findall("city")
        
        provincePyNames = []
        for pyName in cityEt:
            provincePyNames.append(pyName.get("pyName"))
        
        return provincePyNames

    def getProvinceNames(self):
        cityEt = Et.fromstring(self.portXml).findall("city")
        
        provinceNames = []
        for name in cityEt:
            provinceNames.append(name.get("quName"))
                        
        return provinceNames
    
    def getProvinceDict(self):
        cityEt = Et.fromstring(self.portXml).findall("city")
        
        provinceDict={}
        for province in cityEt:
            provinceDict[province.get("pyName")] = province.get("quName")
            
        return provinceDict

class CityWeather(object):
    def __init__(self, province = "beijing"):
        try:
            port = urllib2.urlopen(CITYBASELINK + province +".xml")
            
        except urllib2.URLError, e:
            print("Can't get city weather port!!")
            print(e)
            sys.exit()

        self.portXml = port.read()
        self.cityPyNames= self.getCityPyName()
        self.province = province
        
    def getCityPyName(self):
        cityEt = Et.fromstring(self.portXml).findall("city")
        
        cityPyNames=[]
        for city in cityEt:
            cityPyNames.append(city.get("pyName"))
            
        return cityPyNames

node = hou.pwd()


def menuProvince():
    w = Weather(CHINAWEATHERPORT)

    w.provincePyNames.sort()
    
    menu = []
    for pyName in w.provincePyNames:
        menu.append(pyName)
        menu.append(pyName.capitalize())
        
    return menu

def update():
    print("updating......")

def changSheng():
    print("province changed...")
    cityParm = node.parm("province")
    print cityParm.eval()
    currentCity = cityParm.menuItems()[cityParm.eval()]
    print currentCity

def menuCity():
    currentProvince = node.parm("province")
    cw = CityWeather(currentProvince.menuItems()[currentProvince.eval()])
    
    cw.cityPyNames.sort()
    menu = []
    for cityPyName in cw.cityPyNames:
        menu.append(cityPyName)
        menu.append(cityPyName.capitalize())

    return menu

def menuLocal():
    currentCity =  node.parm("city")
    lw = CityWeather(currentCity.menuItems()[currentCity.eval()])
    
    lw.cityPyNames.sort()
    menu = []
    for localPyName in lw.cityPyNames:
        menu.append(localPyName)
        menu.append(localPyName.capitalize())

    return menu