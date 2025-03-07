{
  libPre,
  inputs,
  ...
}:
libPre.extend (
  self: _: {
    nebula = import ./nebula {
      inherit inputs;
      lib = self;
    };
  }
)
