import hou
import random

# This code is called when instances of this SOP cook.
node = hou.pwd()
geo = node.geometry()

# Add code to modify the contents of geo.

random.seed(123)

colorAttrib = geo.addAttrib(hou.attribType.Point, "Cd", (1.0, 1.0, 1.0))
color = hou.Color()
numPoints = len(geo.points())
# print numPoints
for point in geo.points():
    pos = point.position()
    
    px = pos[0]
    py = pos[1]+random.random()*random.choice([-1, 1])
    pz = pos[2]

    point.setPosition((px, py, pz))

    value = float(point.number())/numPoints
#    print value
    color.setHSV((value*255, 1.0, 1.0))
    point.setAttribValue(colorAttrib, color.rgb())