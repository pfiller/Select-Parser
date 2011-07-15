(function() {
  var SelectParser, get_side_border_padding, root;
  root = typeof exports !== "undefined" && exports !== null ? exports : this;
  SelectParser = (function() {
    function SelectParser() {
      this.group_index = 0;
      this.sel_index = 0;
      this.parsed = [];
    }
    SelectParser.prototype.add_node = function(child) {
      if (child.nodeName === "OPTGROUP") {
        return this.add_group(child);
      } else {
        return this.add_option(child);
      }
    };
    SelectParser.prototype.add_group = function(group) {
      var group_id, option, _i, _len, _ref;
      group_id = this.sel_index + this.group_index;
      this.parsed.push({
        id: group_id,
        group: true,
        label: group.label,
        position: this.group_index,
        children: 0,
        disabled: group.disabled
      });
      _ref = group.childNodes;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        option = _ref[_i];
        this.add_option(option, group_id, group.disabled);
      }
      return this.group_index += 1;
    };
    SelectParser.prototype.add_option = function(option, group_id, group_disabled) {
      var _ref;
      if (option.nodeName === "OPTION") {
        if (option.text !== "") {
          if (group_id || group_id === 0) {
            this.parsed[group_id].children += 1;
          }
          this.parsed.push({
            id: this.sel_index + this.group_index,
            select_index: this.sel_index,
            value: option.value,
            text: option.text,
            selected: option.selected,
            disabled: (_ref = group_disabled === true) != null ? _ref : {
              group_disabled: option.disabled
            },
            group_id: group_id
          });
        } else {
          this.parsed.push({
            empty: true
          });
        }
        return this.sel_index += 1;
      }
    };
    return SelectParser;
  })();
  SelectParser.select_to_array = function(select) {
    var child, parser, _i, _len, _ref;
    parser = new SelectParser();
    _ref = select.childNodes;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      child = _ref[_i];
      parser.add_node(child);
    }
    return parser.parsed;
  };
  root.SelectParser = SelectParser;
  get_side_border_padding = function(elmt) {
    var layout, side_border_padding;
    layout = new Element.layout(elmt);
    return side_border_padding = layout.get("border-left") + layout.get("border-right") + layout.get("padding-left") + layout.get("padding-right");
  };
  root.get_side_border_padding = get_side_border_padding;
}).call(this);
