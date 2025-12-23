{ inputs, role, ... }:

{
  _module.args = {
    inherit inputs role;
  };
}
