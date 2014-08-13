

<!-- Start /Users/leeolayvar/projects/kdf/src/core/view.coffee -->

## exports

KDView is the base class for all GUI components.

## Usage

```coffee
view = new KDView
  partial:    "I'm a view!"
  cssClass:  'foo'

appView.addSubView view
```

When rendered, this will display approximately:

```html
<div class="foo">I'm a view!</div>
```

## KDView(options, data)

Options supports the following keys.
- **options.tagName**: The name of the html tag. Defaults to `"div"`
- **options.domId**: The HTML ID of the element. `null`
- **options.cssClass**: The class string for the html element.
- **options.parent**: The parent KDView for this view.
- **options.partial**: The contents of this HTML element, such as `"Hello"`
  or `"<h1>Hello!</h1>"`.
- **options.pistachio**: A string of pistachio to add to the contents of this
  HTML element.
- **options.size**: An object with `width` and `height` properties
  representing the size of this view, in pixels. Example:
  ```
  {width: 10, height: 10}
  ```
- **options.position**: An object with top/right/bottom/left properties
  representing the css top/right/bottom/left offset properties. Example:
  ```
  {top: 5, left: 5}
  ```
- **options.attributes**: The HTML attributes for this view. These can be
  custom, or standard attributes such as `href` or `src`. Example:
  ```
  {href:"https://koding.com"}
  ```
- **options.tooltip**: Options that will be passed to the KDTooltip, which is
  internally created if options are specified.

### Params: 

* **Object** *options* 
* **Object** *data* 

## toggleClass()

Toggle the css class on the element.

## getBounds()

Get the bounds of this view.
## Returns

An object containing the x, y, width, height, and name of the view.

Example:

```coffee
{
  x: 10
  y: 10
  w: 50
  h: 50
  n: "HelloWorldView"
}
```

## hide()

Hide this view by applying the `hidden` css class to it.

## show()

If this class is hidden, show this view by removing the `hidden` css
class from it.

## addSubView(subView, selector, shouldPrepend)

Add another KDView to this KDView instance.

### Params: 

* **KDView** *subView* The view to add to this instance.
* **Object** *selector* 
* **Boolean** *shouldPrepend* Should the view being added be prepended, or appended, to this view's list of children.

FIX: NEEDS REFACTORING
      used in @destroy
      not always sub views stored in @subviews but in @items, @itemsOrdered etc
      see KDListView KDTreeView etc. and fix it.

<!-- End /Users/leeolayvar/projects/kdf/src/core/view.coffee -->

