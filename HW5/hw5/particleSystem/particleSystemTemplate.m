%% A particle system simulation.

% The playground has elliptic shape in 2D.
a = 20;     % Radius on x axis.
b = 10;     % Radius on y axis.

% Ellipse implicit form: x^2/a^2 + y^2/b^2 = 1.
% If x^2/a^2 + y^2/b^2 <= 1, we are inside ellipse.
% If x^2/a^2 + y^2/b^2 > 1, we are outside ellipse.
implicitEllipse = @( xe, ye ) (xe/a).^2 + (ye/b).^2;

% Unit normal to ellipse at point (xn, yn).
normal = @(xn, yn) [2*xn/(a^2) 2*yn/(b^2)]/norm( [2*xn/(a^2) 2*yn/(b^2)] );

% Initial velocity limits.
minV = -5;
maxV = +5;    % Apply to both x and y components.

% Particle structure/object format:
%   particle.position = [x, y]      :: 2D vector.
%   particle.velocity = [x, y]      :: 2D vector.
%   particle.color = [r, g, b]      :: 3D vector.
%   particle.mass = m               :: A scalar.

% Particles array.
particlesCount = 10;

%% TODO: Load particle properties from the CSV file %%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Read in the csv file here.
P = csvread('particleData.csv', 1, 0);

for I = 1:particlesCount
     particles(I).position = [P(I, 1), P(I, 2)];       % Position.
     particles(I).velocity = [P(I, 3), P(I, 4)];       % Velocity.
     particles(I).color = [P(I, 5), P(I, 6), P(I, 7)];          % Color.
     particles(I).mass = P(I, 8);           % Mass.
end;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The only force acting on particles is gravity. This is the acceleration constant g.
gravity = [0 -9.81];

% Bounciness coefficient.
restCoeff = 0.9;                            % 0 - inelastic, 1 - fully elastic.

% The boundary for collisions (an ellipse centered at the origin).
t = linspace( 0, 2*pi, 200 );
xEllipse = a*cos( t );
yEllipse = b*sin( t );

% Define time control variables.
deltaT = 0.01;
simulationTime = 0.0;
maxSimulationTime = 10.0;

% Prepare figure for plotting simulation.
set( 0, 'Units', 'pixels' );                % Set default units to pixels. 
screenSize = get( 0, 'ScreenSize' );        % Get screen size and position.
figure( 'Renderer', 'OpenGL', ...
    'OuterPosition', [screenSize(3)/2-350 screenSize(4)/2-250 700 500]);

%vidObj = VideoWriter('particles.avi');
%open(vidObj);                               % Create a movie file.

% Simulation loop.
while( simulationTime < maxSimulationTime )
    plot( xEllipse, yEllipse, 'Color', 'black', 'LineWidth', 2 );   % Draw ellipse.
    hold on;
    for I = 1:particlesCount                % Solve for each particle: find its new position.
        
        %% TODO: Compute new velocity and position for the Ith particle %%%
        %
         oldV = particles(I).velocity;
         particles(I).velocity = oldV + deltaT * gravity;        % Integrate acceleration to find new velocity.;
         particles(I).position = particles(I).position + deltaT * oldV;        % Integrate velocity to find new position.
        %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Check collisions (i.e. if particle has gone outside ellipse).
        pX = particles(I).position(1);      % These are just shortcuts to particle x and y coordinate.
        pY = particles(I).position(2);
        
        if( implicitEllipse( pX, pY ) > 1 ) % pX^2/a^2 + pY^2/b^2 > 1 ?
            
            %% TODO: Find nearest location of particle on the ellipse %%%%%
            %
            % Function for which you want to find a root.
             df = @(t) 2*b*cos(t)*(b*sin(t) - pY) - 2*a*sin(t)*(a*cos(t) - pX);
            %
            % Pick an initial value to launch Newton's method.
             t0 = atan2(pY, pX);
            %
            % t value for which the distance between ellipse and particle is minimal.
             tStar = fzero( df, t0 );
            %
            % Use tStar to relocate particle ON the ellipse
             particles(I).position = [a*cos(tStar) b*sin(tStar)];
            %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            % Compute a new velocity based on the normal at the point where
            % the particle went through the ellipse (found previously).
            nHat = normal( particles(I).position(1), particles(I).position(2) );    % Normal vector.
            vProj = (particles(I).velocity * nHat')*nHat;
            particles(I).velocity = restCoeff*(-2*vProj + particles(I).velocity);   % Flipped and scaled velocity.
        end;
        
        % Draw particle at its new position.
        plot( particles(I).position(1), particles(I).position(2), ...
            'Marker', 'o', ...
            'MarkerEdgeColor', particles(I).color*0.5, ...
            'MarkerSize', 10, ...
            'MarkerFaceColor', particles(I).color );
    end;
    text( 0, b+1, sprintf( 'Simulation time: %f', simulationTime ),...
        'FontSize', 14, 'HorizontalAlign', 'center' );
    xlim( [-a-2 a+2] );
    ylim( [-b-2 b+2] );                         % Give some room for ellipse.
    axis equal;
    hold off;                                   % Frame just finished drawing!
    
    drawnow;                                    % Instruct MatLab to refresh plot.
    %writeVideo( vidObj, getframe() );
    
    simulationTime = simulationTime + deltaT;   % Advance time.
end;

% Close video file.
%close( vidObj );

