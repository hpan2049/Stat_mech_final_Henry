function [new_piece] = rotation(selected_piece, rotation_about, angle_rad, d)
    old_origin = selected_piece(1,:);
    piece_origin = selected_piece-selected_piece(1,:);
    SO = eye(d);
    entry_array = zeros(1, d-1); % Initialize the array with d-1 entries

    for i = 1:(d-1)
        n = d - (i - 1); % Decreasing n from d to 2
        entry_array(i) = n * (n - 1) / 2;
    end
    
    id = find(entry_array >= rotation_about, 1, 'last');
    id_entry = entry_array(id);
    SO(id, id) = cospi(angle_rad/pi);
    SO(id, 1+id+id_entry-rotation_about) = -sinpi(angle_rad/pi);
    SO(1+id+id_entry-rotation_about, id) = sinpi(angle_rad/pi);
    SO(1+id+id_entry-rotation_about, 1+id+id_entry-rotation_about) = cospi(angle_rad/pi);

    new_piece = (SO*piece_origin')'+old_origin;
    
end

