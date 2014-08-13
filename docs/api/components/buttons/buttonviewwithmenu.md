

<!-- Start /Users/leeolayvar/projects/kdf/src/components/buttons/buttonviewwithmenu.coffee -->

## exports

This view is a Button, with a dropdown menu.

## Usage

```coffee
view = new KDButtonViewWithMenu
  title: 'Button Title'
  menu:
    'Menu Item 1':
      callback: ->
        new KDNotificationView
          content: 'Item 1 Callback'

    'Menu Item 2':
      callback: ->
        new KDNotificationView
          content: 'Item 2 Callback'

  callback: ->
    new KDNotificationView
      content: 'Button Callback'

appView.addSubView view
```

Welcome to callback city! This can be broken down into two main parts.

First up, lets look at the button itself. Just like a normal
KDButtonView, KDButtonViewWithMenu has a `title` and `callback`
option. The do exactly the same thing; set the name of the button and the
callback when the button is pressed.

Next, we have a `menu` object. Each key in this object is the name of a menu
item. Each object within, supports a callback keyword.

## Options

Options supports the following keys:
- **options.title**: The title of this button
- **options.callback**: The callback function called when the button is
 pressed.
- **options.menu**: An object containing menu items and callbacks. Each key
 is the menu item name, and the value of the key is an object with a
 callback key/value pair.

<!-- End /Users/leeolayvar/projects/kdf/src/components/buttons/buttonviewwithmenu.coffee -->

