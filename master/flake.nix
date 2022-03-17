{
  description = ''Extensible bit vector integer encoding library'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-bitvec-master.flake = false;
  inputs.src-bitvec-master.owner = "keyme";
  inputs.src-bitvec-master.ref   = "refs/heads/master";
  inputs.src-bitvec-master.repo  = "nim_bitvec";
  inputs.src-bitvec-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-bitvec-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-bitvec-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}