# Prettyp

One language formatter tool to rule them all.

## Why?
I didn't like having to remember:

```
pbpaste | xmllint --format -
cat log.json | python -m json.tool
```

Why not just have a tool to do them all.

## Installation

Install it yourself as:

    $ gem install prettyp

## Usage

```json
$ echo '{"foo": "lorem", "bar": "ipsum"}' | prettyp format
{
    "bar": "ipsum",
    "foo": "lorem"
}
```

```xml
$ pbpaste | prettyp format
<?xml version="1.0" encoding="UTF-8"?>
<note>
  <to>Tove</to>
  <from>Jani</from>
  <heading>Reminder</heading>
  <body>Don't forget me this weekend!</body>
</note>
```

```json
$ prettyp format --file test.json
{
    "bar": "ipsum",
    "foo": "lorem"
}
```

### Alfred
Ensure bash/zsh profile is loaded. Copies from clipboard and back to clipboard
```
source ~/.zshrc
pbpaste | prettyp format | pbcopy
```

## Contributing

1. Fork it ( https://github.com/dekz/prettyp/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## TODO support ignoring the language classifier
