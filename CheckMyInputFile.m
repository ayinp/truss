% --- CHECK  MY TRUSS INPUT FILE ---
% ENG EK301, Caleb Farny, 4/2023

% Goal: Run this file to check whether your input file is correctly
% formatted and all expected variables are present.

filename = input('What is the name of your input file (use quotes)? ')
disp('*IF* file cannot be loaded correctly or an error occurs, the input type is not of type .mat and needs to be addressed')
load(filename)
disp('File successfully loaded. Checking for variables...')

loadedvars = whos;
% -- check for variables --
if exist('C') == 0
    disp('C matrix is missing')
else
    [NumJoints, NumMembers] = size(C);
    cnt = 1;
    if NumJoints*2-3 ~= NumMembers
        disp('Number of joints and members do not correspond to a simple truss')
        cnt = cnt-1;
    end
end

if exist('Sx') == 0
    disp('Sx matrix is missing')
else
    [Sxj,Sxm] = size(Sx);
    if Sxj ~= NumJoints
        disp('Sx matrix does not match number of joints in C matrix')
    else
        cnt = cnt+1;
    end
end

if exist('Sy') == 0
    disp('Sy matrix is missing')
else
    [Syj,Sym] = size(Sy);
    if Syj ~= NumJoints
        disp('Sy matrix does not match number of joints in C matrix')
    else
        cnt = cnt+1;
    end
end

if exist('X') == 0
    disp('X matrix is missing')
else
    SXj = length(X);
    if SXj ~= NumJoints
        disp('X matrix does not match number of joints in C matrix')
    else
        cnt = cnt+1;
    end
end

if exist('Y') == 0
    disp('Y matrix is missing')
else
    SYj = length(Y);
    if SYj ~= NumJoints
        disp('Y matrix does not match number of joints in C matrix')
    else
        cnt = cnt+1;
    end
end

if exist('L') == 0
    disp('L matrix is missing')
else
    SLj = length(L);
    if SLj ~= NumJoints*2
        disp('L matrix does not match number of joints in C matrix')
    else
        cnt = cnt+1;
    end
end

if cnt == 6
    disp('Variables correctly loaded and correspond to the correct number of joints and members')
    disp('Go ahead and upload your file!')
end

