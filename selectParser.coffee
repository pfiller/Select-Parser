root = exports ? this

class SelectParser
  
  constructor: ->
    @options_index = 0
    @parsed = []

  add_node: (child) ->
    if child.nodeName is "OPTGROUP"
      this.add_group child
    else
      this.add_option child

  add_group: (group) ->
    group_position = @parsed.length
    @parsed.push
      array_index: group_position
      group: true
      label: group.label
      children: 0
      disabled: group.disabled
    this.add_option( option, group_position, group.disabled ) for option in group.childNodes

  add_option: (option, group_position, group_disabled) ->
    if option.nodeName is "OPTION"
      if option.text != ""
        if group_position?
          @parsed[group_position].children += 1
        @parsed.push
          array_index: @parsed.length
          options_index: @options_index
          value: option.value
          text: option.text
          selected: option.selected
          disabled: ((group_disabled is true) ? group_disabled : option.disabled)
          group_array_index: group_position
      else
        @parsed.push
          array_index: @parsed.length
          options_index: @options_index
          empty: true
      @options_index += 1

SelectParser.select_to_array = (select) ->
  parser = new SelectParser()
  parser.add_node( child ) for child in select.childNodes
  parser.parsed
  
root.SelectParser = SelectParser

get_side_border_padding = (elmt) ->
  layout = new Element.layout(elmt)
  side_border_padding = layout.get("border-left") + layout.get("border-right") + layout.get("padding-left") + layout.get("padding-right")

root.get_side_border_padding = get_side_border_padding