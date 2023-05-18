from abaqus import *
from abaqusConstants import *
from caeModules import *
from driverUtils import executeOnCaeStartup
executeOnCaeStartup()
Mdb()
# creating auxilary cylinder in order to define the principal axis and planes
s = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', sheetSize=2.0)
g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints
s.setPrimaryObject(option=STANDALONE)
s.CircleByCenterPerimeter(center=(0.0, 0.0), point1=(0.0, -0.1))
p = mdb.models['Model-1'].Part(name='BCC', dimensionality=THREE_D, 
    type=DEFORMABLE_BODY)
p = mdb.models['Model-1'].parts['BCC']
p.BaseSolidExtrude(sketch=s, depth=0.2)
s.unsetPrimaryObject()
p = mdb.models['Model-1'].parts['BCC']
del mdb.models['Model-1'].sketches['__profile__']
#now we have the axuilary cylinder and we can define the principal axis and planes as follows:
#pax
p = mdb.models['Model-1'].parts['BCC']
p.DatumAxisByPrincipalAxis(principalAxis=XAXIS)
#pay
p = mdb.models['Model-1'].parts['BCC']
p.DatumAxisByPrincipalAxis(principalAxis=YAXIS)
#paz
p = mdb.models['Model-1'].parts['BCC']
p.DatumAxisByPrincipalAxis(principalAxis=ZAXIS)
#ppxy
p = mdb.models['Model-1'].parts['BCC']
p.DatumPlaneByPrincipalPlane(principalPlane=XYPLANE, offset=0.0)
#ppyz
p = mdb.models['Model-1'].parts['BCC']
p.DatumPlaneByPrincipalPlane(principalPlane=YZPLANE, offset=0.0)
#ppxz
p = mdb.models['Model-1'].parts['BCC']
p.DatumPlaneByPrincipalPlane(principalPlane=XZPLANE, offset=0.0)
#the next move is to define the offseted and angled planes for sketches but before we need to suppress the auxilary cylinder
p = mdb.models['Model-1'].parts['BCC']
p.features['Solid extrude-1'].suppress()
#plane offseted from xy plane: opxy
p = mdb.models['Model-1'].parts['BCC']
p.DatumPlaneByPrincipalPlane(principalPlane=XYPLANE, offset=2.0)
#plane offseted from yz plane: opyz
p = mdb.models['Model-1'].parts['BCC']
p.DatumPlaneByPrincipalPlane(principalPlane=YZPLANE, offset=-2.0)
#creating a new angled plane (ap_ppxy_pay:ap1) by rotating the princial xy plane around the principal axis y
p = mdb.models['Model-1'].parts['BCC']
d1 = p.datums
p.DatumPlaneByRotation(plane=d1[5], axis=d1[3], angle=-45.0)
#creating a new angled plane (ap_ap1_il1:ap2) by rotating the former angled plane (ap1) around the intersecting line (il1) between ap1 and principal xz plane 
#creating il_ap1_ppxz:il1
p = mdb.models['Model-1'].parts['BCC']
d2 = p.datums
p.DatumAxisByTwoPlane(plane1=d2[10], plane2=d2[7])
#creating ap_ap1_il1:ap2
p = mdb.models['Model-1'].parts['BCC']
d2 = p.datums
p.DatumPlaneByRotation(plane=d2[10], axis=d2[11], angle=45.0)
#creating il_opxy_ppzy:il2
p = mdb.models['Model-1'].parts['BCC']
d1 = p.datums
p.DatumAxisByTwoPlane(plane1=d1[6], plane2=d1[8])
#creating il_opxy_opyz:il3
p = mdb.models['Model-1'].parts['BCC']
d2 = p.datums
p.DatumAxisByTwoPlane(plane1=d2[8], plane2=d2[9])
#creating il_opyz_ppxy:il4
p = mdb.models['Model-1'].parts['BCC']
d1 = p.datums
p.DatumAxisByTwoPlane(plane1=d1[5], plane2=d1[9])
#creating ap_opxy_il2:ap3
p = mdb.models['Model-1'].parts['BCC']
d2 = p.datums
p.DatumPlaneByRotation(plane=d2[8], axis=d2[13], angle=-45.0)
#creating il_ap3_ppxz:il5
p = mdb.models['Model-1'].parts['BCC']
d1 = p.datums
p.DatumAxisByTwoPlane(plane1=d1[16], plane2=d1[7])
#creating ap_ap3_il5:ap4
p = mdb.models['Model-1'].parts['BCC']
d2 = p.datums
p.DatumPlaneByRotation(plane=d2[16], axis=d2[17], angle=-45.0)
#creating ap_opxy_il3:ap5
p = mdb.models['Model-1'].parts['BCC']
d1 = p.datums
p.DatumPlaneByRotation(plane=d1[8], axis=d1[14], angle=-45.0)
#creating il_ap5_ppxz:il6
p = mdb.models['Model-1'].parts['BCC']
d2 = p.datums
p.DatumAxisByTwoPlane(plane1=d2[19], plane2=d2[7])
#creating ap_ap5_il6:ap6
p = mdb.models['Model-1'].parts['BCC']
d1 = p.datums
p.DatumPlaneByRotation(plane=d1[19], axis=d1[20], angle=-45.0)
#creating ap_ppxy_il4:ap7
p = mdb.models['Model-1'].parts['BCC']
d2 = p.datums
p.DatumPlaneByRotation(plane=d2[5], axis=d2[15], angle=45.0)
#creating il_ap7_ppxz:il7 
p = mdb.models['Model-1'].parts['BCC']
d1 = p.datums
p.DatumAxisByTwoPlane(plane1=d1[22], plane2=d1[7])
#creating ap_ap7_il7:ap8
p = mdb.models['Model-1'].parts['BCC']
d2 = p.datums
p.DatumPlaneByRotation(plane=d2[22], axis=d2[23], angle=45.0)
#########################now we proceed to draw the first tube of the BCC##########################################
p = mdb.models['Model-1'].parts['BCC']
d1 = p.datums
t = p.MakeSketchTransform(sketchPlane=d1[12], sketchUpEdge=d1[3], 
    sketchPlaneSide=SIDE1, sketchOrientation=RIGHT, origin=(0.0, 0.0, 0.0))
