function merge(dest, source)
    for k,v in pairs(source) do
        dest[k] = dest[k] or v
    end
    return dest
end