

<!-- Start /Users/leeolayvar/projects/kdf/src/components/buttons/buttongroupview.coffee -->

## exports

# KDButtonGroupView

A view that creates buttons in a group.

## Usage

```coffee
view = new KDButtonGroupView
  buttons:
    "Button One!":
      cssClass: "clean-red"
      callback: ->
        new KDNotificationView
          content: "You clicked the red button, we're doomed!"
    "Button Two!"
      cssClass: "cupid-green"
      callback: ->
        new KDNotificationView
          content: "You clicked the green button, we're saved!"

appView.addSubView view
```

In this example we create a `KDButtonGroupView` and pass in a options object.
This buttons object has a key `"buttons"`, with the value of an object also.

Each key in the buttons object is a button title, and the value for that key is
the settings for that button. So, in the above example `"Button One!"` is the
title of a button, and the object within are settings passed directly to the
button being created.

`KDButtonGroupView` will take these button objects, and create instances of
KDButtonView for each one.

## KDButtonGroupView(options, data)

Options supports the following keys:
- **options.buttons**: An object containing settings for the
 KDButtonViews that KDButtonGroupView will create. Each key is the
 title of a button to be created, and the value is yet another object
 that will be given as options to the KDButtonView.

### Params: 

* **Object** *options* 
* **Object** *data* 

<!-- End /Users/leeolayvar/projects/kdf/src/components/buttons/buttongroupview.coffee -->

