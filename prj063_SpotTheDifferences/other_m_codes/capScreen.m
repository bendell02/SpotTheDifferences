function IM = capScreen
ge = java.awt.GraphicsEnvironment.getLocalGraphicsEnvironment();
    gd = ge.getScreenDevices;
    
    robot = java.awt.Robot;
    
    for i = 1:numel(gd)
        bounds = gd(i).getDefaultConfiguration.getBounds;
    
        width  = bounds.getWidth();
        height = bounds.getHeight();
        left   = bounds.getX;
        top    = bounds.getY;
    
        im = zeros(height,width,3,'uint8');
        bimg = robot.createScreenCapture(java.awt.Rectangle(left, top, width, height));
        RGBA = bimg.getRGB(0,0,width,height,[],0,width);
        RGBA = typecast(RGBA, 'uint8');
        im(:,:,1) = reshape(RGBA(3:4:end),width,height).';
        im(:,:,2) = reshape(RGBA(2:4:end),width,height).';
        im(:,:,3) = reshape(RGBA(1:4:end),width,height).';    
        
        IM{i} = im; 
    end
        
    figure;
    N = numel(IM);
    for i = 1:N
        subplot(N,1,i);
        image(IM{i});
        axis equal tight
        
    end
end