s1 = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
    sheetSize=992.05, gridSpacing=24.8, transform=t)
g, v, d, c = s1.geometry, s1.vertices, s1.dimensions, s1.constraints
s1.setPrimaryObject(option=SUPERIMPOSE)
p = mdb.models['Model-1'].parts['BCC']
p.projectReferencesOntoSketch(sketch=s1, filter=COPLANAR_EDGES)
#draw the circular cross section
s1.CircleByCenterPerimeter(center=(0.0, 0.0), point1=(4.81746705544348, 
    -5.8143314009976))	
#add a fixed constraint to the center of the circle
s1.FixedConstraint(entity=v[0])
#give a new radius
s1.RadialDimension(curve=g[12], textPoint=(-9.58994150716461, 
    1.31744555102731), radius=0.1)
#draw the inner circle	
s1.CircleByCenterPerimeter(center=(0.0, 0.0), point1=(-0.0750092520570202, 
    -0.0147043005116516))
s1.RadialDimension(curve=g[13], textPoint=(-0.171554532178743, 
    -0.0538041702074719), radius=0.095)
#sketch is finished. Now extrude the base sketch	
p = mdb.models['Model-1'].parts['BCC']
d2 = p.datums
p.SolidExtrude(sketchPlane=d2[12], sketchUpEdge=d2[3], sketchPlaneSide=SIDE1, 
    sketchOrientation=RIGHT, sketch=s1, depth=4.0, flipExtrudeDirection=OFF)
s1.unsetPrimaryObject()
del mdb.models['Model-1'].sketches['__profile__']
##########################################draw the second tube of the BCC##########################################
p = mdb.models['Model-1'].parts['BCC']
d2 = p.datums
t = p.MakeSketchTransform(sketchPlane=d2[18], sketchUpEdge=d2[13], 
    sketchPlaneSide=SIDE1, sketchOrientation=RIGHT, origin=(0.0, 0.0, 2.0))
s1 = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
    sheetSize=992.05, gridSpacing=24.8, transform=t)
g, v, d, c = s1.geometry, s1.vertices, s1.dimensions, s1.constraints
s1.setPrimaryObject(option=SUPERIMPOSE)
p = mdb.models['Model-1'].parts['BCC']
p.projectReferencesOntoSketch(sketch=s1, filter=COPLANAR_EDGES)
#draw the circular cross section
s1.CircleByCenterPerimeter(center=(0.0, 0.0), point1=(-0.300684383821208, 
    0.0843715408459019))
#add a fixed constraint to the center of the circle
s1.FixedConstraint(entity=v[0])
#give a new radius
s1.RadialDimension(curve=g[12], textPoint=(-0.42895106800617, 
    0.0425604705753269), radius=0.1)
#draw the inner circle	
s1.CircleByCenterPerimeter(center=(0.0, 0.0), point1=(-0.0590622332796504, 
    -0.0247486901501071))
#give a new radius	
s1.RadialDimension(curve=g[13], textPoint=(-0.195248478887204, 
    -0.0608095198947345), radius=0.095)
#sketch is finished. Now extrude the base sketch	
p = mdb.models['Model-1'].parts['BCC']
d1 = p.datums
p.SolidExtrude(sketchPlane=d1[18], sketchUpEdge=d1[13], sketchPlaneSide=SIDE1, 
    sketchOrientation=RIGHT, sketch=s1, depth=4.0, flipExtrudeDirection=ON)
s1.unsetPrimaryObject()
del mdb.models['Model-1'].sketches['__profile__']
##########################################draw the third tube of the BCC##########################################
p = mdb.models['Model-1'].parts['BCC']
d = p.datums
t = p.MakeSketchTransform(sketchPlane=d[21], sketchUpEdge=d[14], 
    sketchPlaneSide=SIDE1, sketchOrientation=RIGHT, origin=(-2.0, 0.0, 2.0))
s = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
    sheetSize=18.13, gridSpacing=0.45, transform=t)
g, v, d1, c = s.geometry, s.vertices, s.dimensions, s.constraints
s.setPrimaryObject(option=SUPERIMPOSE)
p = mdb.models['Model-1'].parts['BCC']
p.projectReferencesOntoSketch(sketch=s, filter=COPLANAR_EDGES)
s.CircleByCenterPerimeter(center=(0.0, 0.0), point1=(-0.0243709936829395, 
    0.112263152261376))
