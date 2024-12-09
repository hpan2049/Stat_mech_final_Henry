function [sp_restored] = diagonal(selected_piece, d)
% randomly reflect and rotate the thing by 90 degrees about random axis
    old_origin = selected_piece(1,:);
    reflection_axis = randi(d);
    rotation_mode = randi(d*(d-1)/2);
    angle = [-pi/2, pi/2];
    rotation_angle = angle(randi(2));
    sp_shift = selected_piece-old_origin;
    sp_shift(:, reflection_axis) = -sp_shift(:, reflection_axis);
    sp_rotated = rotation(sp_shift, rotation_mode, rotation_angle, d);
    sp_restored = sp_rotated+old_origin;
end