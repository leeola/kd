

<!-- Start /Users/leeolayvar/projects/kdf/src/components/header/headerview.coffee -->

## exports

# KDHeaderView

KDHeaderView is a basic KDView to implement the
`<h1>`/`<h2>`/`<h3>`/etc DOM elements.

## Usage

```coffee
header = new KDHeaderView
  title: 'Header title!'
  type: 'big'

appView.addSubView header
```

## KDHeaderView(options, data)

Options supports the following keys:
- **options.title**: The contents for your header view.
- **options.type**: The level of your `H` element, represented in three
 options: `"big"`, `"medium"`, `"small"` which translates to `"h1"`,
 `"h2"`, ` "h3"` respectively.

### Params: 

* **Object** *options* 
* **Object** *data* 

## setTitle(title)

Set the title of this heaer element.

### Params: 

* **String** *title* The title you want to set your header to

## updateTitle(title)

Update the title for this header option. This can be used after you have
already set the title, to change it to another title.

### Params: 

* **String** *title* The title you want to update your header to

<!-- End /Users/leeolayvar/projects/kdf/src/components/header/headerview.coffee -->

