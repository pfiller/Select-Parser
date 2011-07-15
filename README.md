# SelectParser

A small class for turning an HTML select element into an array of javascript objects.

## Usage

Simply call:
 
    window.SelectParser.select_to_array( html_element )

And get back an ordered array of options:

    [
      # Groups
      {
        id: a unique identifier for the group,
        group: is a group (true|false),
        label: group label,
        position: index in the returned array,
        children: number of children in the group,
        disabled: group disabled state
      },
      
      # Options
      {
        id: a unique identifier for the option,
        select_index: index in the returned array,
        value: option value
        text: option text
        selected: option selected state
        disabled: option disabled state
        group_id: if the option is part of a group, the group id
      },
      
      # Blank Options
      {
        empty: true
      }
    ]
