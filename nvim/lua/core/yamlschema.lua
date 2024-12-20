local M = {}

local display_schema_item = function(schema)
    return schema.name or schema.uri
end

local select_schema = function(schema)
    if not schema then
        return
    end
    local selected_schema = { name = schema.name, uri = schema.uri }
    require("yaml-companion.context").schema(0, selected_schema)
end

M.pick_yaml_schema = function()
    local schemas = require("yaml-companion.schema").all()

    -- Don't open selection if there are no available schemas
    if #schemas == 0 then
        return
    end

    -- Convert schemas to a format suitable for fzf-lua display
    local schema_list = {}
    for _, schema in ipairs(schemas) do
        table.insert(schema_list, display_schema_item(schema))
    end

    -- Use fzf-lua to display the picker and handle the selection
    require("fzf-lua").fzf_exec(schema_list, {
        prompt = "Select a schema: ",
        actions = {
            ["default"] = function(selected)
                -- Find the corresponding schema by display item and pass it to select_schema
                for i, display_name in ipairs(schema_list) do
                    if display_name == selected[1] then
                        select_schema(schemas[i])
                        break
                    end
                end
            end,
        },
    })
end

return M
