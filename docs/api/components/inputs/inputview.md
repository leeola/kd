

<!-- Start /Users/leeolayvar/projects/kdf/src/components/inputs/inputview.coffee -->

## exports

The base input field view. Similar to the classic `<input type="foo">`
element, but with additional options such as validation.

## Usage

```coffee
view = new KDInputView
  placeholder: 'Type something here for an inspiring message!'

view.on 'keyup', (e) ->
  if e.keyCode is 13 #13==Enter
    new KDNotificationView
      content: "You said #{e.target.value}!"

appView.addSubView view
```

Create a simple text input view, with a placeholder. When the `keyup`
event is fired, we check what the key is. If the keyCode is `13`
*(An Enter key)*, we create a notification with the value of the field.

## KDInputView(options, data)

Options supports the following keys.
- **options.type**: The type of this input. All html input types are
  supported. It should be noted that `"textarea"` and `"select"` do not
  create `<input>` elements, but rather they create `<textarea>` and
  `<select>` respectively.

  Supports the options `"text"`, `"password"`, `"hidden"`, `"checkbox"`,
  `"range"`, `"textarea"`, and `"select"`.
- **options.name**: The `name="foo"` attribute of this `<input>` element.
- **options.label**: The label instance for this input field.
- **options.defaultValue**: The default value for this instance.
- **options.placeholder**: The HTML5 placeholder for this input.
- **options.disabled**: Whether or not this input is disabled. Defaults to
  `false`
- **options.selectOptions**: If this input is of the type `"select"`, this
  list populates the select options. Defaults to `null`
- **options.validate**: An object containing validation options, which are
  passed to the KDInputValidator for this input. Note that the validator is
  created internally, you do not need to create it. Defaults to `null`
- **options.autogrow**: If the input type can grow, such as a `textarea`,
  this will cause the input to grow to the content size, rather than scroll.
  Defaults to `false`
- **options.bind**: A string of event names, separated by a space. Defaults
  to `" blur change focus"`
- **options.forceCase**: Force either uppercase, or lowercase for this field
  type. If `null`, case is not enforced. Supports the options: `"uppercase"`,
  `"lowercase"`, `null`

### Params: 

* **Object** *options* 
* **Object** *data* 

## makeDisabled()

Disable this input field.

## makeEnabled()

Enable this input field.

## getValue()

Get the value of this input field.

## setValue()

Set the value of this input field.

<!-- End /Users/leeolayvar/projects/kdf/src/components/inputs/inputview.coffee -->

