function IIDAnalysis(prices, name) 
    if(sum(isnan(prices)) == 0)
        linear_returns = LinearReturns(prices);
        IIDAnalysis2(linear_returns', strcat(char(name), ': Linear Returns'));
        compounded_returns = CompoundedReturns(prices);    
        IIDAnalysis2(compounded_returns', strcat(char(name), ': Compounded Returns'));
    end
end

% linear returns
function[returns] = LinearReturns(prices)

linear = @(x_0, x_1) (x_1 - x_0) / x_0; % linear return
returns = zeros(1, length(prices) - 1);
for i = 1 : length(returns)
    returns(i) = linear(prices(i), prices(i + 1));
end

end

% compounded returns
function[returns] = CompoundedReturns(prices)

compounded = @(x_0, x_1) log(x_1 / x_0); % compunded return
returns = zeros(1, length(prices) - 1);
for i = 1 : length(returns)
    returns(i) = compounded(prices(i), prices(i + 1));
end

end

function IIDAnalysis2(Data, titleStr)
% this function performs simple invariance (i.i.d.) tests on a time series
% 1. it checks that the variables are identically distributed by looking at the 
%    histogram of two subsamples
% 2. it checks that the variables are independent by looking at the 1-lag scatter plot
% under i.i.d. the location-dispersion ellipsoid should be a circle

% test "identically distributed hypothesis": split observations into two sub-samples and plot histogram
Sample_1=Data(1:round(length(Data)/2));
Sample_2=Data(round(length(Data)/2)+1:end);
num_bins_1=round(5*log(length(Sample_1)));
num_bins_2=round(5*log(length(Sample_2)));
X_lim=[min(Data)-.1*(max(Data)-min(Data)) max(Data)+.1*(max(Data)-min(Data))];
[n1,xout1]=hist(Sample_1,num_bins_1);
[n2,xout2]=hist(Sample_2,num_bins_2);

figure
subplot('Position',[0.03 .52 .44 .42]) 
% Modified by Mihir Sanghavi
h = histfit(Sample_1, num_bins_1, 'normal');
set(h(1),'FaceColor',[.7 .7 .7],'EdgeColor','k')
% End modification
set(gca,'ytick',[],'xlim',X_lim,'ylim',[0 max(max(n1),max(n2))])
grid off

subplot('Position',[.53 .52 .44 .42])
% Modified by Mihir Sanghavi
h = histfit(Sample_2, num_bins_2, 'normal');
set(h(1),'FaceColor',[.7 .7 .7],'EdgeColor','k')
% End modification
set(gca,'ytick',[],'xlim',X_lim,'ylim',[0 max(max(n1),max(n2))]);
grid off

% test "independently distributed hypothesis": scatter plot of observations at lagged times
subplot('Position',[.28 .01 .43 .43])
X=Data(1:end-1);
Y=Data(2:end);
h3=plot(X,Y,'.');
grid off
axis equal
set(gca,'xlim',X_lim,'ylim',X_lim);
title(titleStr);

m=mean([X Y])';
S=cov([X Y]);
TwoDimEllipsoid(m,S,2,0,0);
end

function TwoDimEllipsoid(Location,Square_Dispersion,Scale,PlotEigVectors,PlotSquare)
% this function computes the location-dispersion ellipsoid 
% see "Risk and Asset Allocation"-Springer (2005), by A. Meucci

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute the ellipsoid in the r plane, solution to  ((R-Location)' * Dispersion^-1 * (R-Location) ) = Scale^2                                   
[EigenVectors,EigenValues] = eig(Square_Dispersion);
EigenValues=diag(EigenValues);
Centered_Ellipse=[]; 
Angle = [0 : pi/500 : 2*pi];
NumSteps=length(Angle);
for i=1:NumSteps
    y=[cos(Angle(i))                                   % normalized variables (parametric representation of the ellipsoid)
        sin(Angle(i))];
    Centered_Ellipse=[Centered_Ellipse EigenVectors*diag(sqrt(EigenValues))*y];  
end
R= Location*ones(1,NumSteps) + Scale*Centered_Ellipse;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%draw plots

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot the ellipsoid
hold on
h=plot(R(1,:),R(2,:));
set(h,'color','r','linewidth',2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot a rectangle centered in Location with semisides of lengths Dispersion(1) and Dispersion(2), respectively
if PlotSquare
    Dispersion=sqrt(diag(Square_Dispersion));
    Vertex_LowRight_A=Location(1)+Scale*Dispersion(1); Vertex_LowRight_B=Location(2)-Scale*Dispersion(2);
    Vertex_LowLeft_A=Location(1)-Scale*Dispersion(1); Vertex_LowLeft_B=Location(2)-Scale*Dispersion(2);
    Vertex_UpRight_A=Location(1)+Scale*Dispersion(1); Vertex_UpRight_B=Location(2)+Scale*Dispersion(2);
    Vertex_UpLeft_A=Location(1)-Scale*Dispersion(1); Vertex_UpLeft_B=Location(2)+Scale*Dispersion(2);
    
    Square=[Vertex_LowRight_A            Vertex_LowRight_B 
        Vertex_LowLeft_A             Vertex_LowLeft_B 
        Vertex_UpLeft_A              Vertex_UpLeft_B
        Vertex_UpRight_A             Vertex_UpRight_B
        Vertex_LowRight_A            Vertex_LowRight_B];
        hold on;
        h=plot(Square(:,1),Square(:,2));
        set(h,'color','r','linewidth',2)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot eigenvectors in the r plane (centered in Location) of length the
% square root of the eigenvalues (rescaled)
if PlotEigVectors
    L_1=Scale*sqrt(EigenValues(1));
    L_2=Scale*sqrt(EigenValues(2));
    
    % deal with reflection: matlab chooses the wrong one
    Sign= sign(EigenVectors(1,1));
    Start_A=Location(1);                               % eigenvector 1
    End_A= Location(1) + Sign*(EigenVectors(1,1)) * L_1;
    Start_B=Location(2);
    End_B= Location(2) + Sign*(EigenVectors(1,2)) * L_1;
    hold on
    h=plot([Start_A End_A],[Start_B End_B]);
    set(h,'color','r','linewidth',2)
    axis equal;
    
    Start_A=Location(1);                               % eigenvector 2
    End_A= Location(1) + (EigenVectors(2,1)* L_2);
    Start_B=Location(2);
    End_B= Location(2) + (EigenVectors(2,2)* L_2);
    hold on;
    h=plot([Start_A End_A],[Start_B End_B]);
    set(h,'color','r','linewidth',2)
end

grid on

end
