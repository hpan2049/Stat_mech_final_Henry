function [SAW, flag] = connectDimer(SAW1,SAW2)
    flag = false;
    SAW2_shift = SAW2-SAW2(1, :)+SAW1(end,:);
    SAW = [SAW1(1:end-1,:); SAW2_shift];
    uniquerow = size(unique(SAW, 'rows'), 1);
    if uniquerow < size(SAW, 1)
        SAW1_shift = SAW1-SAW1(1, :)+SAW2(end,:);
        SAW = [SAW2(1:end-1,:); SAW1_shift];
        uniquerow = size(unique(SAW, 'rows'), 1);
        if uniquerow == size(SAW, 1)
            flag = true;
        end
    else
        flag = true;
    end
end
