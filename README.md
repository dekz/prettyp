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

```
pbpaste | prettyp format
cat test.json | prettyp format
prettyp format --file test.json
```

## Contributing

1. Fork it ( https://github.com/dekz/prettyp/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## TODO support ignoring the language classifier