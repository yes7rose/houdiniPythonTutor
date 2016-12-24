import xml.etree.ElementTree as Et
import urllib, urllib2

#CHINAWEATHERPORT = "http://flash.weather.com.cn/wmaps/xml/china.xml"
CHINAWEATHERPORT = "file:///E:/chinaWeather/china.xml"

CITYBASELINK = "http://flash.weather.com.cn/wmaps/xml/"

class Weather(object):
    """docstring for Weather"""
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

        self.portXml = port.read().decode("utf-8")

    def getProvincePyNames(self):
        self.provincePyNames = []
        for pyName in cityEt:
            provincePyNames.append(pyName)
        
        return provincePyNames

    def function(self):
        pass




node = hou.pwd()

def menuSheng():
    print "menu....."
    return ("one", "xxx", "tow", "yyy")

def update():
    print("updating......")

def menuCall():
    print("beijing")

def changSheng():
    print("sheng changed...")
    cityParm = node.parm("sheng")
    currentCity = cityParm.menuItems()[cityParm.eval()]
    print currentCity