s.FixedConstraint(entity=v[0])
s.RadialDimension(curve=g[12], textPoint=(-0.165823235130838, 
    0.040183384258166), radius=0.1)
s.CircleByCenterPerimeter(center=(0.0, 0.0), point1=(0.0, -0.0547486167633906))
s.CoincidentConstraint(entity1=v[2], entity2=g[6], addUndoState=False)
s.RadialDimension(curve=g[13], textPoint=(-0.135072894457289, 
    0.0938031927409404), radius=0.095)
p = mdb.models['Model-1'].parts['BCC']
d2 = p.datums
p.SolidExtrude(sketchPlane=d2[21], sketchUpEdge=d2[14], sketchPlaneSide=SIDE1, 
    sketchOrientation=RIGHT, sketch=s, depth=4.0, flipExtrudeDirection=ON)
s.unsetPrimaryObject()
del mdb.models['Model-1'].sketches['__profile__']
##########################################draw the fourth tube of the BCC##########################################
p = mdb.models['Model-1'].parts['BCC']
d = p.datums
t = p.MakeSketchTransform(sketchPlane=d[24], sketchUpEdge=d[15], 
    sketchPlaneSide=SIDE1, sketchOrientation=RIGHT, origin=(-2.0, 0.0, 0.0))
s1 = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
    sheetSize=18.13, gridSpacing=0.45, transform=t)
g, v, d1, c = s1.geometry, s1.vertices, s1.dimensions, s1.constraints
s1.setPrimaryObject(option=SUPERIMPOSE)
p = mdb.models['Model-1'].parts['BCC']
p.projectReferencesOntoSketch(sketch=s1, filter=COPLANAR_EDGES)
s1.CircleByCenterPerimeter(center=(0.0, 0.0), point1=(0.31496710784458, 
    -0.049481035691634))
s1.FixedConstraint(entity=v[0])
s1.RadialDimension(curve=g[12], textPoint=(-0.190787319266023, 
    0.456523169114491), radius=0.1)
s1.CircleByCenterPerimeter(center=(0.0, 0.0), point1=(0.0426367634779845, 
    -0.0617224683263621))
s1.RadialDimension(curve=g[13], textPoint=(-0.205982775440746, 
    0.0364644557473391), radius=0.095)
p = mdb.models['Model-1'].parts['BCC']
d2 = p.datums
p.SolidExtrude(sketchPlane=d2[24], sketchUpEdge=d2[15], sketchPlaneSide=SIDE1, 
    sketchOrientation=RIGHT, sketch=s1, depth=4.0, flipExtrudeDirection=OFF)
s1.unsetPrimaryObject()
del mdb.models['Model-1'].sketches['__profile__']
#########################################cut extrude to delete the internal crossing boundaries through tube1#########################
p = mdb.models['Model-1'].parts['BCC']
e1, d2 = p.edges, p.datums
t = p.MakeSketchTransform(sketchPlane=d2[12], sketchUpEdge=e1[61], 
    sketchPlaneSide=SIDE1, sketchOrientation=RIGHT, origin=(0.0, 0.0, 0.0))
s1 = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
    sheetSize=18.13, gridSpacing=0.45, transform=t)
g, v, d, c = s1.geometry, s1.vertices, s1.dimensions, s1.constraints
s1.setPrimaryObject(option=SUPERIMPOSE)
p = mdb.models['Model-1'].parts['BCC']
p.projectReferencesOntoSketch(sketch=s1, filter=COPLANAR_EDGES)
s1.CircleByCenterPerimeter(center=(0.0, 0.0), point1=(-0.0932256030784231, 
    -0.0182753093178829))
p = mdb.models['Model-1'].parts['BCC']
e, d1 = p.edges, p.datums
p.CutExtrude(sketchPlane=d1[12], sketchUpEdge=e[61], sketchPlaneSide=SIDE1, 
    sketchOrientation=RIGHT, sketch=s1, flipExtrudeDirection=ON)
s1.unsetPrimaryObject()
del mdb.models['Model-1'].sketches['__profile__']
#########################################cut extrude to delete the internal crossing boundaries through tube2#########################
p = mdb.models['Model-1'].parts['BCC']
e1, d2 = p.edges, p.datums
t = p.MakeSketchTransform(sketchPlane=d2[18], sketchUpEdge=e1[45], 
    sketchPlaneSide=SIDE1, sketchOrientation=RIGHT, origin=(0.0, 0.0, 2.0))
s = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
    sheetSize=18.13, gridSpacing=0.45, transform=t)
g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints
s.setPrimaryObject(option=SUPERIMPOSE)
p = mdb.models['Model-1'].parts['BCC']
p.projectReferencesOntoSketch(sketch=s, filter=COPLANAR_EDGES)
s.CircleByCenterPerimeter(center=(0.0, 0.0), point1=(-0.0876186967700296, 
    -0.0367146289143927))
