# Interpol
> A class for interpolating object properties with support for moving targets

## How to use

Read the doc generated!

Old:

Create a new interpol with `Interpol.new()` and setup each property interpolation by calling `interpol.interpolate_property(...)`. After setting up the interpolations, use the `play()` method to enable the interpolation to be advanced and do so by using the `advance()` method.

## Sequencing and parallelism

Use the `track` parameter in the `interpolate_property(...)`.
