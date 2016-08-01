function isDirectory(path)
   local lastChar = string.sub(path, #path, #path);
 
   return ( lastChar == "/" ) or ( lastChar == "\\" );
end

function transformModulePath(path)
    return ("%s%s"):format(BASE_MODULE_LOC_REL, path)
end

function isModuleValid(path)
    return fileExists(("%s/meta.xml"):format(transformModulePath(path)))
end

function merge(dest, source)
    for k,v in pairs(source) do
        dest[k] = dest[k] or v
    end
    return dest
end

function table.find(tab, value)
	for k, v in pairs(tab) do
		if v == value then
			return k
		end
	end
	return nil
end