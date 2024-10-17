function AstroGaggleGame
    % Create the figure
    hFig = figure('Name', 'Astro-Gaggle: The Cosmic Pranksters', ...
                  'Position', [100, 100, 800, 600], ...
                  'KeyPressFcn', @keyPressHandler, ...
                  'CloseRequestFcn', @closeGame);
    
    % Create axes for graphics
    ax = axes('Parent', hFig, 'Position', [0, 0, 1, 1]);
    axis equal;
    axis([-10 10 -10 10]);
    set(ax, 'Color', 'black');
    hold on;

    % Draw planets
    numPlanets = 5;
    planets = rand(numPlanets, 2) * 15 - 7.5; % Random positions for planets
    planetColors = lines(numPlanets); % Colormap for planets

    % Draw planets
    for i = 1:numPlanets
        rectangle('Position', [planets(i,1)-0.5, planets(i,2)-0.5, 1, 1], ...
                  'Curvature', [1, 1], 'FaceColor', planetColors(i,:), ...
                  'EdgeColor', 'none');
    end

    % Initialize player alien
    playerX = 0;
    playerY = 0;
    playerColor = [0, 1, 0]; % Bright green alien

    % Draw player alien
    playerAlien = rectangle('Position', [playerX-0.25, playerY-0.25, 0.5, 0.5], ...
                            'Curvature', [1, 1], 'FaceColor', playerColor, ...
                            'EdgeColor', 'none');

    % Add instructions
    uicontrol('Style', 'text', 'String', 'Use Arrow Keys to Move', ...
              'Position', [10, 550, 200, 20], 'BackgroundColor', 'white');

    % Main game loop
    while ishandle(hFig)
        pause(0.1); % Prevents busy-waiting
    end

    function keyPressHandler(~, event)
        switch event.Key
            case 'leftarrow'
                playerX = playerX - 0.5; % Move left
            case 'rightarrow'
                playerX = playerX + 0.5; % Move right
            case 'uparrow'
                playerY = playerY + 0.5; % Move up
            case 'downarrow'
                playerY = playerY - 0.5; % Move down
        end

        % Update player alien position
        set(playerAlien, 'Position', [playerX-0.25, playerY-0.25, 0.5, 0.5]);

        % Check for collision with planets
        for i = 1:numPlanets
            if abs(playerX - planets(i, 1)) < 0.75 && abs(playerY - planets(i, 2)) < 0.75
                % Cosmic prank logic
                prank = ['You pulled a prank on planet ', num2str(i), '! 🌌🤣'];
                disp(prank);
                % Update position of the planet to simulate interaction
                planets(i, :) = rand(1, 2) * 15 - 7.5; % Move planet
                rectangle('Position', [planets(i,1)-0.5, planets(i,2)-0.5, 1, 1], ...
                          'Curvature', [1, 1], 'FaceColor', planetColors(i,:), ...
                          'EdgeColor', 'none');
            end
        end
    end

    function closeGame(~, ~)
        delete(hFig); % Close the game window
    end
end