p = mdb.models['Model-1'].parts['BCC']
e, d1 = p.edges, p.datums
p.CutExtrude(sketchPlane=d1[18], sketchUpEdge=e[45], sketchPlaneSide=SIDE1, 
    sketchOrientation=RIGHT, sketch=s, flipExtrudeDirection=OFF)
s.unsetPrimaryObject()
del mdb.models['Model-1'].sketches['__profile__']
#########################################cut extrude to delete the internal crossing boundaries through tube3#########################
p = mdb.models['Model-1'].parts['BCC']
e1, d2 = p.edges, p.datums
t = p.MakeSketchTransform(sketchPlane=d2[21], sketchUpEdge=e1[16], 
    sketchPlaneSide=SIDE1, sketchOrientation=RIGHT, origin=(-2.0, 0.0, 2.0))
s1 = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
    sheetSize=18.13, gridSpacing=0.45, transform=t)
g, v, d, c = s1.geometry, s1.vertices, s1.dimensions, s1.constraints
s1.setPrimaryObject(option=SUPERIMPOSE)
p = mdb.models['Model-1'].parts['BCC']
p.projectReferencesOntoSketch(sketch=s1, filter=COPLANAR_EDGES)
s1.CircleByCenterPerimeter(center=(0.0, 0.0), point1=(-0.0116066974272673, 
    0.0942883056101439))
s1.CoincidentConstraint(entity1=v[3], entity2=g[3], addUndoState=False)
p = mdb.models['Model-1'].parts['BCC']
e, d1 = p.edges, p.datums
p.CutExtrude(sketchPlane=d1[21], sketchUpEdge=e[16], sketchPlaneSide=SIDE1, 
    sketchOrientation=RIGHT, sketch=s1, flipExtrudeDirection=OFF)
s1.unsetPrimaryObject()
del mdb.models['Model-1'].sketches['__profile__']
#########################################cut extrude to delete the internal crossing boundaries through tube4#########################
p = mdb.models['Model-1'].parts['BCC']
e1, d2 = p.edges, p.datums
t = p.MakeSketchTransform(sketchPlane=d2[24], sketchUpEdge=e1[60], 
    sketchPlaneSide=SIDE1, sketchOrientation=RIGHT, origin=(-2.0, 0.0, 0.0))
s = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
    sheetSize=18.13, gridSpacing=0.45, transform=t)
g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints
s.setPrimaryObject(option=SUPERIMPOSE)
p = mdb.models['Model-1'].parts['BCC']
p.projectReferencesOntoSketch(sketch=s, filter=COPLANAR_EDGES)
s.CircleByCenterPerimeter(center=(0.0, 0.0), point1=(0.0539942976204315, 
    -0.0781640315265035))
p = mdb.models['Model-1'].parts['BCC']
e, d1 = p.edges, p.datums
p.CutExtrude(sketchPlane=d1[24], sketchUpEdge=e[60], sketchPlaneSide=SIDE1, 
    sketchOrientation=RIGHT, sketch=s, flipExtrudeDirection=ON)
s.unsetPrimaryObject()
del mdb.models['Model-1'].sketches['__profile__']
###################################cut extrude the external boundaries for normal connection to other array of BCCs: ppxy to -x####################
p = mdb.models['Model-1'].parts['BCC']
e1, d2 = p.edges, p.datums
t = p.MakeSketchTransform(sketchPlane=d2[6], sketchUpEdge=e1[43], 
    sketchPlaneSide=SIDE1, sketchOrientation=RIGHT, origin=(0.0, 1.414214, 
    1.0))
s1 = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
    sheetSize=18.13, gridSpacing=0.45, transform=t)
g, v, d, c = s1.geometry, s1.vertices, s1.dimensions, s1.constraints
s1.setPrimaryObject(option=SUPERIMPOSE)
p = mdb.models['Model-1'].parts['BCC']
p.projectReferencesOntoSketch(sketch=s1, filter=COPLANAR_EDGES)
s1.ConstructionLine(point1=(0.0, 0.7875), point2=(0.0, -0.675000000023283))
s1.VerticalConstraint(entity=g[11], addUndoState=False)
s1.copyMirror(mirrorLine=g[11], objectList=(g[2], ))
s1.rectangle(point1=(-1.41421399999472, 1.0), point2=(1.41421400002382, -1.0))
s1.CoincidentConstraint(entity1=v[0], entity2=g[5], addUndoState=False)
s1.CoincidentConstraint(entity1=v[2], entity2=g[2], addUndoState=False)
s1.rectangle(point1=(-1.63902439187622, 1.1880441904068), point2=(
    1.62919066835785, -1.19593119621277))
session.viewports['Viewport: 1'].view.setValues(nearPlane=14.3174, 
    farPlane=23.3956, width=5.96029, height=2.77455, viewOffsetX=0.551486, 
    viewOffsetY=0.799282)
p = mdb.models['Model-1'].parts['BCC']
e, d1 = p.edges, p.datums
p.CutExtrude(sketchPlane=d1[6], sketchUpEdge=e[43], sketchPlaneSide=SIDE1, 
    sketchOrientation=RIGHT, sketch=s1, flipExtrudeDirection=OFF)
