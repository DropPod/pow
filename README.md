# The `pow` Module #

This module provides basic tools for managing the installation of
[Pow](http://pow.cx/). This makes running [Rack](http://rack.github.com)
applications as simple as creating a symlink – or using `pow::application`
to do the dirty work for you.

## Example ##

``` puppet
if defined(pow::application) {
  pow::application { "/Users/${id}/Projects/myapp": name => "mapo" }
}
```
