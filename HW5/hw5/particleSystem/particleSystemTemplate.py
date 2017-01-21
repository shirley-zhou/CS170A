# -*- coding: utf-8 -*-
"""
Particle System.

@author: luisangel
"""
# Library imports.
# Library imports.
import numpy as np;
import csv;
from matplotlib import pyplot as plt;
from scipy.optimize import newton;
from matplotlib import animation;

# Path to FFMPEG codec for video writing.
#plt.rcParams['animation.ffmpeg_path'] = '/path/to/your/ffmpeg/binary/file';



############################# Support functions ###############################

# Ellipse implicit form: x^2/a^2 + y^2/b^2 = 1.
# If x^2/a^2 + y^2/b^2 <= 1, we are inside ellipse.
# If x^2/a^2 + y^2/b^2 > 1, we are outside ellipse.
def implicitEllipse( xe, ye ): 
    return (xe/a)**2 + (ye/b)**2;

# Unit normal to ellipse at point (xn, yn).
def normal( xn, yn ): 
    n = np.array( [2*xn/(a**2), 2*yn/(b**2)] );
    return n/np.linalg.norm( n );



#***************************** Geometry constants *****************************

# Elliptic playground.
a = 20;                                 # Semiaxis on x.
b = 10;                                 # Semiaxis on y.
t = np.linspace( 0, 2*np.pi, 200 );     # The ellipse is centered on the coordinate origin.
xEllipse = a*np.cos( t );
yEllipse = b*np.sin( t );
    
# Initial velocity limits.
minV = -5;
maxV = +5;                              # Apply to both x and y components.
diffV = maxV - minV;                    # Velocity difference. (Useful for random generation of velocities).



#****************** Simulation constants and variables ************************

gravity = np.array( [0, -9.81] );       # Gravity force g.
restCoeff = 0.9;                        # Bounciness coefficient: 0 - inelastic, 1 - fully elastic.

deltaT = 0.01;                          # Simulation time control variables.
simulationTime = 0.0;
maxSimulationTime = 10.0;



#****************************** Particles' array ******************************

# Particle structure/object format:
# particle = { 'position': np.array([x, y]),
#              'velocity': np.array([x, y]),
#              'color': tuple([r,g,b]),
#              'mass': m,
#              'index': I }

## TODO: Load particle properties from a CSV file #############################
#
# Open the csv file here, and get prepared for reading it. 
#
# particles = list();                    # List of particles.
# I = 0;
# for each row in the csv file:
#    Make sure you're reading in (float) numbers!!!
#    obj = {};
#    obj['position'] = ?                 # Position.
#    obj['velocity'] = ?                 # Velocity.
#    obj['color'] = tuple( ? );          # Color (a tuple!!!)
#    obj['mass'] = ?;                    # Mass.
#    obj['index'] = I;                   # Auxiliary index.
#    particles.append( obj );            # Add particle to list.
#    I += 1;
#
# Close your csv file here.
#
###############################################################################



#*************************** Preparing the animation **************************

fig = plt.figure();                                     # Figure where animation will be executed.
ax = plt.axes( xlim=(-a-2, a+2), ylim=(-b-2, b+2) );    # Plotting axes object.
line, = ax.plot( [], [], color='black', linewidth=2 );  # Elliptic boundary.
parts = list();                                         # We need a list with particles information.
for particle in particles:
    parts.extend( ax.plot( [], [], marker='o',          # Allocate drawing space for each particle.
        markeredgecolor='0.5', markersize=10, markerfacecolor=particle['color'] ) );



#*************************** The animation function ***************************
# It'll be called sequentially. nFrame is a dummy variable for frame number.

def simulate( nFrame ):
    global simulationTime;              # Will be using global scope simulation time variable.
    
    line.set_data(xEllipse, yEllipse);  # Indicate we want to draw the ellipse.
    
    for particle in particles:          # Find next position for each particle.
        
        ## TODO: Compute current particle's new location and velocity #########
        #
        # particle['velocity'] = ?      # Integrate acceleration into new velocity.
        # particle['position'] = ?      # Integrate velocity into new position.
        #
        #######################################################################
        
        # Check collisions (i.e. particle has gone outside ellipse).
        pX = particle['position'][0];           # Shortcuts to possible new position components: x and y.
        pY = particle['position'][1];
        
        if( implicitEllipse( pX, pY ) > 1 ):    # pX^2/a^2 + pY^2/b^2 > 1 ?
            
            ## TODO: Find nearest location of particle on the ellipse #########
            #
            # t0 = ?;                           # Pick an initial value to start Newton's method.
            #
            # df = lambda t: ?                  # Function we want to find the root of.            
            #
            # tStar = newton( ? )               # t value for which the distance between particle and ellipse
            #                                   # is minimal.
            # particle['position'] = ?          # Use tStar to relocate particle ON the ellipse.         
            #
            ###################################################################
            
            # Compute a new velocity based on the normal at the point where
            # the particle went through the ellipse (found previously).
            nHat = normal( particle['position'][0], particle['position'][1] );    # Normal vector.
            vProj = (particle['velocity'].dot( nHat ))*nHat;
            particle['velocity'] = restCoeff*(-2*vProj + particle['velocity']);
        
        # Set drawing coordinates for this particle at its new position.
        parts[particle['index']].set_data( particle['position'][0], particle['position'][1] );
    
    print( 'Simulation time: %.2f' % simulationTime );
    
    simulationTime += deltaT;                   # Advance time.
    return tuple([line] + parts);               # New position information for ellipse and particles.



#***************************** The animator object ****************************

anim = animation.FuncAnimation( fig, simulate,
                                frames = int(maxSimulationTime/deltaT), 
                                interval = int(deltaT*1000),
                                repeat = False );

plt.show();					# Show figure;

# Save the animation as an mp4.  This requires ffmpeg or mencoder to be
# installed.  The extra_args ensure that the x264 codec is used.  
# You may need to adjust this for your system: for more information, see
# http://matplotlib.sourceforge.net/api/animation_api.html.
#FFwriter = animation.FFMpegWriter();
#anim.save('particles.mp4', writer=FFwriter, fps=30, extra_args=['-vcodec', 'libx264']);