s1.unsetPrimaryObject()
del mdb.models['Model-1'].sketches['__profile__']
###################################cut extrude the external boundaries for normal connection to other array of BCCs: ppxy to x####################
p = mdb.models['Model-1'].parts['BCC']
e1, d2 = p.edges, p.datums
t = p.MakeSketchTransform(sketchPlane=d2[6], sketchUpEdge=e1[136], 
    sketchPlaneSide=SIDE1, sketchOrientation=RIGHT, origin=(0.0, 1.414214, 
    1.0))
s = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
    sheetSize=18.13, gridSpacing=0.45, transform=t)
g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints
s.setPrimaryObject(option=SUPERIMPOSE)
p = mdb.models['Model-1'].parts['BCC']
p.projectReferencesOntoSketch(sketch=s, filter=COPLANAR_EDGES)
s.rectangle(point1=(-1.41421312474619, 1.0), point2=(1.414214, -1.0))
s.rectangle(point1=(-1.61251725267029, 1.18434727191925), point2=(
    1.62631545950317, -1.19947099685669))
p = mdb.models['Model-1'].parts['BCC']
e, d1 = p.edges, p.datums
p.CutExtrude(sketchPlane=d1[6], sketchUpEdge=e[136], sketchPlaneSide=SIDE1, 
    sketchOrientation=RIGHT, sketch=s, flipExtrudeDirection=ON)
s.unsetPrimaryObject()
del mdb.models['Model-1'].sketches['__profile__']
###################################cut extrude the external boundaries for normal connection to other array of BCCs: opxy to -z####################
p = mdb.models['Model-1'].parts['BCC']
e1, d2 = p.edges, p.datums
t = p.MakeSketchTransform(sketchPlane=d2[8], sketchUpEdge=e1[99], 
    sketchPlaneSide=SIDE1, sketchOrientation=RIGHT, origin=(-1.0, 1.414214, 
    2.0))
s1 = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
    sheetSize=18.07, gridSpacing=0.45, transform=t)
g, v, d, c = s1.geometry, s1.vertices, s1.dimensions, s1.constraints
s1.setPrimaryObject(option=SUPERIMPOSE)
p = mdb.models['Model-1'].parts['BCC']
p.projectReferencesOntoSketch(sketch=s1, filter=COPLANAR_EDGES)
s1.rectangle(point1=(-1.41421312474619, 1.0), point2=(1.414214, -1.0))
s1.rectangle(point1=(-1.575, 1.2375), point2=(1.575, -1.125))
p = mdb.models['Model-1'].parts['BCC']
e, d1 = p.edges, p.datums
p.CutExtrude(sketchPlane=d1[8], sketchUpEdge=e[99], sketchPlaneSide=SIDE1, 
    sketchOrientation=RIGHT, sketch=s1, flipExtrudeDirection=OFF)
s1.unsetPrimaryObject()
del mdb.models['Model-1'].sketches['__profile__']
###################################cut extrude the external boundaries for normal connection to other array of BCCs: opxy to z####################
p = mdb.models['Model-1'].parts['BCC']
e1, d2 = p.edges, p.datums
t = p.MakeSketchTransform(sketchPlane=d2[8], sketchUpEdge=e1[53], 
    sketchPlaneSide=SIDE1, sketchOrientation=RIGHT, origin=(-1.0, 1.414214, 
    2.0))
s = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
    sheetSize=17.57, gridSpacing=0.43, transform=t)
g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints
s.setPrimaryObject(option=SUPERIMPOSE)
p = mdb.models['Model-1'].parts['BCC']
p.projectReferencesOntoSketch(sketch=s, filter=COPLANAR_EDGES)
s.rectangle(point1=(-1.41421312474619, 1.0), point2=(1.414214, -1.0))
s.rectangle(point1=(-1.72, 1.1825), point2=(1.72, -1.1825))
p = mdb.models['Model-1'].parts['BCC']
e, d1 = p.edges, p.datums
p.CutExtrude(sketchPlane=d1[8], sketchUpEdge=e[53], sketchPlaneSide=SIDE1, 
    sketchOrientation=RIGHT, sketch=s, flipExtrudeDirection=ON)
s.unsetPrimaryObject()
del mdb.models['Model-1'].sketches['__profile__']
############################################################################################################################
############################## draw circle, create principal xzplane and principal x axis. Then delete the circle#########
#draw the circle extrude
s = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', sheetSize=20.0)
g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints
s.setPrimaryObject(option=STANDALONE)
s.CircleByCenterPerimeter(center=(0.0, 0.0), point1=(0.0, -0.625))
p = mdb.models['Model-1'].Part(name='Plate', dimensionality=THREE_D, 
    type=DEFORMABLE_BODY)
p = mdb.models['Model-1'].parts['Plate']
p.BaseSolidExtrude(sketch=s, depth=2.0)
s.unsetPrimaryObject()
p = mdb.models['Model-1'].parts['Plate']
del mdb.models['Model-1'].sketches['__profile__']
####################creating xz plane
p = mdb.models['Model-1'].parts['Plate']
p.DatumPlaneByPrincipalPlane(principalPlane=XZPLANE, offset=0.0)
#############creating principal x axis
p = mdb.models['Model-1'].parts['Plate']
p.DatumAxisByPrincipalAxis(principalAxis=XAXIS)
#######################deleting the circle extrude
p = mdb.models['Model-1'].parts['Plate']
del p.features['Solid extrude-1']
#################################################################drawing the plate###################
p = mdb.models['Model-1'].parts['Plate']
e, d1 = p.edges, p.datums
t = p.MakeSketchTransform(sketchPlane=d1[2], sketchUpEdge=d1[3], 
    sketchPlaneSide=SIDE1, sketchOrientation=RIGHT, origin=(0.0, 0.0, 0.0))
s = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
    sheetSize=651.15, gridSpacing=16.27, transform=t)
g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints
s.setPrimaryObject(option=SUPERIMPOSE)
p = mdb.models['Model-1'].parts['Plate']
p.projectReferencesOntoSketch(sketch=s, filter=COPLANAR_EDGES)
s.rectangle(point1=(0.0, 0.0), point2=(252.185, -150.4975))
s.CoincidentConstraint(entity1=v[0], entity2=g[2], addUndoState=False)
s.FixedConstraint(entity=v[0])
#dimensioning the plate
s.ObliqueDimension(vertex1=v[3], vertex2=v[0], textPoint=(85.8323211669922, 
    28.3312740325928), value=20.0)
s.ObliqueDimension(vertex1=v[2], vertex2=v[3], textPoint=(51.9094581604004, 
    -45.3226089477539), value=20.0)
p = mdb.models['Model-1'].parts['Plate']
e2, d2 = p.edges, p.datums
#extruding the plate
p.SolidExtrude(sketchPlane=d2[2], sketchUpEdge=d2[3], sketchPlaneSide=SIDE1, 
    sketchOrientation=RIGHT, sketch=s, depth=0.1, flipExtrudeDirection=ON)
s.unsetPrimaryObject()
del mdb.models['Model-1'].sketches['__profile__']
##############################################################################################################
##############################################################################################################
#######################################################################################################################
#####################################material##########################################################################
################BCC material
mdb.models['Model-1'].Material(name='micromat')
mdb.models['Model-1'].materials['micromat'].Density(table=((7.8e-06, ), ))
mdb.models['Model-1'].materials['micromat'].Elastic(table=((200000000.0, 0.3), 
    ))
mdb.models['Model-1'].materials['micromat'].HashinDamageInitiation(table=((
    20000000.0, 10000000.0, 5000000.0, 1000000.0, 10000000.0, 5000000.0), ))
mdb.models['Model-1'].HomogeneousShellSection(name='microshellsection', 
    preIntegrate=OFF, material='micromat', thicknessType=UNIFORM, 
    thickness=0.01, thicknessField='', idealization=NO_IDEALIZATION, 
    poissonDefinition=DEFAULT, thicknessModulus=None, temperature=GRADIENT, 
    useDensity=OFF, integrationRule=SIMPSON, numIntPts=5)
p = mdb.models['Model-1'].parts['BCC']
c = p.cells
cells = c.getSequenceFromMask(mask=('[#1 ]', ), )
region = regionToolset.Region(cells=cells)
p = mdb.models['Model-1'].parts['BCC']
################plate material
mdb.models['Model-1'].Material(name='Platemat')
mdb.models['Model-1'].materials['Platemat'].Density(table=((7.8e-06, ), ))
mdb.models['Model-1'].materials['Platemat'].Elastic(table=((200000000.0, 0.3), 
    ))
mdb.models['Model-1'].materials['Platemat'].Plastic(table=((350000000.0, 
    0.0), (369000000.0, 0.001), (377000000.0, 0.002), (392000000.0, 0.005), (
    403000000.0, 0.008), (412000000.0, 0.011), (423000000.0, 0.015), (
    444000000.0, 0.025), (462000000.0, 0.035), (508000000.0, 0.07), (
    582000000.0, 0.15), (649000000.0, 0.25), (704000000.0, 0.35), (729000000.0, 
    0.4), (752000000.0, 0.45), (774000000.0, 0.5), (794000000.0, 0.55)))
mdb.models['Model-1'].HomogeneousShellSection(name='Platesection', 
    preIntegrate=OFF, material='Platemat', thicknessType=UNIFORM, 
    thickness=0.1, thicknessField='', idealization=NO_IDEALIZATION, 
    poissonDefinition=DEFAULT, thicknessModulus=None, temperature=GRADIENT, 
    useDensity=OFF, integrationRule=SIMPSON, numIntPts=5)
p = mdb.models['Model-1'].parts['Plate']
c = p.cells
cells = c.getSequenceFromMask(mask=('[#1 ]', ), )
region = regionToolset.Region(cells=cells)
p = mdb.models['Model-1'].parts['Plate']
##############################################################################################################
##############################################################################################################
##############################################################################################################
#################################assembly##############################################################
#importing the BCC
a = mdb.models['Model-1'].rootAssembly
a.DatumCsysByDefault(CARTESIAN)
p = mdb.models['Model-1'].parts['BCC']
a.Instance(name='BCC-1', part=p, dependent=ON)
#defining a principal axis to change the linear pattern in one direction. The other one is OK
a = mdb.models['Model-1'].rootAssembly
e11 = a.instances['BCC-1'].edges
a.DatumAxisByTwoPoint(point1=a.instances['BCC-1'].InterestingPoint(
    edge=e11[58], rule=CENTER), point2=a.instances['BCC-1'].InterestingPoint(
    edge=e11[91], rule=CENTER))
