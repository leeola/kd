

<!-- Start /Users/leeolayvar/projects/kdf/src/components/buttons/togglebutton.coffee -->

## exports

KDToggleButton is a KDButtonView that has a state of on or off, which can
be toggled.

## Usage

```coffee
view = new KDToggleButton
  defaultState: 'foo'
  states: [
    {title: 'foo', callback: -> @toggleState()}
    {title: 'bar', callback: -> @toggleState()}
  ]

appView.addSubView view
```

In this example we are creating a button with two states, `"foo"` and `"bar"`.
Each state in the `states` list is an object with varying properties, two of
which *(`title` and `callback`)* are required.

In this example, when a user clicks out ToggleButton, we use the method
toggleState to cycle through the states of the view.

## KDToggleButton(options, data)

Options supports the following keys:
- **options.defaultState**: The title of the default state that this
 button will use
  when rendered.
- **options.states**: A list of state objects, containing a `title` and
 `callback` key.
   - Example:
     ```
     [{title: 'State 1', callback: ->}, {title: 'State 2', callback: ->}]
     ```

### Params: 

* **Object** *options* 
* **Object** *data* 

## toggleState(err)

Cycle through the states of this button. Note that this supports any
number of states, not just two as the name implies.

### Params: 

* **Object** *err* An error object. If present, a warning with the  error details will be raised.

<!-- End /Users/leeolayvar/projects/kdf/src/components/buttons/togglebutton.coffee -->

