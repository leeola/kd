

<!-- Start /Users/leeolayvar/projects/kdf/src/components/inputs/hitenterinputview.coffee -->

todo:

  - on enter should validation fire by default??? Sinan - 6/6/2012

KDHitEnterInputView is convenience KDInputView. It creates a
simple input view and when the user presses enter, the callback is fired with
the value.

## Usage

```coffee
view = new KDHitEnterInputView
  type: 'text'
  name: 'enterinput'
  placeholder: 'Type something here, and hit enter!'
  callback: (value) ->
    new KDNotificationView
      content: "You wrote: #{value}"

appView.addSubView view
```

In this example we create an input text view. When the user presses enter in
your text field, a notification pops up with the string that the user wrote.

## KDHitEnterInputView(options, data)

Options supports the following keys.
- **options.type**: The type of this input field. Useful values are
  `"textarea"` and `"text"`. Defaults to `"textarea"`
- **options.callback**: A function, called when the user presses enter within
  the input field. Defaults to `null`

### Params: 

* **Object** *options* 
* **Object** *data* 

## enableEnterKey()

Enable the callback on enter key.

## disableEnterKey()

Disable the callback on enter key.

<!-- End /Users/leeolayvar/projects/kdf/src/components/inputs/hitenterinputview.coffee -->