#Linear pattern                      $$$$$$$$    Spacing is important. Should be equal to BCC width  $$$$$$$$$$$
a1 = mdb.models['Model-1'].rootAssembly
a1.LinearInstancePattern(instanceList=('BCC-1', ), direction1=(-1.0, 0.0, 0.0), 
    direction2=(0.0, 0.0, 1.0), number1=10, number2=10, spacing1=2.0, 
    spacing2=2.0)
###########################creating a individual part####################
a1 = mdb.models['Model-1'].rootAssembly
a1.InstanceFromBooleanMerge(name='MicrolatticeCore', instances=(
    a1.instances['BCC-1'], a1.instances['BCC-1-lin-1-2'], 
    a1.instances['BCC-1-lin-1-3'], a1.instances['BCC-1-lin-1-4'], 
    a1.instances['BCC-1-lin-1-5'], a1.instances['BCC-1-lin-1-6'], 
    a1.instances['BCC-1-lin-1-7'], a1.instances['BCC-1-lin-1-8'], 
    a1.instances['BCC-1-lin-1-9'], a1.instances['BCC-1-lin-1-10'], 
    a1.instances['BCC-1-lin-2-1'], a1.instances['BCC-1-lin-2-2'], 
    a1.instances['BCC-1-lin-2-3'], a1.instances['BCC-1-lin-2-4'], 
    a1.instances['BCC-1-lin-2-5'], a1.instances['BCC-1-lin-2-6'], 
    a1.instances['BCC-1-lin-2-7'], a1.instances['BCC-1-lin-2-8'], 
    a1.instances['BCC-1-lin-2-9'], a1.instances['BCC-1-lin-2-10'], 
    a1.instances['BCC-1-lin-3-1'], a1.instances['BCC-1-lin-3-2'], 
    a1.instances['BCC-1-lin-3-3'], a1.instances['BCC-1-lin-3-4'], 
    a1.instances['BCC-1-lin-3-5'], a1.instances['BCC-1-lin-3-6'], 
    a1.instances['BCC-1-lin-3-7'], a1.instances['BCC-1-lin-3-8'], 
    a1.instances['BCC-1-lin-3-9'], a1.instances['BCC-1-lin-3-10'], 
    a1.instances['BCC-1-lin-4-1'], a1.instances['BCC-1-lin-4-2'], 
    a1.instances['BCC-1-lin-4-3'], a1.instances['BCC-1-lin-4-4'], 
    a1.instances['BCC-1-lin-4-5'], a1.instances['BCC-1-lin-4-6'], 
    a1.instances['BCC-1-lin-4-7'], a1.instances['BCC-1-lin-4-8'], 
    a1.instances['BCC-1-lin-4-9'], a1.instances['BCC-1-lin-4-10'], 
    a1.instances['BCC-1-lin-5-1'], a1.instances['BCC-1-lin-5-2'], 
    a1.instances['BCC-1-lin-5-3'], a1.instances['BCC-1-lin-5-4'], 
    a1.instances['BCC-1-lin-5-5'], a1.instances['BCC-1-lin-5-6'], 
    a1.instances['BCC-1-lin-5-7'], a1.instances['BCC-1-lin-5-8'], 
    a1.instances['BCC-1-lin-5-9'], a1.instances['BCC-1-lin-5-10'], 
    a1.instances['BCC-1-lin-6-1'], a1.instances['BCC-1-lin-6-2'], 
    a1.instances['BCC-1-lin-6-3'], a1.instances['BCC-1-lin-6-4'], 
    a1.instances['BCC-1-lin-6-5'], a1.instances['BCC-1-lin-6-6'], 
    a1.instances['BCC-1-lin-6-7'], a1.instances['BCC-1-lin-6-8'], 
    a1.instances['BCC-1-lin-6-9'], a1.instances['BCC-1-lin-6-10'], 
    a1.instances['BCC-1-lin-7-1'], a1.instances['BCC-1-lin-7-2'], 
    a1.instances['BCC-1-lin-7-3'], a1.instances['BCC-1-lin-7-4'], 
    a1.instances['BCC-1-lin-7-5'], a1.instances['BCC-1-lin-7-6'], 
    a1.instances['BCC-1-lin-7-7'], a1.instances['BCC-1-lin-7-8'], 
    a1.instances['BCC-1-lin-7-9'], a1.instances['BCC-1-lin-7-10'], 
    a1.instances['BCC-1-lin-8-1'], a1.instances['BCC-1-lin-8-2'], 
    a1.instances['BCC-1-lin-8-3'], a1.instances['BCC-1-lin-8-4'], 
    a1.instances['BCC-1-lin-8-5'], a1.instances['BCC-1-lin-8-6'], 
    a1.instances['BCC-1-lin-8-7'], a1.instances['BCC-1-lin-8-8'], 
    a1.instances['BCC-1-lin-8-9'], a1.instances['BCC-1-lin-8-10'], 
    a1.instances['BCC-1-lin-9-1'], a1.instances['BCC-1-lin-9-2'], 
    a1.instances['BCC-1-lin-9-3'], a1.instances['BCC-1-lin-9-4'], 
    a1.instances['BCC-1-lin-9-5'], a1.instances['BCC-1-lin-9-6'], 
    a1.instances['BCC-1-lin-9-7'], a1.instances['BCC-1-lin-9-8'], 
    a1.instances['BCC-1-lin-9-9'], a1.instances['BCC-1-lin-9-10'], 
    a1.instances['BCC-1-lin-10-1'], a1.instances['BCC-1-lin-10-2'], 
    a1.instances['BCC-1-lin-10-3'], a1.instances['BCC-1-lin-10-4'], 
    a1.instances['BCC-1-lin-10-5'], a1.instances['BCC-1-lin-10-6'], 
    a1.instances['BCC-1-lin-10-7'], a1.instances['BCC-1-lin-10-8'], 
    a1.instances['BCC-1-lin-10-9'], a1.instances['BCC-1-lin-10-10'], ), 
    originalInstances=SUPPRESS, domain=GEOMETRY)
