function [R, attempt] = pivot(N, d, success_goal)
    % start the pivot method by generating a SAW with dimerizatrion method
    [starting_SAW, attempt] = dimerization(N, d);
    current_SAW = starting_SAW;
    accepted = 0;
    numberset = [-4:-1,1:4];
    R = zeros(1, success_goal);
    success_rate = zeros(1, success_goal);
    while accepted < success_goal
        pivot_bead = randi([2, N-1]);
        piece_select = randi([0, 1]);
        selected_piece = current_SAW(1+(pivot_bead-1)*(piece_select):...
            pivot_bead+(end-pivot_bead)*piece_select, :);
        other_piece = current_SAW(1+(pivot_bead-1)*(~piece_select):...
            pivot_bead+(end-pivot_bead)*~piece_select, :);
        
        if piece_select == 0
            selected_piece = flipud(selected_piece);
        end
        
        symmetry_type = numberset(randi(length(numberset)));
        symmetry_axis = randi(d);
        rotation_about = randi(d*(d-1)/2);
        
        switch abs(symmetry_type)
            case 1 %90 degree rotation
                new_piece = rotation(selected_piece, rotation_about, ...
                    sign(symmetry_type)*pi/2, d);
            case 2 %180 degree rotation
                new_piece = rotation(selected_piece, rotation_about, pi, d);
            case 3 % axis reflections
                old_origin = selected_piece(1, :);
                sp_shift = selected_piece - selected_piece(1, :);
                sp_shift(:, symmetry_axis) = -sp_shift(:, symmetry_axis);
                new_piece = sp_shift + old_origin;
            case 4 % diagonal reflections
                new_piece = diagonal(selected_piece,d);
        end
        if piece_select == 0
            new_piece = flipud(new_piece);
        end
        [new_SAW, flag] = connect(new_piece, other_piece, piece_select);
        if flag
            accepted = accepted + 1;
            R(accepted) = sqrt(sum((new_SAW(end, :) - new_SAW(1, :)).^2));
            success_rate(accepted) = 0; % change later
            current_SAW = new_SAW;
        else
            accepted = accepted + 1;
            R(accepted) = sqrt(sum((current_SAW(end, :) - current_SAW(1, :)).^2));
        end
    end
end

