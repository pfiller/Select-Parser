root = exports ? this

class SelectParser
  
  constructor: ->
    @group_index = 0
    @sel_index = 0
    @parsed = []

  add_node: (child) ->
    if child.nodeName is "OPTGROUP"
      this.add_group child
    else
      this.add_option child

  add_group: (group) ->
    group_id = @sel_index + @group_index
    @parsed.push
      id: group_id
      group: true
      label: group.label
      position: @group_index
      children: 0
      disabled: group.disabled
    this.add_option( option, group_id, group.disabled ) for option in group.childNodes
    @group_index += 1

  add_option: (option, group_id, group_disabled) ->
    if option.nodeName is "OPTION" and (@sel_index > 0 or option.text != "")
      if group_id || group_id is 0
        @parsed[group_id].children += 1
      @parsed.push
        id: @sel_index + @group_index
        select_index: @sel_index
        value: option.value
        text: option.text
        selected: option.selected
        disabled: ((group_disabled is true) ? group_disabled : option.disabled)
        group_id: group_id
      @sel_index += 1

SelectParser.select_to_array = (select) ->
  parser = new SelectParser()
  parser.add_node( child ) for child in select.childNodes
  parser.parsed
  
root.SelectParser = SelectParser

get_side_border_padding = (elmt) ->
  layout = new Element.layout(elmt)
  side_border_padding = layout.get("border-left") + layout.get("border-right") + layout.get("padding-left") + layout.get("padding-right")

root.get_side_border_padding = get_side_border_padding