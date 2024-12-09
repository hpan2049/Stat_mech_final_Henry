function [SAW, flag] = connect(selected_piece, other_piece, piece_select)
    flag = false;
    if piece_select == 0
        sp_shift = selected_piece-selected_piece(end,:)+other_piece(1,:);
        SAW = [sp_shift; other_piece(2:end,:)];
    else
        sp_shift = selected_piece-selected_piece(1,:)+other_piece(end,:);
        SAW = [other_piece(1:end-1,:); sp_shift];
    end
    uniquerow = size(unique(SAW, 'rows'), 1);
    if uniquerow == size(SAW, 1)
        flag = true;
    end
end

