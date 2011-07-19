# SelectParser

A small class for turning an HTML select element into an array of javascript objects.

## Usage

Simply call:
 
    window.SelectParser.select_to_array( html_element )

And get back an ordered array of options:

    [
      # Groups
      {
        array_index: index in the returned array
        children: number of children in the group
        disabled: group disabled state
        group: is a group (true|false)
        label: group label
      },
      
      # Options
      {
        array_index: index in the returned array
        disabled: option disabled state
        group_array_index: if the option is part of a group, the group's index in the returned array
        options_index: index in the form options array
        selected: option selected state
        text: option text
        value: option value
      },
      
      # Blank Options
      {
        array_index: index in the returned array
        empty: true
        options_index: index in the form options array
      }
    ]