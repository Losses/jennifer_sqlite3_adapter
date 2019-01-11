# Jennifer SQLite3 adapter

SQLite3 adapter for [Jennifer](https://github.com/imdrasil/jennifer.cr).

## Installation

1. Add the dependency to your `shard.yml`:
```yaml
dependencies:
  jennifer_sqlite3_adapter:
    github: imdrasil/jennifer_sqlite3_adapter
```
2. Run `shards install`

## Usage

This shard requires Jennifer `~> 0.7.0`.

```crystal
require "jennifer"
require "jennifer_sqlite3_adapter"
```

### Supported data types

| Method | SQLite3 | Crystal type |
| --- | --- | --- |
| `#bool` | `INTEGER` | `Bool` |
| `#integer` | `INTEGER` | `Int32` |
| `#bigint` | `INTEGER` | `Int32` |
| `#short` | `INTEGER` | `Int32` |
| `#tinyint` | `INTEGER` | `Int32` |
| `#float`| `REAL` | `Float64` |
| `#double` | `REAL` | `Float64` |
| `#real` | `REAL` | `Float64` |
| `#text` | `TEXT` | `String` |
| `#string` | `TEXT` | `String` |
| `#varchar` | `TEXT` | `String` |
| `#time` | `TEXT` | `Time` |
| `#timestamp` | `TEXT` | `Time` |

### Altering table

SQLite has no mechanism to alter existing table (except renaming it). Therefore operations, listed below, do multiple steps to achieve altering table: coping table schema to new temp table, coping data to new table, extending new table with required options, dropping old table and renaming temp table to original name:

- dropping column
- changing column
- adding foreign key
- dropping foreign key

It is necessary to notice that all those operations keep all data and indexes.

## Contributing

1. Fork it (<https://github.com/imdrasil/jennifer_sqlite3_adapter/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Roman Kalnytskyi](https://github.com/imdrasil) - creator and maintainer