##############################################################################################################
##############################################################################################################
##############################################################################################################
################################importing the plate into assembly########################
a1 = mdb.models['Model-1'].rootAssembly
p = mdb.models['Model-1'].parts['Plate']
a1.Instance(name='Plate-1', part=p, dependent=ON)
#linear pattern of the plate to produce the second plate
a1 = mdb.models['Model-1'].rootAssembly
#bear in mind that the value 2.928 is equal to=sqrt(4^2-(a*sqrt(a))^2)+0.1 where a is the BCC base square width, 4 is the tube length and 0.1
#is the plate thickness
a1.LinearInstancePattern(instanceList=('Plate-1', ), direction1=(1.0, 0.0, 
    0.0), direction2=(0.0, 1.0, 0.0), number1=1, number2=2, spacing1=20.0, 
    spacing2=2.928)	
###########################################code from Macro for surface selection#########################################################
#upper surface micro
i1 = mdb.models['Model-1'].rootAssembly.instances['MicrolatticeCore-1']
leaf = dgm.LeafFromInstance(instances=(i1, ))
a = mdb.models['Model-1'].rootAssembly
s1 = a.instances['MicrolatticeCore-1'].faces
side1Faces1 = s1.getSequenceFromMask(mask=(
	'[#4000 #800008 #80000800 #80000 #8000080 #8000 #10000300', 
	' #8000 #80002 #800020 #8000200 #2000 #40000c #8000200', 
	' #80002000 #20000 #200008 #30000080 #10000 #200008 #2000080', 
	' #20000800 #8000 #c00002 #20000400 #8000 #80002 #800020', 
	' #8000200 #30000 #800010 #8000200 #80002000 #20000 #200008', 
	' #40000c00 #20000 #200008 #2000080 #20000800 #8000 #1000030', 
	' #20000800 #8000 #80002 #800020 #c0000200 #40000 #800020', 
	' #8000200 #80002000 #20000 #3000008 #60000 #c0000300 #300000', 
	' #c00 #c00003 #3000 #c #f ]', ), )
a.Surface(side1Faces=side1Faces1, name='upsurfmicro')	
#bottom surface micro
i1 = mdb.models['Model-1'].rootAssembly.instances['MicrolatticeCore-1']
leaf = dgm.LeafFromInstance(instances=(i1, ))
a = mdb.models['Model-1'].rootAssembly
s1 = a.instances['MicrolatticeCore-1'].faces
side1Faces1 = s1.getSequenceFromMask(mask=(
	'[#4000010 #4000 #400004 #40000400 #40000 #28000040 #40000', 
	' #1000040 #10000400 #4000 #40001 #a00010 #1000 #40001', 
	' #400010 #4000100 #40001000 #28000 #4000040 #40001000 #10000', 
	' #100004 #1000040 #a00 #100001 #1000040 #10000400 #4000', 
	' #40001 #4000028 #4000 #40001 #400010 #4000100 #a0001000', 
	' #100000 #4000100 #40001000 #10000 #100004 #2800040 #4000', 
	' #100004 #1000040 #10000400 #4000 #a0001 #10000100 #4000', 
	' #40001 #400010 #4000100 #2800 #40010010 #20100080 #80400', 
	' #80400201 #201000 #1000804 #2005a002 ]', ), )
a.Surface(side1Faces=side1Faces1, name='downsurfmicro')
#downplate surface
a = mdb.models['Model-1'].rootAssembly
s1 = a.instances['Plate-1'].faces
side1Faces1 = s1.getSequenceFromMask(mask=('[#20 ]', ), )
a.Surface(side1Faces=side1Faces1, name='downsurfplate')
#upplate surf
session.viewports['Viewport: 1'].view.setValues(nearPlane=53.571, 
    farPlane=87.8218, width=25.4468, height=11.8457, cameraPosition=(21.3665, 
    -9.44171, 72.4341), cameraUpVector=(-0.11315, 0.970098, 0.214724))
a = mdb.models['Model-1'].rootAssembly
s1 = a.instances['Plate-1-lin-1-2'].faces
side1Faces1 = s1.getSequenceFromMask(mask=('[#10 ]', ), )
a.Surface(side1Faces=side1Faces1, name='upsurfplate')
