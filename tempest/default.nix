{
  inputs,
  outputs,
  userinfo,
  hostname,
  ...
}:
{
  imports = [
    ./core
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager = {
    extraSpecialArgs = {
      inherit
        inputs
        outputs
        userinfo
        hostname
        ;
    };
    useGlobalPkgs = false;
    useUserPackages = true;
    users = {
      # Import your home-manager configuration
      ${userinfo.name} = import ./hm;
    };
  };
}
