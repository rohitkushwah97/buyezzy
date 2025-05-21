# BuilderBase

`builder_base` is a gem that currently holds 3 responsibilities:
1. Rails engine classes (controllers, jobs, mailers, models, serializers) that all Ruby Blocks extend from.
2. Generators and scripts used by CDE during the assembly process to install blocks into apps.
3. Scripts used by blocks in CI pipelines to build and publish their own gem.

- [BuilderBase](#builderbase)
  - [Usage](#usage)
    - [Code Engine](#code-engine)
    - [Ruby Blocks](#ruby-blocks)
  - [CLI scripts](#cli-scripts)
    - [`create_builder_app`](#create_builder_app)
  - [Contributing](#contributing)
    - [Releasing](#releasing)
  - [License](#license)

## Usage

### Code Engine

1. `builder_base` is installed directly into the container image. In this mode it provides a set of CLI scripts to be used during assembly of client apps.
2. Included in the `Gemfile` of each client app. This provides the client app with a set of default gems -- see this project's `gemspec`.

### Ruby Blocks

`builder_base` is specified as a dependency in the gemspec, and the Rails classes in the block inherit from base classes defined in `BuilderBase`.


## CLI scripts
### `create_builder_app`

Creates a new Builder Ruby client app. `studio_pro` and `studio_store` types are supported -- the distinction being the version of Rails used to create a new app.

The `studio_type` parameter can be specified in one of two ways:

1. Via the `STUDIO_TYPE` ENV variable. Ex: `STUDIO_TYPE=studio_store create_builder_app`
2. Via the `--studio-type` command line argument. Ex. `create_builder_app --studio-type=studio_pro`

The command line argument overrides the ENV var, if one is specified.

If not specified, the default `studio_type` is `studio_pro`.

See `BuilderBase::RailsVersion` for details on which studio type maps to which Rails version.

The `--rails-version` argument can be used to force creating a new app with
a specific version of Rails regardless of the `studio-type`, e.g.:

    create_builder_app --rails-version 6.1.7.6

NOTE: The passed rails version must be between the minimum and maximum allowed by the policy encoded
in the `RailsVersion` class.

## Contributing

Follow trunk-based development.

### Releasing

Versioning is conforming to Semver. The version is managed by manually editing `lib/builder_base/version.rb`.

1. Stable releases triggered on master when:
    - Pushing (or, merging an MR with) changes which update the gem version number.
    - The version has a stable release format (MAJOR.MINOR.PATCH), eg. 1.0.3
    - No version tag exists for the new version number, eg. v1.0.3

2. Pre-releases triggered on branches following the convention release/MAJOR.MINOR.PATCH, when
    - Pushing (or, merging an MR with) changes which update the gem version number.
    - The version has a pre release format (MAJOR.MINOR.PATCH.pre.NUMBER), eg. 1.1.0.pre.7
    - No version tag exists for the new version number.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
