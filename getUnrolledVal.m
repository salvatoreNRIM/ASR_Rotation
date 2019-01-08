function [UnrolledCell] = getUnrolledVal(struct_in,UnrolledCell)
fields_list = fieldnames(struct_in);
for i=1:length(fields_list)
    field = fields_list{i};
    if isstruct(struct_in.(field))
        UnrolledCell = getUnrolledVal(struct_in.(field),UnrolledCell);
    else
        UnrolledCell = [UnrolledCell; {field} {struct_in.(field)}];
    end
end

end