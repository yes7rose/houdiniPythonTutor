0707070000010000000006660000000000000000010000001213715700100000700000000237.start fplayback -i on -r off -f 1 -e on -h on -t on -a on -k on -s 1
tcur 0
fps 24
tset 0 10
frange 1 240
unitlength 1
unitmass 1
prompt '`strcat(oppwf(), " -> ")`'
0707070000010000000006660000000000000000010000001213715700100001300000000653.variables set -g ACTIVETAKE = 'Main'
set -g E = '2.7182818284590452354'
set -g EYE = 'stereo'
set -g HIP = 'E:/HoudiniPython'
set -g HIPNAME = 'pyQtTest.hip'
set -g JOB = 'C:/Users/yan'
set -g PI = '3.1415926535897932384'
set -g POSE = 'C:/Users/yan/Documents/houdini12.5/poselib'
set -g _HIP_SAVEPLATFORM = 'windows-x86_64-cl15'
set -g _HIP_SAVETIME = 'Sun Apr 28 16:29:53 2013'
set -g _HIP_SAVEVERSION = '12.5.371'
set -g status = '0'
0707070000010000000006660000000000000000010000001213715700100001100000000267.aliases alias cd 'opcf'
alias cp 'opcp'
alias h 'history'
alias hython 'python'
alias ls 'opls'
alias matramp 'opramp'
alias opcd 'opcf'
alias oppwd 'oppwf'
alias pwd 'oppwf'
alias rm 'oprm'
0707070000010000000006660000000000000000010000001213715700100001400000000021.takeconfig takename -g take
0707070000010000000006660000000000000000010000001213715700100001500000006662.hou.session import hou
from PyQt4 import QtCore
from PyQt4 import QtGui

class IntegratedEventLoop(object):
    """This class behaves like QEventLoop except it allows PyQt to run inside
    Houdini's event loop on the main thread.  You probably just want to
    call exec_() below instead of using this class directly.
    """
    def __init__(self, application, dialogs):
        # We need the application to send posted events.  We hold a reference
        # to any dialogs to ensure that they don't get garbage collected
        # (and thus close in the process).  The reference count for this object
        # will go to zero when it removes itself from Houdini's event loop.
        self.application = application
        self.dialogs = dialogs
        self.event_loop = QtCore.QEventLoop()

    def exec_(self):
        hou.ui.addEventLoopCallback(self.processEvents)

    def processEvents(self):
        # There is no easy way to know when the event loop is done.  We can't
        # use QEventLoop.isRunning() because it always returns False since
        # we're not inside QEventLoop.exec_().  We can't rely on a
        # lastWindowClosed signal because the window is usually made invisible
        # instead of closed.  Instead, we need to explicitly check if any top
        # level widgets are still visible.
        if not anyQtWindowsAreOpen():
            hou.ui.removeEventLoopCallback(self.processEvents)

        self.event_loop.processEvents()
        self.application.sendPostedEvents(None, 0)

def anyQtWindowsAreOpen():
    return any(w.isVisible() for w in QtGui.QApplication.topLevelWidgets())

def exec_(application, *args):
    """You cannot call QApplication.exec_, or Houdini will freeze while PyQt
    waits for and processes events.  Instead, call this function to allow
    Houdini's and PyQt's event loops to coexist.  Pass in any dialogs as
    extra arguments, if you want to ensure that something holds a reference
    to them while the event loop runs.

    This function returns right away.
    """
    IntegratedEventLoop(application, args).exec_()

def execSynchronously(application, *args):
    """This function is like exec_, except it will not return until all PyQt
    windows have closed.  Houdini will remain responsive while the PyQt window
    is open.
    """
    exec_(application, *args)
    hou.ui.waitUntil(lambda: not anyQtWindowsAreOpen())

class FontDialog(QtGui.QWidget):
    def __init__(self, parent=None):
        QtGui.QWidget.__init__(self, parent)

        hbox = QtGui.QHBoxLayout()

        self.setGeometry(500, 300, 250, 110)
        self.setWindowTitle('FontDialog')

        button = QtGui.QPushButton('Change Font...', self)
        button.setFocusPolicy(QtCore.Qt.NoFocus)
        button.move(20, 20)

        hbox.addWidget(button)

        self.connect(button, QtCore.SIGNAL('clicked()'), self.showDialog)

        self.label = QtGui.QLabel('This is some Sample Text', self)
        self.label.move(130, 20)

        hbox.addWidget(self.label, 1)
        self.setLayout(hbox)

    def showDialog(self):
        font, ok = QtGui.QFontDialog.getFont()
        if ok:
            self.label.setFont(font)

def showFdlg():
    app = QtGui.QApplication.instance()
    if app is None:
        app = QtGui.QApplication(['houdini'])
    dialog = FontDialog()
    dialog.show()

    # The main difference from a normal PyQt application is that instead of calling
    # app.exec_() you call pyqt_houdini.exec_(app, dialog1, ...).
    exec_(app, dialog)
