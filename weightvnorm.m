for k = 30:30
    kk = 36 +2*k;
    test = imread('T:\\Insung\\rotationandcrop14801510\\100_segmentation_evennumber14801510\\761.tiff');
    V1 = zeros(size(test,1), size(test,2), (784-415+1) );
    V2 = zeros(size(test,1), size(test,2), (784-415+1) );
    
    for i = 415:784
         
        test = imread(sprintf('T:\\Insung\\rotationandcrop14801510\\%d_segmentation_evennumber14801510\\%d.tiff', kk, i));
        V1(:,:, -(i-785))=test;
        
    end   
    
    for i = 415:784
         
        test = imread(sprintf('T:\\Insung\\rotationandcrop14801510\\%d_segmentation_evennumber14801510\\%d.tiff', kk+4, i));
        V2(:,:, -(i-785))=test;
        
    end
    
    FV1 = isosurface(V1, 0.5);
    FV11 = smoothpatch(FV1, 1, 25);

    temp = FV11.vertices(:,2);
    FV11.vertices(:,2) = FV11.vertices(:,3);
    FV11.vertices(:,3) = temp;

    FV2 = isosurface(V2, 0.5);
    FV22 = smoothpatch(FV2, 1, 25);

    temp = FV22.vertices(:,2);
    FV22.vertices(:,2) = FV22.vertices(:,3);
    FV22.vertices(:,3) = temp;
    
    if kk==96
         FV22.vertices = FV22.vertices + [5,0,0];
    else
         FV22.vertices = FV22.vertices;
    end

    centroidList = (FV11.vertices(FV11.faces(:,1),:) + ... 
        FV11.vertices(FV11.faces(:,2),:) + FV11.vertices(FV11.faces(:,3),:))/3; % : makes 3 lines, if no : just column 1

    [IDX, D] = knnsearch(FV22.vertices, centroidList);
    %normV = ((FV22.vertices) - centroidList)/80*0.65;
    %normV = ((FV22.vertices(IDX(kk),:)) - centroidList)/80*0.65;
    %normV = (FV22.vertices(IDX(kk)) - centroidList)/80*0.65;
    %normV = ((IDX-centroidList)/(80)) * 0.65;
    %normV = (D/(80)) * 0.65;
    norm_V = ((FV22.vertices(IDX,:)) - centroidList)/80*0.65;
    
    %Calculate N
    e1 = FV11.vertices(double(FV11.faces(:,1)),:) - ...
        FV11.vertices(double(FV11.faces(:,2)),:);
    e3 = FV11.vertices(double(FV11.faces(:,3)),:) - ...
        FV11.vertices(double(FV11.faces(:,1)),:);
    N = cross(e3,e1);                           % Flipped 9/30/15
    N(any(isnan(N), 2), :) = [];
    Nabs = repmat(sqrt(dot(N,N,2)),1,3);        % Magnitude of normal vectors
    N = N ./ Nabs;
    
    normV = sign(dot(N,norm_V,2)).*(D/(80)) * 0.65;
%     
    [~, M, countreturn, surfareaQC] = normCalcV(FV11, normV, 'stereographic');
    % sum of normal velocity
    j1 = sum(sum(countreturn(30:39,:)));
    j2 = sum(sum(countreturn(40:49,:)));
    j3 = sum(sum(countreturn(50:59,:)));
    j4 = sum(sum(countreturn(60:69,:)));
    j5 = sum(sum(countreturn(70:79,:)));
    j6 = sum(sum(countreturn(80:89,:)));
    j7 = sum(sum(countreturn(90:99,:)));
    j8 = sum(sum(countreturn(1:9,:)+countreturn(100,:)));
    j9 = sum(sum(countreturn(10:19,:)));
    j10 = sum(sum(countreturn(20:29,:)));
    
    
    [~, M, countreturn, surfareaQC] = normCalc(FV11, 'stereographic', [0, 0, -1]);
    %fraction of surface QC
    k1 = sum(sum(countreturn(30:39,:)));
    k2 = sum(sum(countreturn(40:49,:)));
    k3 = sum(sum(countreturn(50:59,:)));
    k4 = sum(sum(countreturn(60:69,:)));
    k5 = sum(sum(countreturn(70:79,:)));
    k6 = sum(sum(countreturn(80:89,:)));
    k7 = sum(sum(countreturn(90:99,:)));
    k8 = sum(sum(countreturn(1:9,:)+countreturn(100,:)));
    k9 = sum(sum(countreturn(10:19,:)));
    k10 = sum(sum(countreturn(20:29,:)));
    % average value
    l1 =j1/k1
    l2 =j2/k2
    l3 =j3/k3
    l4 =j4/k4
    l5 =j5/k5
    l6 =j6/k6
    l7 =j7/k7
    l8 =j8/k8
    l9 =j9/k9
    l10 =j10/k10
    
    %close all;
    
end    