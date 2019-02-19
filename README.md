## Starbound Colorpicker

A simple library for creating stateful colorpicker objects in starbound.

### Usage

In the interface config file:
```json
"gui": : {
    ...
    "mywidget" : {
        "type" : "canvas",
        "rect" : [0, 0, 1, 1], //can be anything only the position generated is needed
        "captureMouseEvents" : true
    }
    ...
}
...
"canvasClickCallbacks" : {
    "mywidget" : "some_name"
}
```

In your script:
```lua
require"/scripts/colorpicker/widget.lua"
function init()
    self.picker = colorpicker.new"mywidget"
    ...
end

function update()
    self.picker:update()
    ...
end
```

### API

#### require"/scripts/colorpicker/widget.lua"
> Loads the colorpicker module.

#### `colorpicker` colorpicker.new(name)
> Creates a new `colorpicker` object from the given widget name string `name`.

#### `void` colorpicker.update(c)
> Updates the color in the `colorpicker`.
> This should be called inside the script's `update` hook.
>
> Can also be called as a method from a `colorpicker` i.e `picker:update()`.

#### `integer` colorpicker.red(c)
> Returns the red channel value for the given `colorpicker`.
>
> Can also be called as a method from a `colorpicker` i.e `picker:red()`.

#### `integer` colorpicker.green(c)
> Returns the green channel value for the given `colorpicker`.
>
> Can also be called as a method from a `colorpicker` i.e `picker:green()`.

#### `integer` colorpicker.blue(c)
> Returns the blue channel value for the given `colorpicker`.
>
> Can also be called as a method from a `colorpicker` i.e `picker:blue()`.

#### `table<integer>` colorpicker.rgb(c)
> Returns the RGB table representation of the current color.
>
> Can also be called as a method from a `colorpicker` i.e `picker:rgb()`.

#### `{integer, integer, integer}` colorpicker.hex(c)
> Returns the hexadecimal number representation of the current color.
> Lit. `("%06x"):format(c.selected)`.
>
> Can also be called as a method from a `colorpicker` i.e `picker:hex()`.

#### `integer` picker.selected
> The currently selected color.

#### `Canvas` picker.wid
> The underlying canvas widget used by the colorpicker.

#### `{number, number}` picker.mouse
> The mouse coordinates (relative) for the selected color.