0707070000010000000006660000000000000000010000001213715700100001500000000000.OPlibraries 0707070000010000000006660000000000000000010000001213715700100001700000000000.OPpreferences 0707070000010000000006660000000000000000010000001213715700100002000000000012expression.func # 0 bytes
0707070000010000000006660000000000000000010000001213715700100001000000000645vex.def comment ""
position 5.5 2.5
cachesize 1
connectornextid 0
flags =  lock off model off template off footprint off xray off bypass off display off render off highlight off unload off savedata off compress off exposed on
outputsNamed3
{
}
inputsNamed3
{
}
inputs
{
}
stat
{
  create 1367133223
  modify 1367133224
  author yan@YanGang-PC
  access 0777
}
color UT_Color RGB 0.8 0.8 0.8 
delscript ""
exprlanguage hscript
end
0707070000010000000006660000000000000000010000001213715700100001100000000020vex.parm {
version 0.8
}
0707070000010000000006660000000000000000010000001213715700100001500000000041vex.userdata     ___Version___    12.5.3710707070000010000000006660000000000000000010000001213715700100001000000000637obj.def comment ""
position 5 2
cachesize 1
connectornextid 0
flags =  lock off model off template off footprint off xray off bypass off display on render on highlight off unload off savedata off compress off exposed on
outputsNamed3
{
}
inputsNamed3
{
}
inputs
{
}
stat
{
  create 1367133223
  modify 1367133229
  author yan@YanGang-PC
  access 0777
}
color UT_Color RGB 0.8 0.8 0.8 
delscript ""
exprlanguage hscript
end
0707070000010000000006660000000000000000010000001213715700100001100000000020obj.parm {
version 0.8
}
0707070000010000000006660000000000000000010000001213715700100001500000000041obj.userdata     ___Version___    12.5.3710707070000010000000006660000000000000000010000001213715700100001000000000002obj.net 1
0707070000010000000006660000000000000000010000001213715700100001000000000643out.def comment ""
position 5 0.5
cachesize 1
connectornextid 0
flags =  lock off model off template off footprint off xray off bypass off display off render off highlight off unload off savedata off compress off exposed on
outputsNamed3
{
}
inputsNamed3
{
}
inputs
{
}
stat
{
  create 1367133223
  modify 1367133224
  author yan@YanGang-PC
  access 0777
}
color UT_Color RGB 0.8 0.8 0.8 
delscript ""
exprlanguage hscript
end
0707070000010000000006660000000000000000010000001213715700100001100000000020out.parm {
version 0.8
}
0707070000010000000006660000000000000000010000001213715700100001500000000041out.userdata     ___Version___    12.5.3710707070000010000000006660000000000000000010000001213715700100001000000000002out.net 1
0707070000010000000006660000000000000000010000001213715700100001100000000645part.def comment ""
position 5.5 1.5
cachesize 1
connectornextid 0
flags =  lock off model off template off footprint off xray off bypass off display off render off highlight off unload off savedata off compress off exposed on
outputsNamed3
{
}
inputsNamed3
{
}
inputs
{
}
stat
{
  create 1367133223
  modify 1367133224
  author yan@YanGang-PC
  access 0777
}
color UT_Color RGB 0.8 0.8 0.8 
delscript ""
exprlanguage hscript
end
0707070000010000000006660000000000000000010000001213715700100001200000000020part.parm {
version 0.8
}
0707070000010000000006660000000000000000010000001213715700100001600000000041part.userdata     ___Version___    12.5.3710707070000010000000006660000000000000000010000001213715700100001100000000002part.net 1
0707070000010000000006660000000000000000010000001213715700100000700000000643ch.def comment ""
position 4.5 1
cachesize 1
connectornextid 0
flags =  lock off model off template off footprint off xray off bypass off display off render off highlight off unload off savedata off compress off exposed on
outputsNamed3
{
}
inputsNamed3
{
}
inputs
{
}
stat
{
  create 1367133223
  modify 1367133224
  author yan@YanGang-PC
  access 0777
}
color UT_Color RGB 0.8 0.8 0.8 
delscript ""
exprlanguage hscript
end
0707070000010000000006660000000000000000010000001213715700100001000000000020ch.parm {
version 0.8
}
0707070000010000000006660000000000000000010000001213715700100001400000000041ch.userdata     ___Version___    12.5.3710707070000010000000006660000000000000000010000001213715700100000700000000002ch.net 1
0707070000010000000006660000000000000000010000001213715700100001100000000641shop.def comment ""
position 5 3
cachesize 1
connectornextid 0
flags =  lock off model off template off footprint off xray off bypass off display off render off highlight off unload off savedata off compress off exposed on
outputsNamed3
{
}
inputsNamed3
{
}
inputs
{
}
stat
{
  create 1367133223
  modify 1367133224
  author yan@YanGang-PC
  access 0777
}
color UT_Color RGB 0.8 0.8 0.8 
delscript ""
exprlanguage hscript
end
0707070000010000000006660000000000000000010000001213715700100001200000000020shop.parm {
version 0.8
}
0707070000010000000006660000000000000000010000001213715700100001600000000041shop.userdata     ___Version___    12.5.3710707070000010000000006660000000000000000010000001213715700100001100000000002shop.net 1
0707070000010000000006660000000000000000010000001213715700100001000000000645img.def comment ""
position 4.5 2.5
cachesize 1
connectornextid 0
flags =  lock off model off template off footprint off xray off bypass off display off render off highlight off unload off savedata off compress off exposed on
outputsNamed3
{
}
inputsNamed3
{
}
inputs
{
}
stat
{
  create 1367133223
  modify 1367133225
  author yan@YanGang-PC
  access 0777
}
color UT_Color RGB 0.8 0.8 0.8 
delscript ""
exprlanguage hscript
end
0707070000010000000006660000000000000000010000001213715700100001100000000020img.parm {
version 0.8
}
0707070000010000000006660000000000000000010000001213715700100001500000000041img.userdata     ___Version___    12.5.3710707070000010000000006660000000000000000010000001213715700100001700000000032img/comp1.init type = img
matchesdef = 0
0707070000010000000006660000000000000000010000001213715700100001600000000641img/comp1.def comment ""
position 0 0
cachesize 1
connectornextid 0
flags =  lock off model off template off footprint off xray off bypass off display off render off highlight off unload off savedata off compress off exposed on
outputsNamed3
{
}
inputsNamed3
{
}
inputs
{
}
stat
{
  create 1367133225
  modify 1367133225
  author yan@YanGang-PC
  access 0777
}
color UT_Color RGB 0.8 0.8 0.8 
delscript ""
exprlanguage hscript
end
0707070000010000000006660000000000000000010000001213715700100001700000000020img/comp1.parm {
version 0.8
}
0707070000010000000006660000000000000000010000001213715700100002300000000041img/comp1.userdata     ___Version___    12.5.3710707070000010000000006660000000000000000010000001213715700100001600000000002img/comp1.net 1
0707070000010000000006660000000000000000010000001213715700100001000000000002img.net 1
0707070000010000000006660000000000000000010000001213715700100001000000000002vex.net 1
0707070000010000000006660000000000000000010000001213715700100002400000000000.userdisplayoptions 0707070000010000000006660000000000000000010000001213715700100001500000065205.application neteditor -d Build2 -b 0 -l 0 -f '' -q 1.000000 -v /obj -0.00531912  -0.00531912 1 panetab7
imgview -p '(' none -z 1 ')' 0 -c 0 -l on -s off -i imgview2
imgdispopt -m 10 -P on -M on -A on -g 1 -G "C Left Right" -B 1 -v split -V 2 2 -d h -a off -i 2 -b 0 0 0 -o "" -h on -H on -c 0.8 0.8 0.8 -C 1 1 1 -S 0.8 0.8 0.8 -R 6 -F dc -D "" -I "" -f "" -s off -r 256 256 -p on -l off -t on
imgview -z 1 -p (none) 0 -c 0 -l on -s off -i imgview2
imgview2d  -V on -L on -G on -H on -P off -m 0 -p 0 1 -b 1 1 0 -g 1 -d "" -c -1 -t off -i on -X on imgview2 1
imgview2d  -V on -L on -G on -H on -P off -m 0 -p 0 1 -b 1 1 0 -g 1 -d "" -c -1 -t off -i on -X on imgview2 2
imgview2d  -V on -L on -G on -H on -P off -m 0 -p 0 1 -b 1 1 0 -g 1 -d "" -c -1 -t off -i on -X on imgview2 3
imgview2d  -V on -L on -G on -H on -P off -m 0 -p 0 1 -b 1 1 0 -g 1 -d "" -c -1 -t off -i on -X on imgview2 4
imgview2d  -V on -L on -G on -H on -P off -m 0 -p 0 1 -b 1 1 0 -g 1 -d "" -c -1 -t off -i on -X on imgview2 5
imgview2d  -V on -L on -G on -H on -P off -m 0 -p 0 1 -b 1 1 0 -g 1 -d "" -c -1 -t off -i on -X on imgview2 6
imgview2d  -V on -L on -G on -H on -P off -m 0 -p 0 1 -b 1 1 0 -g 1 -d "" -c -1 -t off -i on -X on imgview2 7
imgview2d  -V on -L on -G on -H on -P off -m 0 -p 0 1 -b 1 1 0 -g 1 -d "" -c -1 -t off -i on -X on imgview2 8
imgview2d  -V on -L on -G on -H on -P off -m 0 -p 0 1 -b 1 1 0 -g 1 -d "" -c -1 -t off -i on -X on imgview2 9
imgview2d  -V on -L on -G on -H on -P off -m 0 -p 0 1 -b 1 1 0 -g 1 -d "" -c -1 -t off -i on -X on imgview2 10
imgview2d  -V on -L on -G on -H on -P off -m 0 -p 0 1 -b 1 1 0 -g 1 -d "" -c -1 -t off -i on -X on imgview2 11
imgview2d  -V on -L on -G on -H on -P off -m 0 -p 0 1 -b 1 1 0 -g 1 -d "" -c -1 -t off -i on -X on imgview2 12
imgview2d  -V on -L on -G on -H on -P off -m 0 -p 0 1 -b 1 1 0 -g 1 -d "" -c -1 -t off -i on -X on imgview2 13
imgview2d  -V on -L on -G on -H on -P off -m 0 -p 0 1 -b 1 1 0 -g 1 -d "" -c -1 -t off -i on -X on imgview2 14
imgview2d  -V on -L on -G on -H on -P off -m 0 -p 0 1 -b 1 1 0 -g 1 -d "" -c -1 -t off -i on -X on imgview2 15
imgview2d  -V on -L on -G on -H on -P off -m 0 -p 0 1 -b 1 1 0 -g 1 -d "" -c -1 -t off -i on -X on imgview2 16
imgviewtime -V on -L on -G on -H on -P off -r 24 -u fr -g 0 -f on -e on -b on -d imgview2
imgviewhist -V on -L on -G on -H on -P off -c -1 -h 0 -i on imgview2 1
imgviewhist -V on -L on -G on -H on -P off -c -1 -h 0 -i on imgview2 2
imgviewhist -V on -L on -G on -H on -P off -c -1 -h 0 -i on imgview2 3
imgviewhist -V on -L on -G on -H on -P off -c -1 -h 0 -i on imgview2 4
imgviewhist -V on -L on -G on -H on -P off -c -1 -h 0 -i on imgview2 5
imgviewhist -V on -L on -G on -H on -P off -c -1 -h 0 -i on imgview2 6
imgviewhist -V on -L on -G on -H on -P off -c -1 -h 0 -i on imgview2 7
imgviewhist -V on -L on -G on -H on -P off -c -1 -h 0 -i on imgview2 8
imgviewhist -V on -L on -G on -H on -P off -c -1 -h 0 -i on imgview2 9
imgviewhist -V on -L on -G on -H on -P off -c -1 -h 0 -i on imgview2 10
imgviewhist -V on -L on -G on -H on -P off -c -1 -h 0 -i on imgview2 11
imgviewhist -V on -L on -G on -H on -P off -c -1 -h 0 -i on imgview2 12
imgviewhist -V on -L on -G on -H on -P off -c -1 -h 0 -i on imgview2 13
imgviewhist -V on -L on -G on -H on -P off -c -1 -h 0 -i on imgview2 14
imgviewhist -V on -L on -G on -H on -P off -c -1 -h 0 -i on imgview2 15
imgviewhist -V on -L on -G on -H on -P off -c -1 -h 0 -i on imgview2 16
viewerstow -b stow -x open -l open -m hide -c hide -d open Build2.panetab1.world
vieweroption -a 2 -h 0 -m 1 -r 'View: Mantra' Build2.panetab1.world
viewlayout -s 2 Build2.panetab1.world
viewerinspect Build2.panetab1.world mode ( objects ) object_properties ( ) prim_properties ( ) enable ( 0 ) magnify ( 1 )
viewtype -t perspective Build2.panetab1.world.`vpname("Build2.panetab1.world",2)`
viewtype -t ortho_top Build2.panetab1.world.`vpname("Build2.panetab1.world",1)`
viewtype -t ortho_front Build2.panetab1.world.`vpname("Build2.panetab1.world",3)`
viewtype -t ortho_right Build2.panetab1.world.`vpname("Build2.panetab1.world",4)`
viewname -l on -n aaaa3 Build2.panetab1.world.`vpname("Build2.panetab1.world",2)`
viewname -l on -n aaaa2 Build2.panetab1.world.`vpname("Build2.panetab1.world",1)`
viewname -l on -n aaaa1 Build2.panetab1.world.`vpname("Build2.panetab1.world",3)`
viewname -l on -n aaaa0 Build2.panetab1.world.`vpname("Build2.panetab1.world",4)`
viewname -l off -n persp1 Build2.panetab1.world.`vpname("Build2.panetab1.world",2)`
viewname -l off -n top1 Build2.panetab1.world.`vpname("Build2.panetab1.world",1)`
viewname -l off -n front1 Build2.panetab1.world.`vpname("Build2.panetab1.world",3)`
viewname -l off -n right1 Build2.panetab1.world.`vpname("Build2.panetab1.world",4)`
viewdisplay -a on Build2.panetab1.world.persp1
viewdisplay -M unsel shade -N unsel n off -E unsel n off -I unsel n off Build2.panetab1.world.persp1
viewdisplay -N unsel t off -E unsel t off -I unsel t on Build2.panetab1.world.persp1
viewdisplay -N unsel l off -E unsel g off -I unsel l off Build2.panetab1.world.persp1
viewdisplay -N unsel p off -I unsel p off Build2.panetab1.world.persp1
viewdisplay -N unsel m off -I unsel h off Build2.panetab1.world.persp1
viewdisplay -I unsel b off Build2.panetab1.world.persp1
viewdisplay -I unsel f off Build2.panetab1.world.persp1
viewdisplay -M templ wire -N templ n off -E templ n off -I templ n off Build2.panetab1.world.persp1
viewdisplay -N templ t off -E templ t off -I templ t off Build2.panetab1.world.persp1
viewdisplay -N templ l off -E templ g off -I templ l off Build2.panetab1.world.persp1
viewdisplay -N templ p off -I templ p off Build2.panetab1.world.persp1
viewdisplay -N templ m off -I templ h off Build2.panetab1.world.persp1
viewdisplay -I templ b off Build2.panetab1.world.persp1
viewdisplay -I templ f off Build2.panetab1.world.persp1
viewdisplay -M curr_unsel wire -N curr_unsel n off -E curr_unsel n off -I curr_unsel n off Build2.panetab1.world.persp1
viewdisplay -N curr_unsel t off -E curr_unsel t off -I curr_unsel t on Build2.panetab1.world.persp1
viewdisplay -N curr_unsel l off -E curr_unsel g off -I curr_unsel l off Build2.panetab1.world.persp1
viewdisplay -N curr_unsel p off -I curr_unsel p off Build2.panetab1.world.persp1
viewdisplay -N curr_unsel m off -I curr_unsel h off Build2.panetab1.world.persp1
viewdisplay -I curr_unsel b off Build2.panetab1.world.persp1
viewdisplay -I curr_unsel f off Build2.panetab1.world.persp1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P off -p off -f off -F off -l on -L on -G off -r unique scene Build2.panetab1.world.persp1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P off -p off -f off -F off -l on -L on -G off -r scene selectscene Build2.panetab1.world.persp1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P off -p off -f off -F off -l on -L off -G on -r unique ghostscene Build2.panetab1.world.persp1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P on -p off -f off -F off -l on -L on -G off -r unique display Build2.panetab1.world.persp1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P on -p off -f off -F off -l on -L off -G off -r unique current Build2.panetab1.world.persp1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P off -p off -f off -F on -l on -L off -G on -r unique template Build2.panetab1.world.persp1
viewdisplay -A templ on -B bw -b off -d off -C 2 -e 1 -F off -f off -g on -G '*' -h off -H on -j off -J off Build2.panetab1.world.persp1
viewdisplay -A curr_all on -l 1 -L on -n 0.2 -o on -O on -q on -r on -s off -t on Build2.panetab1.world.persp1
viewdisplay -V 2 -z off -y off -x off -X off -U 4 -Y 4 -T on -R on -i on -D on -k off Build2.panetab1.world.persp1
viewdisplay -Q on -m on -v on Build2.panetab1.world.persp1
viewdisplay -W  off bound_box_wire 0 Build2.panetab1.world.persp1
viewdisplay -c off -K on -P points -p 3 Build2.panetab1.world.persp1
vieweffect -a 0 -A 4 -b on -B 1 -c on -d on -C 0 -D on off -g 1 -f 1 -F 0 -h 1 -H on -i on -I 1 -k 1 -l '' -m on -M 2048 -o off -O 2 -p off -P 3 -q 1 -Q 2 -r 2048 2048 -s 1 -t 100 -T 100 -u off -U off -v 256 256 256 -w 0.05 -W off -z 0.25 Build2.panetab1.world.persp1
viewinfotext -m off Build2.panetab1.world.persp1
viewlight  -a on -d on -e on -h off -l on -n 8 -s on Build2.panetab1.world.persp1
viewbackground -b off -e on -q 1 -S file -F '' -O off -r 512 512 -C '' -p '(Default Color)' 1 -t on -a on -o 0 0 -s 1 1 -i off -m 0 0 -M 1 1 Build2.panetab1.world.persp1
viewtransform Build2.panetab1.world.persp1 version ( 3 )  flag ( F )  orthowidth ( 25.1416 )  focal ( 50 )  aperture ( 41.4214 )  window ( 0 1 0 1 )  winroll ( 0 )  clear ( 1 )  nearfar ( 0.1 32025 )  resxy ( 1 1 )  aspect ( 1.33333 )  pixelaspect ( 1 )  txyz ( 0 0 24.9722 )  pxyz ( 0 0 0 )  rotation ( 0.707107 -0.353553 0.612372 0 0.866025 0.5 -0.707107 -0.353553 0.612372  )  homedistance ( 24.9722 )  homeadjboxwidth ( 12.5708 )  homeorthowidth ( 25.1416 )  homeradius ( 32 )  homeaxis ( 0 )  homecustom ( 0.707107 -0.353553 0.612372 0 0.866025 0.5 -0.707107 -0.353553 0.612372  )  adjustlimits ( 3 )  
viewcamera -c '' Build2.panetab1.world.persp1
vieworthogrid -d on -o 0 0 0 -s 0.5 0.5 -r 8 8 Build2.panetab1.world.persp1
viewuvgrid -r off -s 0.1 0.1 -P on -S 1 1 -O 0 0 -C on -t on Build2.panetab1.world.persp1
viewdisplay -a on Build2.panetab1.world.top1
viewdisplay -M unsel shade -N unsel n off -E unsel n off -I unsel n off Build2.panetab1.world.top1
viewdisplay -N unsel t off -E unsel t off -I unsel t on Build2.panetab1.world.top1
viewdisplay -N unsel l off -E unsel g off -I unsel l off Build2.panetab1.world.top1
viewdisplay -N unsel p off -I unsel p off Build2.panetab1.world.top1
viewdisplay -N unsel m off -I unsel h off Build2.panetab1.world.top1
viewdisplay -I unsel b off Build2.panetab1.world.top1
viewdisplay -I unsel f off Build2.panetab1.world.top1
viewdisplay -M templ wire -N templ n off -E templ n off -I templ n off Build2.panetab1.world.top1
viewdisplay -N templ t off -E templ t off -I templ t off Build2.panetab1.world.top1
viewdisplay -N templ l off -E templ g off -I templ l off Build2.panetab1.world.top1
viewdisplay -N templ p off -I templ p off Build2.panetab1.world.top1
viewdisplay -N templ m off -I templ h off Build2.panetab1.world.top1
viewdisplay -I templ b off Build2.panetab1.world.top1
viewdisplay -I templ f off Build2.panetab1.world.top1
viewdisplay -M curr_unsel wire -N curr_unsel n off -E curr_unsel n off -I curr_unsel n off Build2.panetab1.world.top1
viewdisplay -N curr_unsel t off -E curr_unsel t off -I curr_unsel t on Build2.panetab1.world.top1
viewdisplay -N curr_unsel l off -E curr_unsel g off -I curr_unsel l off Build2.panetab1.world.top1
viewdisplay -N curr_unsel p off -I curr_unsel p off Build2.panetab1.world.top1
viewdisplay -N curr_unsel m off -I curr_unsel h off Build2.panetab1.world.top1
viewdisplay -I curr_unsel b off Build2.panetab1.world.top1
viewdisplay -I curr_unsel f off Build2.panetab1.world.top1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P off -p off -f off -F off -l on -L on -G off -r unique scene Build2.panetab1.world.top1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P off -p off -f off -F off -l on -L on -G off -r scene selectscene Build2.panetab1.world.top1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P off -p off -f off -F off -l on -L off -G on -r unique ghostscene Build2.panetab1.world.top1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P on -p off -f off -F off -l on -L on -G off -r unique display Build2.panetab1.world.top1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P on -p off -f off -F off -l on -L off -G off -r unique current Build2.panetab1.world.top1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P off -p off -f off -F on -l on -L off -G on -r unique template Build2.panetab1.world.top1
viewdisplay -A templ on -B bw -b off -d off -C 2 -e 1 -F off -f off -g on -G '*' -h off -H on -j off -J off Build2.panetab1.world.top1
viewdisplay -A curr_all on -l 1 -L on -n 0.2 -o on -O on -q on -r on -s off -t on Build2.panetab1.world.top1
viewdisplay -V 2 -z off -y off -x off -X off -U 4 -Y 4 -T on -R on -i on -D on -k off Build2.panetab1.world.top1
viewdisplay -Q on -m on -v on Build2.panetab1.world.top1
viewdisplay -W  off bound_box_wire 0 Build2.panetab1.world.top1
viewdisplay -c off -K on -P points -p 3 Build2.panetab1.world.top1
vieweffect -a 0 -A 4 -b on -B 1 -c on -d on -C 0 -D on off -g 1 -f 1 -F 0 -h 1 -H on -i on -I 1 -k 1 -l '' -m on -M 2048 -o off -O 2 -p off -P 3 -q 1 -Q 2 -r 2048 2048 -s 1 -t 100 -T 100 -u off -U off -v 256 256 256 -w 0.05 -W off -z 0.25 Build2.panetab1.world.top1
viewinfotext -m off Build2.panetab1.world.top1
viewlight  -a on -d on -e on -h off -l on -n 8 -s on Build2.panetab1.world.top1
viewbackground -b off -e on -q 1 -S file -F '' -O off -r 512 512 -C '' -p '(Default Color)' 1 -t on -a on -o 0 0 -s 1 1 -i off -m 0 0 -M 1 1 Build2.panetab1.world.top1
viewtransform Build2.panetab1.world.top1 version ( 3 )  flag ( Fo )  orthowidth ( 2.22222 )  focal ( 50 )  aperture ( 41.4214 )  window ( 0 1 0 1 )  winroll ( 0 )  clear ( 1 )  nearfar ( 0.1 3467.78 )  resxy ( 1 1 )  aspect ( 1.33333 )  pixelaspect ( 1 )  txyz ( 0 0 3.68246 )  pxyz ( 0 0 0 )  rotation ( 1 0 0 0 1.19209e-007 1 0 -1 1.19209e-007  )  homedistance ( 3.68246 )  homeadjboxwidth ( 2.22222 )  homeorthowidth ( 2.22222 )  homeradius ( 3.4641 )  homeaxis ( 0 )  homecustom ( 0.707107 -0.353553 0.612372 0 0.866025 0.5 -0.707107 -0.353553 0.612372  )  adjustlimits ( 3 )  
vieworthogrid -d on -o 0 0 0 -s 0.5 0.5 -r 8 8 Build2.panetab1.world.top1
viewuvgrid -r off -s 0.1 0.1 -P on -S 1 1 -O 0 0 -C on -t on Build2.panetab1.world.top1
viewdisplay -a on Build2.panetab1.world.front1
viewdisplay -M unsel shade -N unsel n off -E unsel n off -I unsel n off Build2.panetab1.world.front1
viewdisplay -N unsel t off -E unsel t off -I unsel t on Build2.panetab1.world.front1
viewdisplay -N unsel l off -E unsel g off -I unsel l off Build2.panetab1.world.front1
viewdisplay -N unsel p off -I unsel p off Build2.panetab1.world.front1
viewdisplay -N unsel m off -I unsel h off Build2.panetab1.world.front1
viewdisplay -I unsel b off Build2.panetab1.world.front1
viewdisplay -I unsel f off Build2.panetab1.world.front1
viewdisplay -M templ wire -N templ n off -E templ n off -I templ n off Build2.panetab1.world.front1
viewdisplay -N templ t off -E templ t off -I templ t off Build2.panetab1.world.front1
viewdisplay -N templ l off -E templ g off -I templ l off Build2.panetab1.world.front1
viewdisplay -N templ p off -I templ p off Build2.panetab1.world.front1
viewdisplay -N templ m off -I templ h off Build2.panetab1.world.front1
viewdisplay -I templ b off Build2.panetab1.world.front1
viewdisplay -I templ f off Build2.panetab1.world.front1
viewdisplay -M curr_unsel wire -N curr_unsel n off -E curr_unsel n off -I curr_unsel n off Build2.panetab1.world.front1
viewdisplay -N curr_unsel t off -E curr_unsel t off -I curr_unsel t on Build2.panetab1.world.front1
viewdisplay -N curr_unsel l off -E curr_unsel g off -I curr_unsel l off Build2.panetab1.world.front1
viewdisplay -N curr_unsel p off -I curr_unsel p off Build2.panetab1.world.front1
viewdisplay -N curr_unsel m off -I curr_unsel h off Build2.panetab1.world.front1
viewdisplay -I curr_unsel b off Build2.panetab1.world.front1
viewdisplay -I curr_unsel f off Build2.panetab1.world.front1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P off -p off -f off -F off -l on -L on -G off -r unique scene Build2.panetab1.world.front1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P off -p off -f off -F off -l on -L on -G off -r scene selectscene Build2.panetab1.world.front1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P off -p off -f off -F off -l on -L off -G on -r unique ghostscene Build2.panetab1.world.front1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P on -p off -f off -F off -l on -L on -G off -r unique display Build2.panetab1.world.front1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P on -p off -f off -F off -l on -L off -G off -r unique current Build2.panetab1.world.front1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P off -p off -f off -F on -l on -L off -G on -r unique template Build2.panetab1.world.front1
viewdisplay -A templ on -B bw -b off -d off -C 2 -e 1 -F off -f off -g on -G '*' -h off -H on -j off -J off Build2.panetab1.world.front1
viewdisplay -A curr_all on -l 1 -L on -n 0.2 -o on -O on -q on -r on -s off -t on Build2.panetab1.world.front1
viewdisplay -V 2 -z off -y off -x off -X off -U 4 -Y 4 -T on -R on -i on -D on -k off Build2.panetab1.world.front1
viewdisplay -Q on -m on -v on Build2.panetab1.world.front1
viewdisplay -W  off bound_box_wire 0 Build2.panetab1.world.front1
viewdisplay -c off -K on -P points -p 3 Build2.panetab1.world.front1
vieweffect -a 0 -A 4 -b on -B 1 -c on -d on -C 0 -D on off -g 1 -f 1 -F 0 -h 1 -H on -i on -I 1 -k 1 -l '' -m on -M 2048 -o off -O 2 -p off -P 3 -q 1 -Q 2 -r 2048 2048 -s 1 -t 100 -T 100 -u off -U off -v 256 256 256 -w 0.05 -W off -z 0.25 Build2.panetab1.world.front1
viewinfotext -m off Build2.panetab1.world.front1
viewlight  -a on -d on -e on -h off -l on -n 8 -s on Build2.panetab1.world.front1
viewbackground -b off -e on -q 1 -S file -F '' -O off -r 512 512 -C '' -p '(Default Color)' 1 -t on -a on -o 0 0 -s 1 1 -i off -m 0 0 -M 1 1 Build2.panetab1.world.front1
viewtransform Build2.panetab1.world.front1 version ( 3 )  flag ( Fo )  orthowidth ( 2.22222 )  focal ( 50 )  aperture ( 41.4214 )  window ( 0 1 0 1 )  winroll ( 0 )  clear ( 1 )  nearfar ( 0.1 3467.78 )  resxy ( 1 1 )  aspect ( 1.33333 )  pixelaspect ( 1 )  txyz ( 0 0 3.68246 )  pxyz ( 0 0 0 )  rotation ( 1 0 0 0 1 0 0 0 1  )  homedistance ( 3.68246 )  homeadjboxwidth ( 2.22222 )  homeorthowidth ( 2.22222 )  homeradius ( 3.4641 )  homeaxis ( 0 )  homecustom ( 0.707107 -0.353553 0.612372 0 0.866025 0.5 -0.707107 -0.353553 0.612372  )  adjustlimits ( 3 )  
vieworthogrid -d on -o 0 0 0 -s 0.5 0.5 -r 8 8 Build2.panetab1.world.front1
viewuvgrid -r off -s 0.1 0.1 -P on -S 1 1 -O 0 0 -C on -t on Build2.panetab1.world.front1
viewdisplay -a on Build2.panetab1.world.right1
viewdisplay -M unsel shade -N unsel n off -E unsel n off -I unsel n off Build2.panetab1.world.right1
viewdisplay -N unsel t off -E unsel t off -I unsel t on Build2.panetab1.world.right1
viewdisplay -N unsel l off -E unsel g off -I unsel l off Build2.panetab1.world.right1
viewdisplay -N unsel p off -I unsel p off Build2.panetab1.world.right1
viewdisplay -N unsel m off -I unsel h off Build2.panetab1.world.right1
viewdisplay -I unsel b off Build2.panetab1.world.right1
viewdisplay -I unsel f off Build2.panetab1.world.right1
viewdisplay -M templ wire -N templ n off -E templ n off -I templ n off Build2.panetab1.world.right1
viewdisplay -N templ t off -E templ t off -I templ t off Build2.panetab1.world.right1
viewdisplay -N templ l off -E templ g off -I templ l off Build2.panetab1.world.right1
viewdisplay -N templ p off -I templ p off Build2.panetab1.world.right1
viewdisplay -N templ m off -I templ h off Build2.panetab1.world.right1
viewdisplay -I templ b off Build2.panetab1.world.right1
viewdisplay -I templ f off Build2.panetab1.world.right1
viewdisplay -M curr_unsel wire -N curr_unsel n off -E curr_unsel n off -I curr_unsel n off Build2.panetab1.world.right1
viewdisplay -N curr_unsel t off -E curr_unsel t off -I curr_unsel t on Build2.panetab1.world.right1
viewdisplay -N curr_unsel l off -E curr_unsel g off -I curr_unsel l off Build2.panetab1.world.right1
viewdisplay -N curr_unsel p off -I curr_unsel p off Build2.panetab1.world.right1
viewdisplay -N curr_unsel m off -I curr_unsel h off Build2.panetab1.world.right1
viewdisplay -I curr_unsel b off Build2.panetab1.world.right1
viewdisplay -I curr_unsel f off Build2.panetab1.world.right1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P off -p off -f off -F off -l on -L on -G off -r unique scene Build2.panetab1.world.right1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P off -p off -f off -F off -l on -L on -G off -r scene selectscene Build2.panetab1.world.right1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P off -p off -f off -F off -l on -L off -G on -r unique ghostscene Build2.panetab1.world.right1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P on -p off -f off -F off -l on -L on -G off -r unique display Build2.panetab1.world.right1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P on -p off -f off -F off -l on -L off -G off -r unique current Build2.panetab1.world.right1
viewdispset -m off always -n off always -c off always -u off always -x off always -N off always -C off always -b off always -M off always -v off always -V off always -U off always -g off always -h off -P off -p off -f off -F on -l on -L off -G on -r unique template Build2.panetab1.world.right1
viewdisplay -A templ on -B bw -b off -d off -C 2 -e 1 -F off -f off -g on -G '*' -h off -H on -j off -J off Build2.panetab1.world.right1
viewdisplay -A curr_all on -l 1 -L on -n 0.2 -o on -O on -q on -r on -s off -t on Build2.panetab1.world.right1
viewdisplay -V 2 -z off -y off -x off -X off -U 4 -Y 4 -T on -R on -i on -D on -k off Build2.panetab1.world.right1
viewdisplay -Q on -m on -v on Build2.panetab1.world.right1
viewdisplay -W  off bound_box_wire 0 Build2.panetab1.world.right1
viewdisplay -c off -K on -P points -p 3 Build2.panetab1.world.right1
vieweffect -a 0 -A 4 -b on -B 1 -c on -d on -C 0 -D on off -g 1 -f 1 -F 0 -h 1 -H on -i on -I 1 -k 1 -l '' -m on -M 2048 -o off -O 2 -p off -P 3 -q 1 -Q 2 -r 2048 2048 -s 1 -t 100 -T 100 -u off -U off -v 256 256 256 -w 0.05 -W off -z 0.25 Build2.panetab1.world.right1
viewinfotext -m off Build2.panetab1.world.right1
viewlight  -a on -d on -e on -h off -l on -n 8 -s on Build2.panetab1.world.right1
viewbackground -b off -e on -q 1 -S file -F '' -O off -r 512 512 -C '' -p '(Default Color)' 1 -t on -a on -o 0 0 -s 1 1 -i off -m 0 0 -M 1 1 Build2.panetab1.world.right1
viewtransform Build2.panetab1.world.right1 version ( 3 )  flag ( Fo )  orthowidth ( 2.22222 )  focal ( 50 )  aperture ( 41.4214 )  window ( 0 1 0 1 )  winroll ( 0 )  clear ( 1 )  nearfar ( 0.1 3467.78 )  resxy ( 1 1 )  aspect ( 1.33333 )  pixelaspect ( 1 )  txyz ( 0 0 3.68246 )  pxyz ( 0 0 0 )  rotation ( 6.12323e-017 0 1 0 1 0 -1 0 6.12323e-017  )  homedistance ( 3.68246 )  homeadjboxwidth ( 2.22222 )  homeorthowidth ( 2.22222 )  homeradius ( 3.4641 )  homeaxis ( 0 )  homecustom ( 0.707107 -0.353553 0.612372 0 0.866025 0.5 -0.707107 -0.353553 0.612372  )  adjustlimits ( 3 )  
vieworthogrid -d on -o 0 0 0 -s 0.5 0.5 -r 8 8 Build2.panetab1.world.right1
viewuvgrid -r off -s 0.1 0.1 -P on -S 1 1 -O 0 0 -C on -t on Build2.panetab1.world.right1
viewsnapshotoption -s off -h off -a 1 -v '*' Build2.panetab1.world
cplane -o -8 0 -8 -n 0 1 0 -x 0 0 1 -l n -s 0.5 0.5 -c 32 32 -r 8 8 -d on Build2.panetab1.world
glcache -M 3686
panepath -d Build2 -f -p panetab1 /obj/
panepath -d Build2 -f -p panetab2 /obj/
panepath -d Build2 -f -p panetab3 /obj/
panepath -d Build2 -f -p panetab4 /img/comp1/
panepath -d Build2 -f -p panetab5 /obj/
panepath -d Build2 -f -p panetab6 /obj/
panepath -d Build2 -f -p panetab7 /obj/
panepath -d Build2 -f -p panetab8 /obj/
panepath -d Build2 -f -p panetab9 /obj/
panepath -d Build2 -f -p panetab10 /obj/
desk set Build2
viewupdate -u always
audiopanel -s p ''
audiopanel -s r off
audiopanel -s s 1
audiopanel -s f 45
audiopanel -t p stop
audiopanel -t l off
audiopanel -t r on
audiopanel -o m off
audiopanel -o t on
audiopanel -o u on
audiopanel -o l 1
audiopanel -o r 1
audiopanel -o d 0
audiopanel -r d 0.2
audiopanel -m 0
audiopanel -a ''
audiopanel -f 1
audiopanel -O 0
colorsettings -D -A -g 1 -l ""
compproject -r 640 480 -a 1 -d i8 -p 0 255 -P full -f 0 -F 0 -l on
texcache  -a off -r 2147483647 2147483647 -m 10000 -M 3069
shopvisible +OGL +OGL2 +I3D +VMantra +MI +RIB
0707070000010000000006660000000000000000010000001213715700100000700000000060.takes HoudiniTakeFile 1.0
take name Main kids 0
   e
0707070000010000000006660000000000000000010000001213715700100000500000000024.cwd opcf /
takeset Main
0707070000010000000006660000000000000000010000001213715700100001600000000000.custompanels 0707070000010000000006660000000000000000010000001213715700100001300000000000TRAILER!!! 